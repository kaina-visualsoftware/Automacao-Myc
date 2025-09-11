import subprocess
import sys
import os
import threading
import shutil
from pathlib import Path
from datetime import datetime
from collections import defaultdict
import ctypes

def _is_admin() -> bool:
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except Exception:
        return False

def _relaunch_as_admin():

    params = " ".join(f'"{arg}"' for arg in sys.argv)
    ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, params, None, 1)

sys.path.append(r"C:\Automacao\automacao-mycommerce\Testes_BancoAleatorio\libs")

class _SilentStdout:
    def write(self, *_): pass
    def flush(self): pass

_stdout_backup = sys.stdout
sys.stdout = _SilentStdout()
try:
    import leituraConfig as config
finally:
    sys.stdout = _stdout_backup

BASE_DIR = Path(r"C:\Automacao\automacao-mycommerce")
PROJETO_DIR = BASE_DIR / "Testes_BancoAleatorio"
TESTS_ROOT = PROJETO_DIR / "TestsCases"
RELATORIOS_DIR = BASE_DIR / "Relatorios"

LOGIN_TEST = "Teste_LoginSistema1.robot"
LOGIN_RETRY_ON_FAIL = 1

ROBOT_BIN = "robot"

ROBOT_FLAGS = [
    "--report", "report.html",
    "--log", "log.html",
    "--output", "output.xml",
]

ERP_PROCESSES = [
    "myCommerce.exe",
    "Mycommerce_AutoUpdate.exe",
]

def force_close_erp(timeout_seconds: int = 5):

    import time

    def _kill(image):
        try:
            r = subprocess.run(
                ["taskkill", "/IM", image, "/F", "/T"],
                capture_output=True,
                text=True,
                timeout=15,
                shell=False,
            )
        except Exception:
            pass

    _kill("myCommerce.exe")
    time.sleep(1.0)

    _kill("Mycommerce_AutoUpdate.exe")
    time.sleep(timeout_seconds)


MIN_WIDTH = 60

def list_robot_files(root: Path):
    return sorted(root.rglob("*.robot"))

def log(msg: str):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{now}] {msg}")

# def write_overview_summary_pretty(summary_dict, destino_path: Path):
#     with destino_path.open("w", encoding="utf-8") as f:
#         f.write(f"=== Execução {datetime.now():%Y-%m-%d %H:%M:%S} ===\n\n")
#         for rel_file in sorted(summary_dict.keys()):
#             base = Path(rel_file).name
#             casos = summary_dict[rel_file]
#             f.write(f">> {base}\n\n")
#             if not casos:
#                 f.write("   (sem casos detectados)\n\n")
#                 continue
#             max_name_len = max(len(nome) for (nome, _status) in casos)
#             target_width = max(MIN_WIDTH, 3 + max_name_len + 1)
#             for (nome, status) in casos:
#                 left = f"   {nome} "
#                 dashes = "-" * max(1, target_width - len(left))
#                 f.write(f"{left}{dashes} {status}\n")
#             f.write("\n")

def write_overview_summary_pretty(summary_dict, destino_path: Path):

    login_key = LOGIN_TEST
    keys = list(summary_dict.keys())

    ordered = []
    if login_key in keys:
        ordered.append(login_key)
    ordered += sorted(k for k in keys if k != login_key)

    with destino_path.open("w", encoding="utf-8") as f:
        f.write(f"=== Execução {datetime.now():%Y-%m-%d %H:%M:%S} ===\n\n")
        for rel_file in ordered:
            base = Path(rel_file).name
            casos = summary_dict[rel_file]
            f.write(f">> {base}\n\n")
            if not casos:
                f.write("   (sem casos detectados)\n\n")
                continue
            max_name_len = max(len(nome) for (nome, _status) in casos)
            target_width = max(MIN_WIDTH, 3 + max_name_len + 1)
            for (nome, status) in casos:
                left = f"   {nome} "
                dashes = "-" * max(1, target_width - len(left))
                f.write(f"{left}{dashes} {status}\n")
            f.write("\n")

def _normalize_filters():
    import re, socket
    ansi_re = re.compile(r"\x1B\[[0-?]*[ -/]*[@-~]")

    def normalize(s: str) -> str:
        s = ansi_re.sub("", s)
        s = " ".join(s.split())
        return s.strip().lower()

    def contains_token(s_norm: str, token_norm: str) -> bool:
        parts = s_norm.replace(":", " ").split()
        return any(p == token_norm for p in parts)

    try:
        machine = os.getenv("COMPUTERNAME") or socket.gethostname()
    except Exception:
        machine = "MACHINE"
    dbname = str(getattr(config.config, "Database", "DESCONHECIDO"))
    dbport = str(getattr(config.config, "Porta", "DESCONHECIDO"))
    dbhost = str(getattr(config.config, "IpServidor", "DESCONHECIDO"))

    return {
        "ansi_re": ansi_re,
        "normalize": normalize,
        "contains_token": contains_token,
        "machine_norm": normalize(machine),
        "db_prefix": "nome do banco de dados:",
        "port_prefix": "porta do servidor:",
        "ip_prefix": "ip do servidor:",
        "suppress_prefixes": ("output:", "log:", "report:"),
    }

def _move_sikuli_artifacts_to(sources: list[Path], sikuli_dir: Path):

    for base in sources:
        if not base.exists():
            continue

        src_cap = base / "sikuli_captured"
        if src_cap.exists():
            dst_cap = sikuli_dir / "sikuli_captured"
            if dst_cap.exists():
                shutil.rmtree(dst_cap, ignore_errors=True)
            try:
                shutil.move(str(src_cap), str(dst_cap))
            except Exception:
                pass

        for p in base.glob("Sikuli_java_stdout*"):
            try:
                shutil.move(str(p), str(sikuli_dir / p.name))
            except Exception:
                pass
        for p in base.glob("Sikuli_java_stderr*"):
            try:
                shutil.move(str(p), str(sikuli_dir / p.name))
            except Exception:
                pass

def get_test_names(robot_file: Path) -> list[str]:

    names = []
    in_tests = False
    try:
        with robot_file.open("r", encoding="utf-8-sig") as f:
            for line in f:
                raw = line.rstrip("\n")
                stripped = raw.strip()
                low = stripped.lower()
                if low.startswith("***") and "test case" in low:
                    in_tests = True
                    continue
                if in_tests and low.startswith("***"):
                    break
                if in_tests:
                    if not stripped or stripped.startswith("#") or stripped.startswith("..."):
                        continue

                    if raw[:1].isspace():
                        continue
                    names.append(stripped)
    except Exception:
        pass
    return names

def run_robot(test_file: Path, session_dir: Path, test_name: str | None = None, robot_bin: str | None = None, robot_flags: list[str] | None = None):

    import threading

    rb = robot_bin or globals().get("ROBOT_BIN", "robot")
    flags = robot_flags or globals().get("ROBOT_FLAGS", [])

    final_dir = session_dir / "Resultados Finais"
    final_dir.mkdir(parents=True, exist_ok=True)
    sikuli_dir = session_dir / "sikuli_java"
    sikuli_dir.mkdir(parents=True, exist_ok=True)

    out_combined_path = sikuli_dir / "output"
    out_stdout_path   = sikuli_dir / "Sikuli_java_stdout"
    out_stderr_path   = sikuli_dir / "Sikuli_java_stderr_"

    cmd = [rb, *flags, "--outputdir", str(final_dir)]
    if test_name:
        cmd += ["--test", test_name]
    cmd.append(str(test_file))

    f = _normalize_filters()
    ansi_re = f["ansi_re"]
    normalize = f["normalize"]
    contains_token = f["contains_token"]
    machine_norm = f["machine_norm"]
    db_prefix = f["db_prefix"]
    port_prefix = f["port_prefix"]
    ip_prefix = f["ip_prefix"]
    SUPPRESS_PREFIXES = f["suppress_prefixes"]

    proc = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        bufsize=1,
        universal_newlines=True,
    )

    def reader(stream, is_stderr: bool):
        target_file = out_stderr_path if is_stderr else out_stdout_path
        with target_file.open("a", encoding="utf-8") as f_target, \
             out_combined_path.open("a", encoding="utf-8") as f_combined:
            for line in stream:
                raw = line.rstrip("\n")
                norm = normalize(raw)

                if any(norm.startswith(p) for p in SUPPRESS_PREFIXES):
                    continue
                if contains_token(norm, machine_norm):
                    continue
                if norm.startswith(db_prefix) or norm.startswith(port_prefix) or norm.startswith(ip_prefix):
                    continue
                stripped_no_ansi = ansi_re.sub("", raw).strip()
                if stripped_no_ansi and set(stripped_no_ansi) <= {"-"} and len(stripped_no_ansi) >= 5:
                    continue

                f_target.write(line)
                f_combined.write(line)
                if not is_stderr:
                    print(line, end="")

    t_out = threading.Thread(target=reader, args=(proc.stdout, False), daemon=True)
    t_err = threading.Thread(target=reader, args=(proc.stderr, True), daemon=True)
    t_out.start()
    t_err.start()

    rc = proc.wait()
    t_out.join()
    t_err.join()

    try:
        outxml = final_dir / "output.xml"
        if outxml.exists():
            outxml.unlink()
    except Exception:
        pass

    _move_sikuli_artifacts_to([final_dir, session_dir, Path.cwd(), PROJETO_DIR, test_file.parent], sikuli_dir)

    return rc, final_dir

def main():

    session_dir = RELATORIOS_DIR / datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    session_dir.mkdir(parents=True, exist_ok=True)

    final_dir = session_dir / "Resultados Finais"
    final_dir.mkdir(parents=True, exist_ok=True)
    sikuli_dir = session_dir / "sikuli_java"
    sikuli_dir.mkdir(parents=True, exist_ok=True)

    terminal_path = final_dir / "terminal.txt"
    suite_results_path = final_dir / "test_suite_results.txt"

    class Tee:
        def __init__(self, *files):
            self.files = files
        def write(self, obj):
            for f in self.files:
                f.write(obj)
                f.flush()
        def flush(self):
            for f in self.files:
                f.flush()

    log_file = open(terminal_path, "w", encoding="utf-8")
    sys_stdout_orig = sys.stdout
    sys.stdout = Tee(sys.stdout, log_file)

    print("="*50)
    print("INICIANDO EXECUÇÃO AUTOMÁTICA DOS CASOS DE TESTE")
    print("="*50)
    print(f"{os.getenv('COMPUTERNAME', 'MACHINE')}")
    print(f"Nome do banco de dados: {getattr(config.config, 'Database', 'DESCONHECIDO')}")
    print(f"Porta do servidor: {getattr(config.config, 'Porta', 'DESCONHECIDO')}")
    print(f"IP do servidor: {getattr(config.config, 'IpServidor', 'DESCONHECIDO')}")
    print("-"*50)

    all_tests = list_robot_files(TESTS_ROOT)
    login_test_path = next((t for t in all_tests if t.name == LOGIN_TEST), None)
    other_tests = [t for t in all_tests if t.name != LOGIN_TEST]

    summary_per_file = defaultdict(list)

    try:

        if login_test_path:
            print(f"====== Executando login inicial: {LOGIN_TEST} ======")
            log(f"Executando: {login_test_path.name}")
            rc, _ = run_robot(login_test_path, session_dir, test_name=None)

            summary_per_file[login_test_path.name].append(("Login inicial", "PASS" if rc == 0 else "FAIL"))
            write_overview_summary_pretty(summary_per_file, suite_results_path)
            if rc != 0:
                log("Login inicial falhou, encerrando execução.")
                return
        else:
            print(f"Arquivo de login {LOGIN_TEST} não encontrado.")
            return

        for robot_file in other_tests:
            print(f"\n====== Executando arquivo: {robot_file.name} ======")
            log(f"Listando casos do arquivo: {robot_file.name}")

            test_names = get_test_names(robot_file)

            if not test_names:

                rc, _ = run_robot(robot_file, session_dir, test_name=None)
                status = "PASS" if rc == 0 else "FAIL"
                summary_per_file[robot_file.name].append((robot_file.stem, status))
                write_overview_summary_pretty(summary_per_file, suite_results_path)

                if rc != 0 and login_test_path:
                    print(f"-- Arquivo falhou. Reexecutando login: {LOGIN_TEST} --")

                    force_close_erp()

                    retries = LOGIN_RETRY_ON_FAIL
                    while retries >= 0:
                        rc_login, _ = run_robot(login_test_path, session_dir, test_name=None)

                        # summary_per_file[login_test_path.name].append(("Login (reset)", "PASS" if rc_login == 0 else "FAIL"))
                        write_overview_summary_pretty(summary_per_file, suite_results_path)
                        if rc_login == 0:
                            break
                        retries -= 1

                continue


            for tn in test_names:
                print(f"--- Executando caso: {tn} ---")
                rc, _ = run_robot(robot_file, session_dir, test_name=tn)
                status = "PASS" if rc == 0 else "FAIL"
                summary_per_file[robot_file.name].append((tn, status))
                write_overview_summary_pretty(summary_per_file, suite_results_path)

                if rc != 0 and login_test_path:
                    print(f"-- Caso falhou. Reexecutando login: {LOGIN_TEST} --")

                    force_close_erp()

                    retries = LOGIN_RETRY_ON_FAIL
                    while retries >= 0:
                        rc_login, _ = run_robot(login_test_path, session_dir, test_name=None)

                        # summary_per_file[login_test_path.name].append(("Login (reset)", "PASS" if rc_login == 0 else "FAIL"))
                        write_overview_summary_pretty(summary_per_file, suite_results_path)
                        if rc_login == 0:
                            break
                        retries -= 1

    finally:

        try:
            sys.stdout = sys_stdout_orig
        finally:
            try:
                log_file.flush()
                log_file.close()
            except Exception:
                pass

    print(f"\nExecução finalizada. Resultados em: {final_dir}")

if __name__ == "__main__":
    if not _is_admin():
        _relaunch_as_admin()
        sys.exit(0)
    main()