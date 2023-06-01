import mysql.connector

class verificaInclusaoProduto:

    def verifica_Produto_Incluiu_Correto(self, nomeTela, codProduto, codOperacao):

        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database='bdvinicius')
        cursor = connection.cursor()
        consultaProdutos = "SELECT codigo, Descricao, vendaT1 FROM produtos WHERE Codigo = "+codProduto

        if connection.is_connected(): 

            if nomeTela == "Orcamentos": 

                consultaOrcProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaProdutos)
                tabelaProdutos = cursor.fetchall()

                cursor.execute(consultaOrcProdutos)
                tabelaOrcamentoProdutos = cursor.fetchall()

                comparacao = tabelaProdutos == tabelaOrcamentoProdutos

                return comparacao
            

        
