import traceback
import mysql.connector
import decimal

class validaAtacado:
    
    def conexao_banco():
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database='8660', port='3306')
        cursor = connection.cursor()

        return connection, cursor

    def valida_desconto_venda(self, codVenda):

        connection, cursor = validaAtacado.conexao_banco()

        codVenda = str(codVenda)

        if connection.is_connected():

            consultaQuantidadeProdutos = "SELECT COUNT(CodigoProduto) FROM vendasprodutos WHERE CodigoVenda = " + codVenda + " AND Cancelada IS NULL;"
            cursor.execute(consultaQuantidadeProdutos)
            quantidadeProdutos = cursor.fetchall()[0][0]

            consultaVendasProdutos = "SELECT CodigoProduto, ValorTabela, ValorTotal, round(Desconto,2) FROM vendasprodutos WHERE CodigoVenda = " + codVenda + " AND Cancelada IS NULL;"

            cursor.execute(consultaVendasProdutos)
            vendasProdutos = cursor.fetchall()

            for i in range(quantidadeProdutos):

                try:

                    consultaProdutos = "SELECT VendaT1, DescontoMaximo, IF(DataPromocao > CURDATE(), 1, 0) AS produtoEmPromocao FROM produtos WHERE Codigo = " + str(vendasProdutos[i][0])
                    cursor.execute(consultaProdutos)

                    produto = cursor.fetchall()

                    if produto[0][2] == 1:

                        if vendasProdutos[i][3] > 0.1:

                            print("Produto em promoção possui desconto, verifique!")
                            
                            return False
                        
                    else:

                        if vendasProdutos[i][3] > produto[0][1]:

                            print("Desconto aplicado na venda maior que o desconto máximo do produto, verifique!\n Desconto Máximo: "+str(produto[0][1])+"\n Desconto Aplicado: "+str(vendasProdutos[i][3]))

                            return False
                        
                        else:

                            desconto = round(vendasProdutos[i][1] * (vendasProdutos[i][3] / 100), ndigits=2)

                            print("Valor de Desconto = " + str(desconto))

                            calculoProdutoDesconto = round(produto[0][0] - desconto, ndigits=2)

                            print("Calculo Realizado = " + str(calculoProdutoDesconto))

                            if vendasProdutos[i][2] > calculoProdutoDesconto:

                                print("Valor do produto com desconto calculado errado, verifique!\n Valor no Sistema: "+str(vendasProdutos[i][2])+"\n Valor Calculado: "+str(calculoProdutoDesconto))

                                return False
                            else:
                                
                                print("Passou nas verificações!")
                            
                except IndexError:
                    print("Um erro do tipo IndexError ocorreu.")
                    #Caso seja necessário tratar algum outro erro, mudar o mesmo no Except, já que não é possível depurar o código, o traceback detalha aonde o erro ocorre (linha e aponta pro local do erro).
                    traceback.print_exc()
            
        else:

            print("Conexão falhou, verifique!")

    def calcula_valor_final_desconto(self, codVenda, desconto):

        connection, cursor = validaAtacado.conexao_banco()

        codVenda = str(codVenda)

        desconto = float(desconto)

        valorFinalVenda = 0

        if connection.is_connected():
            
            consultaQuantidadeProdutos = "SELECT COUNT(CodigoProduto) FROM vendasprodutos WHERE CodigoVenda = " + codVenda + " AND Cancelada IS NULL;"
            cursor.execute(consultaQuantidadeProdutos)
            quantidadeProdutos = cursor.fetchall()[0][0]

            consultaVendasProdutos = "SELECT CodigoProduto FROM vendasprodutos WHERE CodigoVenda = " + codVenda + " AND Cancelada IS NULL;"
            cursor.execute(consultaVendasProdutos)
            vendasProdutos = cursor.fetchall()

            for i in range(quantidadeProdutos):

                try:

                    consultaProdutos = "SELECT VendaT1, DescontoMaximo, IF(DataPromocao > CURDATE(), 1, 0) AS produtoEmPromocao, ValorPromocao FROM produtos WHERE Codigo = " + str(vendasProdutos[i][0])
                    cursor.execute(consultaProdutos)
                    produto = cursor.fetchall()

                    if produto[0][2] == 1:

                        valorProduto = decimal.Decimal(produto[0][3])
                        valorProdutoArredondado = valorProduto.quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)

                        valorFinalVenda += valorProdutoArredondado
                        

                    else:

                        if desconto > produto[0][1]:

                            descontoCalculado = round(produto[0][0] * (produto[0][1] / 100), ndigits=3)

                            print("Valor de Desconto = " + str(descontoCalculado))
                            
                            valorProduto = decimal.Decimal(produto[0][0] - descontoCalculado)

                            '''
                            IMPORTANTE! Não sei por que mas o Python tem um tipo de arredondamento estranho e sempre da erro no Mycommerce.
                            Essa expressão vai fazer com que o arredondamento respeite a do MyCommerce, ou seja, arredondando pra cima e não
                            Pelo valor mais próximo do meio (que é como o Python faz).
                            Se tiver dúvida sobre o que significa cada coisa pesquisa ou me chama. Att. Vinicius
                            '''

                            valorProdutoArredondado = valorProduto.quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)

                            valorFinalVenda += valorProdutoArredondado
                        
                        else:

                            descontoCalculado = round(produto[0][0] * (desconto / 100), ndigits=3)

                            print("Valor de Desconto = " + str(descontoCalculado))
                            
                            valorProduto = decimal.Decimal(produto[0][0] - descontoCalculado)

                            valorProdutoArredondado = valorProduto.quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_CEILING)

                            valorFinalVenda += valorProdutoArredondado
                
                    print("Produto somado: "+str(vendasProdutos[i][0])+"\nValor Unitário do produto: "+str(valorProduto)+"\nValor Unitário do produto(Arredondado): "+str(valorProdutoArredondado)+"\nValor PARCIAL final: "+str(valorFinalVenda)+"\n")

                except TypeError:
                    print("Um erro do tipo IndexError ocorreu.")
                    #Caso seja necessário tratar algum outro erro, mudar o mesmo no Except, já que não é possível depurar o código, o traceback detalha aonde o erro ocorre (linha e aponta pro local do erro).
                    traceback.print_exc()

            print("Valor final calculado: "+str(valorFinalVenda))

            return valorFinalVenda
        
        else:

            print("Conexão falhou, verifique!")

            return valorFinalVenda
        
    def valida_Estoque(self, codProduto, quantidadeAcerto):
               
        connection, cursor = validaAtacado.conexao_banco()

        try:

            if connection.is_connected():
            
                consultaProdutos = "SELECT Qtde, EstqAtual, EstqNovo, ID FROM acertoestoque WHERE CodigoProduto = "+str(codProduto)+" ORDER BY ID DESC LIMIT 1;"
                cursor.execute(consultaProdutos)
                AcertoProdutos = cursor.fetchall()

                print(AcertoProdutos)

                consultaProdutos = "SELECT Estoque FROM produtosestoque WHERE CodigoProduto = "+str(codProduto)
                cursor.execute(consultaProdutos)
                ProdutosEstoque = cursor.fetchall()
                estoquePrevisto = float(AcertoProdutos[0][1]) + float(quantidadeAcerto)

                quantidadeAcerto = float(quantidadeAcerto)

                if AcertoProdutos[0][0] == quantidadeAcerto:

                    print(quantidadeAcerto)

                    if estoquePrevisto == AcertoProdutos[0][2]:

                        if ProdutosEstoque[0][0] == estoquePrevisto:

                            print("Passou em Todas a validações")
                            return True
                        
                        else:

                            print("Validação 3 falhou, verifique!"+str(estoquePrevisto)+" "+str(AcertoProdutos[0][0])+" "+str(AcertoProdutos[0][1])+" "+str(AcertoProdutos[0][2]))
                            print(quantidadeAcerto)
                            return False
                    
                    else:

                        print("Validação 2 falhou, verifique!"+str(estoquePrevisto)+" "+str(AcertoProdutos[0][0])+" "+str(AcertoProdutos[0][1])+" "+str(AcertoProdutos[0][2]))
                        print(quantidadeAcerto)
                        return False

                else:

                    print("Validação 1 falhou, verifique!"+str(estoquePrevisto)+" "+str(AcertoProdutos[0][0])+" "+str(AcertoProdutos[0][1])+" "+str(AcertoProdutos[0][2]))
                    print(quantidadeAcerto)
                    return False

        except TypeError:
            traceback.print_exc()
    