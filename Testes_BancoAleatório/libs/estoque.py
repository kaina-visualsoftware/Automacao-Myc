import mysql.connector
import leituraConfig as config

dbname = config.config.Database
porta = config.config.Porta

class estoque:

    def Valida_Movimentacao_Estoque_Venda(self, idProduto, idMovimentacao):
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database=dbname, port=porta)
        print("Código do produto: "+str(idProduto)+" Movimentação: "+str(idMovimentacao))

        if(connection.is_connected()):

            cursor = connection.cursor()
            
            tabelaProdutosEstoque = []
            tabelaAuditoriaEstoque = []
            tabelaAuditoriaEstoqueMovAnterior = []

            #Essa parte será usada mais a frente, quando forem feitos cenários com produtos de outras modalidades
            consultaProdutos = "SELECT ModalidadeControle FROM produtos WHERE Codigo = "+str(idProduto)
            cursor.execute(consultaProdutos)
            tabelaProdutos = cursor.fetchall()
            Modalidade = tabelaProdutos[0][0]
            #Essa parte será usada mais a frente, quando forem feitos cenários com produtos de outras modalidades

            if(Modalidade == "Normal"):

                consultaProdutosEstoque = "SELECT Estoque, Tela, Operacao FROM produtosestoque WHERE CodigoOperacao = "+str(idMovimentacao)+" AND CodigoProduto = "+str(idProduto)+";"
                cursor.execute(consultaProdutosEstoque)
                tabelaProdutosEstoque = cursor.fetchall()

                estoqueAtual = tabelaProdutosEstoque[0][0] 

                consultaAuditoriaEstoque = "SELECT EstoqueAtual, Tela_Nova, Operacao_Nova FROM auditoriaestoque WHERE IDMov = "+str(idMovimentacao)+" AND CodigoProduto = "+str(idProduto)+" ORDER BY ID DESC LIMIT 1;"
                cursor.execute(consultaAuditoriaEstoque)
                tabelaAuditoriaEstoque = cursor.fetchall()
                print(tabelaAuditoriaEstoque)

                print(consultaAuditoriaEstoque)

                consultaAuditoriaEstoqueMovAnterior = "SELECT EstoqueAnterior FROM auditoriaestoque WHERE IDMov = "+str(idMovimentacao)+" AND CodigoProduto = "+str(idProduto)+" ORDER BY ID DESC LIMIT 1;"
                cursor.execute(consultaAuditoriaEstoqueMovAnterior)
                tabelaAuditoriaEstoqueMovAnterior = cursor.fetchall()

                if(tabelaProdutosEstoque == tabelaAuditoriaEstoque):
                    
                    print("Auditoria de estoque está de acordo.")
                    estoqueValidacao = tabelaAuditoriaEstoqueMovAnterior[0][0] - 1

                    if(estoqueAtual == estoqueValidacao):
                        print("Estoque baixou corretamente.")
                        return True
                    else:
                        print("Estoque NÃO baixou corretamente.")
                        return False 
                else:
                    print("Auditoria não está de acordo!")
                    print("Auditoria de estoque = "+str(tabelaAuditoriaEstoque)+" Produtos Estoque = "+str(tabelaProdutosEstoque))
                    return False  
                
            cursor.close() 
            connection.close()

#estoque.Valida_Movimentacao_Estoque_Venda(1284, 921)