import mysql.connector

class verificaProduto:   

    def conexao_banco():
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database='bdvinicius')
        cursor = connection.cursor()

        return connection, cursor

    def verifica_Produto_Incluiu_Correto(self, nomeTela, codProduto, codOperacao):
        connection, cursor = verificaProduto.conexao_banco()
        consultaProdutos = "SELECT codigo, Descricao, vendaT1 FROM produtos WHERE Codigo = "+codProduto
        cursor.execute(consultaProdutos)
        tabelaProdutos = cursor.fetchall()

        if connection.is_connected(): 

            if nomeTela == "Orcamentos": 

                consultaOrcProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" AND orp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaOrcProdutos)
                consultaOperacaoProduto = cursor.fetchall()

            elif nomeTela == "Vendas":

                consultaVendaProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'VP' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaVendaProdutos)
                consultaOperacaoProduto = cursor.fetchall()

            elif nomeTela == "OS":

                consultaVendaProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'OS' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaVendaProdutos)
                consultaOperacaoProduto = cursor.fetchall()

            elif nomeTela == "Condicional":

                consultaOrcProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM condicionaisprodutos AS cp WHERE cp.CodigoCondicional = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaOrcProdutos)
                consultaOperacaoProduto = cursor.fetchall()

            elif nomeTela == "Pedidos":

                consultaPedidosProdutos = "SELECT codigoProduto, Descricao, ValorUnitario FROM pedidosvendaprodutos AS pvp WHERE pvp.CodigoPedido = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaPedidosProdutos)
                consultaOperacaoProduto = cursor.fetchall()
    
        comparacao = tabelaProdutos == consultaOperacaoProduto

        cursor.close()
        connection.close()

        return comparacao
            
    def verifica_valor_desconto(self, nomeTela, codProduto, codOperacao):
        connection, cursor = verificaProduto.conexao_banco()
        consultaProdutos = "SELECT vendaT1 FROM produtos WHERE Codigo = "+codProduto
        cursor.execute(consultaProdutos)
        tabelaProdutos = cursor.fetchall()
        valorProduto = tabelaProdutos[0][0]

        if connection.is_connected():

            if nomeTela == "Orcamentos": 

                valoresOrc = "SELECT ValorTotal, Desconto FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" AND orp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresOrc)
                tabelaOperacaoProdutos = cursor.fetchall()

            elif nomeTela == "Vendas":

                valoresVenda = "SELECT ValorTotal, Desconto FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'VP' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaOperacaoProdutos = cursor.fetchall()
                
            elif nomeTela == "OS":

                valoresVenda = "SELECT ValorTotal, Desconto FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'OS' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaOperacaoProdutos = cursor.fetchall()

            elif nomeTela == "Condicional":

                consultaOrcProdutos = "SELECT ValorTotal, Desconto FROM condicionaisprodutos AS cp WHERE cp.CodigoCondicional = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaOrcProdutos)
                tabelaOperacaoProdutos = cursor.fetchall()

            elif nomeTela == "Pedidos":

                consultaPedidosProdutos = "SELECT ValorTotal, Desconto FROM pedidosvendaprodutos AS pvp WHERE pvp.CodigoPedido = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaPedidosProdutos)
                tabelaOperacaoProdutos = cursor.fetchall()


        percDesconto = tabelaOperacaoProdutos[0][1]
        percDesconto = percDesconto / 100

        valorCalculo = round((valorProduto - (valorProduto * percDesconto)), 2)

        valorTotalProd = float(tabelaOperacaoProdutos[0][0])

        comparacao = valorCalculo == valorTotalProd

        cursor.close()
        connection.close()

        return comparacao

    def verifica_valor_acrescimo(self, nomeTela, codProduto, codOperacao):
        connection, cursor = verificaProduto.conexao_banco()
        consultaProdutos = "SELECT vendaT1 FROM produtos WHERE Codigo = "+codProduto
        cursor.execute(consultaProdutos)
        tabelaProdutos = cursor.fetchall()
        valorProduto = tabelaProdutos[0][0]

        if connection.is_connected():

            if nomeTela == "Orcamentos": 

                valoresOrc = "SELECT ValorTotal, Acrescimo FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresOrc)
                tabelaOperacaoProdutos = cursor.fetchall()
                          
            elif nomeTela == "Vendas":

                valoresVenda = "SELECT ValorTotal, Acrescimo FROM vendasprodutos AS orp WHERE orp.CodigoVenda = "+str(codOperacao)+" ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaOperacaoProdutos = cursor.fetchall()
            

        tabelaOperacaoProdutos = cursor.fetchall()
        percAcrescimo = tabelaOperacaoProdutos[0][1]

        percAcrescimo = percAcrescimo / 100

        valorCalculo = round((valorProduto + (valorProduto * percAcrescimo)), 2)

        valorTotalProd = float(tabelaOperacaoProdutos[0][0])

        comparacao = valorCalculo == valorTotalProd

        cursor.close()
        connection.close()

        return comparacao                  