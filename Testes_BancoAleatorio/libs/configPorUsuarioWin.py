import os


MYCOMMERCE_DIR = os.path.join(r"C:\Visual Software\MyCommerce")
EXECUTAVEL = os.path.join(MYCOMMERCE_DIR, "myCommerce.exe")

USUARIO_PARA_NUMERO = {
    "viniciusjesus": 1,
    "kaina": 2,
    "cassio": 3,
    "viniciusmerlak": 4,
    "eduarda": 5,
    "thiagocesar": 6,
    "gabriel": 7,
    "felipe dos santos": 8,
}


def get_comando_mycommerce():
    """Retorna o comando para abrir o MyCommerce.

    Mapeia o usuario Windows para um numero e verifica se existe
    o arquivo Config<numero>.ini na pasta do MyCommerce.
    Caso contrario, retorna apenas o caminho do executavel.
    """
    usuario = os.getenv("USERNAME", "").strip().lower()
    numero = USUARIO_PARA_NUMERO.get(usuario)
    if numero is not None:
        config_ini = f"Config{numero}.ini"
        config_path = os.path.join(MYCOMMERCE_DIR, config_ini)
        if os.path.exists(config_path):
            return f"{EXECUTAVEL} /{config_ini}"
    return EXECUTAVEL
