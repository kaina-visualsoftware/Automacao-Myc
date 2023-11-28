import mysql.connector
import leituraConfig as config

dbname = config.config.Database
porta = config.config.Porta
connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database=dbname, port=porta)
cursor = connection.cursor()

class verificacoesExtras:

    def verifica_Forma_Parcelamento_Cliente(self, codigo_Cliente):

        cursor.execute("SELECT fp.Personalizavel, fp.NPagamentos, fp.ComEntrada FROM formaparcelamento AS fp INNER JOIN clientes AS c ON fp.Codigo = c.IDFormaParcelamento AND c.Codigo = "+ str(codigo_Cliente) +";")

        formaParcelamentoCliente = cursor.fetchall()

        if not formaParcelamentoCliente:
            return 'Sem Forma Parcelamento do Cliente'
        else:
            if formaParcelamentoCliente[0][0] == 1:
                return 'Personalizada'
            elif formaParcelamentoCliente[0][1] > 0:
                return 'Prazo'
            elif formaParcelamentoCliente[0][2] == 1:
                return 'A Vista'
            else:
                return 'Agora Fudeo'

# verificacoesExtras.verifica_Forma_Parcelamento_Cliente(312805)