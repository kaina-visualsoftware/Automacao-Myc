import socket

class config:
    def leituraConfig():

            # Abrindo o arquivo de configuração
            with open("C:\Visual Software\MyCommerce\Config.ini", "r") as config:
                linhas = config.readlines()

            # Filtrando as linhas relevantes
            databaseConfig = [linha.strip() for linha in linhas if linha.startswith("Database=")]
            PortaConfig = [linha.strip() for linha in linhas if linha.startswith("PortaServidor=")]
            ipServidorConfig = [linha.strip() for linha in linhas if linha.startswith("IPServidor=")]

            # Extraindo o valor do banco de dados
            database = str(databaseConfig).split("=")
            database = database[1].split("'")

            # Extraindo o valor da porta
            porta = str(PortaConfig).split("=")
            porta = porta[1].split("'")

            # Extraindo o valor do ip do servidor
            ipServidor = str(ipServidorConfig).split("=")
            ipServidor = ipServidor[1].split("'")

            # Imprimindo as informações extraídas do arquivo de configuração
            print(f"Nome do banco de dados: {database[0]}")
            print(f"Porta do servidor: {porta[0]}")
            print(f"IP do servidor: {ipServidor[0]}")

            return database[0], porta[0], ipServidor[0]

    # Obtendo o nome do terminal
    terminal_name = socket.gethostname()
    # Obtendo o banco de dados, a porta e o ip retornados pelo método
    Database, Porta, IpServidor = leituraConfig()