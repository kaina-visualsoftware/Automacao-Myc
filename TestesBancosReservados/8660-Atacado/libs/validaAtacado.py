import traceback
import mysql.connector

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
