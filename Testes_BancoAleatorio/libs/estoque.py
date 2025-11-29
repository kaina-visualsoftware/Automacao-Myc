import mysql.connector
import leituraConfig as config

dbname = config.config.Database
porta = config.config.Porta
ipservidor = config.config.IpServidor

class estoque:

    def Valida_Movimentacao_Estoque_Venda(self, idProduto, idMovimentacao, quantidade_baixa):

        connection = mysql.connector.connect(
        host=ipservidor,
        user='root',
        password='vssql',
        database=dbname,
        port=porta)

        print("Código do produto:", idProduto, "Movimentação:", idMovimentacao, "Quantidade:", quantidade_baixa)

        cursor = None
        try:
            if connection.is_connected():
                cursor = connection.cursor()

                tabelaProdutosEstoque = []
                tabelaAuditoriaEstoque = []

                # Modalidade do produto
                consultaProdutos = "SELECT ModalidadeControle FROM produtos WHERE Codigo = " + str(idProduto)
                cursor.execute(consultaProdutos)

                row_produto = cursor.fetchone()
                if row_produto is None:
                    print("Produto não encontrado.")
                    return False

                Modalidade = row_produto[0]

                if Modalidade == "Normal":

                    # produtosestoque
                    consultaProdutosEstoque = (
                        "SELECT Estoque, Tela, Operacao FROM produtosestoque "
                        "WHERE CodigoOperacao = " + str(idMovimentacao) + " AND CodigoProduto = " + str(idProduto)
                    )
                    cursor.execute(consultaProdutosEstoque)

                    row_pe = cursor.fetchone()
                    if row_pe is None:
                        print("Linha em produtosestoque não encontrada para a operação/produto.")
                        return False

                    print("-------- " + consultaProdutosEstoque + " --------")

                    estoqueAtual = int(row_pe[0])
                    tabelaProdutosEstoque = [(int(row_pe[0]), row_pe[1], row_pe[2])]

                    # auditoriaestoque (último registro)
                    consultaAuditoriaEstoque = (
                        "SELECT EstoqueAtual, Tela_Nova, Operacao_Nova FROM auditoriaestoque "
                        "WHERE IDMov = " + str(idMovimentacao) + " AND CodigoProduto = " + str(idProduto) + " "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAuditoriaEstoque)

                    row_aud = cursor.fetchone()
                    if row_aud is None:
                        print("Auditoria não encontrada para a operação/produto.")
                        return False

                    tabelaAuditoriaEstoque = [(int(row_aud[0]), row_aud[1], row_aud[2])]
                    print(tabelaAuditoriaEstoque)
                    print(consultaAuditoriaEstoque)

                    # EstoqueAnterior da mesma linha mais recente
                    consultaAuditoriaEstoqueMovAnterior = (
                        "SELECT EstoqueAnterior FROM auditoriaestoque "
                        "WHERE IDMov = " + str(idMovimentacao) + " AND CodigoProduto = " + str(idProduto) + " "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAuditoriaEstoqueMovAnterior)

                    row_prev = cursor.fetchone()
                    if row_prev is None:
                        print("Auditoria (EstoqueAnterior) não encontrada.")
                        return False

                    estoqueValidacao = int(row_prev[0]) - int(quantidade_baixa)

                    if tabelaProdutosEstoque == tabelaAuditoriaEstoque:
                        print("Auditoria de estoque está de acordo.")
                        if estoqueAtual == estoqueValidacao:
                            print("Estoque baixou corretamente.")
                            return True
                        else:
                            print(f"Estoque NÃO baixou corretamente. Esperado {estoqueValidacao}, obtido {estoqueAtual}.")
                            return False
                    else:
                        print("Auditoria não está de acordo!")
                        print("Auditoria de estoque =", tabelaAuditoriaEstoque, "Produtos Estoque =", tabelaProdutosEstoque)
                        return False

            return False

        finally:
            try:
                if cursor:
                    cursor.close()
            except Exception:
                pass
            try:
                connection.close()
            except Exception:
                pass