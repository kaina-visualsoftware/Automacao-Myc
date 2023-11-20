class config:
    def leituraConfig():

            with open("C:\Visual Software\MyCommerce\Config.ini", "r") as config:
                linhas = config.readlines()

            databaseConfig = [linha.strip() for linha in linhas if linha.startswith("Database=")]
            PortaConfig = [linha.strip() for linha in linhas if linha.startswith("PortaServidor=")]

            database = str(databaseConfig).split("=")

            database = database[1].split("'")

            porta = str(PortaConfig).split("=")
            porta = porta[1].split("'")

            return database[0], porta[0]

    Database, Porta = leituraConfig()