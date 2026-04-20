import os


MYCOMMERCE_DIR = os.path.join(r"C:\Visual Software\MyCommerce")
EXECUTAVEL = os.path.join(MYCOMMERCE_DIR, "myCommerce.exe")


def get_comando_mycommerce():
    """Retorna o comando para abrir o MyCommerce.

    Se existir um arquivo Config<usuario_windows>.ini na pasta do MyCommerce,
    retorna o executavel com o parametro /Config<usuario>.ini.
    Caso contrario, retorna apenas o caminho do executavel.

    Usa o nome de exibicao do usuario Windows (USERNAME).
    Ex.: USERNAME='Felipe dos Santos' -> ConfigFelipe dos Santos.ini
    """
    usuario = os.getenv("USERNAME", "").strip()
    if usuario:
        config_ini = f"Config{usuario}.ini"
        config_path = os.path.join(MYCOMMERCE_DIR, config_ini)
        if os.path.exists(config_path):
            return f"{EXECUTAVEL} /{config_ini}"
    return EXECUTAVEL
