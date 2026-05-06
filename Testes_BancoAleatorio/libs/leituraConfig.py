import os
import socket
from pathlib import Path

from usuarios import USUARIO_PARA_NUMERO


MYCOMMERCE_DIR = Path(r"C:\Visual Software\MyCommerce")


def _resolve_config_path() -> Path:
    username = os.getenv("USERNAME", "").strip().lower()
    numero = USUARIO_PARA_NUMERO.get(username)
    if numero is not None:
        config_usuario = MYCOMMERCE_DIR / f"Config{numero}.ini"
        if config_usuario.exists():
            return config_usuario
    return MYCOMMERCE_DIR / "Config.ini"


class config:
    def leituraConfig():
        config_path = _resolve_config_path()

        with config_path.open("r", encoding="utf-8", errors="ignore") as arquivo_config:
            linhas = arquivo_config.readlines()

        dados = {}
        for linha in linhas:
            if "=" not in linha:
                continue
            chave, valor = linha.strip().split("=", 1)
            dados[chave.strip()] = valor.strip()

        database = dados.get("Database", "")
        porta = dados.get("PortaServidor", "")
        ip_servidor = dados.get("IPServidor", "")

        print(f"Arquivo de configuracao: {config_path}")
        print(f"Nome do banco de dados: {database}")
        print(f"Porta do servidor: {porta}")
        print(f"IP do servidor: {ip_servidor}")

        return database, porta, ip_servidor

    terminal_name = socket.gethostname()
    print(terminal_name)
    ArquivoConfig = str(_resolve_config_path())
    Database, Porta, IpServidor = leituraConfig()