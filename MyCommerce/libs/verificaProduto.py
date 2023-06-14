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

                valoresOrc = "SELECT ValorTotal, Acrescimo FROM orcamentosprodutos AS orp WHERE orp.CodigoOrcamento = "+str(codOperacao)+" AND orp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresOrc)
                tabelaOperacaoProdutos = cursor.fetchall()
                          
            elif nomeTela == "Vendas":

                valoresVenda = "SELECT ValorTotal, Acrescimo FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'VP' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaOperacaoProdutos = cursor.fetchall()
            
            elif nomeTela == "OS":

                valoresVenda = "SELECT ValorTotal, Acrescimo FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.Tipo LIKE 'OS' AND vp.CodigoVenda = "+str(codOperacao)+" AND vp.Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(valoresVenda)
                tabelaOperacaoProdutos = cursor.fetchall()

            elif nomeTela == "Condicional":

                consultaOrcProdutos = "SELECT ValorTotal, Acrescimo FROM condicionaisprodutos AS cp WHERE cp.CodigoCondicional = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaOrcProdutos)
                tabelaOperacaoProdutos = cursor.fetchall()

            elif nomeTela == "Pedidos":

                consultaPedidosProdutos = "SELECT ValorTotal, Acrescimo FROM pedidosvendaprodutos AS pvp WHERE pvp.CodigoPedido = "+str(codOperacao)+" AND Cancelada IS NULL ORDER BY Sequencia DESC LIMIT 1;"
                cursor.execute(consultaPedidosProdutos)
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

    def movimentacao_Estoque(self, idMov, codProduto):
        connection, cursor = verificaProduto.conexao_banco()
        print("Codigo do Produto a ser validado: ",codProduto)
        print("Codigo Movimentação: ", idMov)

        if(connection.is_connected):

            consultaProdutos = "SELECT ModalidadeControle FROM produtos WHERE Codigo = "+codProduto
            cursor.execute(consultaProdutos)
            tabelaProdutos = cursor.fetchall()
            Modalidade = tabelaProdutos[0][0]
                
            if(Modalidade == "Kit"):

                print("Validação Kit")
                cont = 0

                consultaProdutosKit = "SELECT aude.CodigoProduto, aude.EstoqueAnterior, aude.EstoqueAtual FROM auditoriaestoque AS aude INNER JOIN produtos_kits AS prodK ON aude.CodigoProduto = prodK.CodProdutoKit WHERE ProdutoPrincipal = "+str(codProduto)+" AND aude.IDmov = "+str(idMov)+";"
                cursor.execute(consultaProdutosKit)
                tabelaAudProdutosKit = cursor.fetchall()

                consultaKit = "SELECT CodProdutoKit, Qtde FROM produtos_kits WHERE ProdutoPrincipal = "+codProduto
                cursor.execute(consultaKit)
                tabelaProdKit = cursor.fetchall()

                for i in range(2):

                    if(tabelaAudProdutosKit[i][0] == tabelaProdKit[i][0]):

                        print("Passou na 1° Validação (Kit)")
                        estoqueValidacao = tabelaAudProdutosKit[i][1] - tabelaProdKit[i][1]

                        if(estoqueValidacao == tabelaAudProdutosKit[i][2]):
                            print("Passou na 2° Validação (Kit)")
                            cont = cont + 1
                        else:
                            cont = cont
                            
                    else:
                        cont = cont

                if(cont == 2):
                    print("Passou na Validação (Kit)")
                    return True
                else:
                    return False
                
            else:

                consultaProdutosEstoque = "SELECT Estoque, Tela, Operacao FROM produtosestoque WHERE CodigoOperacao = "+str(idMov)+" AND CodigoProduto = "+str(codProduto)+";"
                cursor.execute(consultaProdutosEstoque)
                tabelaProdutosEstoque = cursor.fetchall()

                estoqueAtual = tabelaProdutosEstoque[0][0] 

                consultaAuditoriaEstoque = "SELECT EstoqueAtual, Tela_Nova, Operacao_Nova FROM auditoriaestoque WHERE IDMov = "+str(idMov)+" AND CodigoProduto = "+str(codProduto)+";"
                cursor.execute(consultaAuditoriaEstoque)
                tabelaAuditoriaEstoque = cursor.fetchall()

                consultaAuditoriaEstoqueMovAnterior = "SELECT EstoqueAnterior FROM auditoriaestoque WHERE IDMov = "+str(idMov)+" AND CodigoProduto = "+str(codProduto)+";"
                cursor.execute(consultaAuditoriaEstoqueMovAnterior)
                tabelaAuditoriaEstoqueMovAnterior = cursor.fetchall()       

                if(tabelaProdutosEstoque == tabelaAuditoriaEstoque):

                    print("Passou na validação 1")
                    estoqueValidacao = tabelaAuditoriaEstoqueMovAnterior[0][0] - 1

                    if(estoqueAtual == estoqueValidacao):
                        print("Passou na validação 2")
                        return True
                    else:
                        print("Não passou na validação 2")
                        return False 
                else:
                    print("Não passou na primeira validação")
                    return False                              