import mysql.connector

class verificaProduto:   

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
            elif nomeTela == "Vendas":

                return
            elif nomeTela == "OS":

                return
            elif nomeTela == "Condicional":

                return
            elif nomeTela == "Pedidos":

                return
    
        cursor.close()
        connection.close()
            
    def verifica_valor_desconto(self, nomeTela, codProduto, codOperacao):
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database='bdvinicius')
        cursor = connection.cursor()
        consultaProdutos = "SELECT vendaT1 FROM produtos WHERE Codigo = "+codProduto
        cursor.execute(consultaProdutos)
        tabelaProdutos = cursor.fetchall()
        valorProduto = tabelaProdutos[0][0]

        if connection.is_connected():

            if nomeTela == "Orcamentos": 
                valoresOrc = "SELECT ValorTotal, Desconto FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresOrc)
                tabelaOrcProdutos = cursor.fetchall()
                percDesconto = tabelaOrcProdutos[0][1]

                percDesconto = percDesconto / 100

                valorCalculo = round((valorProduto - (valorProduto * percDesconto)), 2)

                valorTotalProd = float(tabelaOrcProdutos[0][0])

                comparacao = valorCalculo == valorTotalProd

                return comparacao
            elif nomeTela == "Vendas":
                valoresVenda = "SELECT ValorTotal, Desconto FROM vendasprodutos AS orp WHERE orp.CodigoVenda = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaVendaProdutos = cursor.fetchall()
                percDesconto = tabelaVendaProdutos[0][1]

                percDesconto = percDesconto / 100

                valorCalculo = round((valorProduto - (valorProduto * percDesconto)), 2)

                valorTotalProd = float(tabelaVendaProdutos[0][0])

                comparacao = valorCalculo == valorTotalProd

                return comparacao
            elif nomeTela == "OS":

                return
            elif nomeTela == "Condicional":

                return
            elif nomeTela == "Pedidos":

                return

        cursor.close()
        connection.close()

    def verifica_valor_acrescimo(self, nomeTela, codProduto, codOperacao):
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database='bdvinicius')
        cursor = connection.cursor()
        consultaProdutos = "SELECT vendaT1 FROM produtos WHERE Codigo = "+codProduto
        cursor.execute(consultaProdutos)
        tabelaProdutos = cursor.fetchall()
        valorProduto = tabelaProdutos[0][0]

        if connection.is_connected():

            if nomeTela == "Orcamentos": 
                valoresOrc = "SELECT ValorTotal, Acrescimo FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresOrc)
                tabelaOrcProdutos = cursor.fetchall()
                percAcrescimo = tabelaOrcProdutos[0][1]

                percAcrescimo = percAcrescimo / 100

                valorCalculo = round((valorProduto + (valorProduto * percAcrescimo)), 2)

                valorTotalProd = float(tabelaOrcProdutos[0][0])

                comparacao = valorCalculo == valorTotalProd

                return comparacao          
            elif nomeTela == "Vendas":
                valoresVenda = "SELECT ValorTotal, Acrescimo FROM vendasprodutos AS orp WHERE orp.CodigoVenda = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaVendaProdutos = cursor.fetchall()
                percAcrescimo = tabelaVendaProdutos[0][1]

                percAcrescimo = percAcrescimo / 100

                valorCalculo = round((valorProduto + (valorProduto * percAcrescimo)), 2)

                valorTotalProd = float(tabelaVendaProdutos[0][0])

                comparacao = valorCalculo == valorTotalProd

                return comparacao