import mysql.connector
import leituraConfig as config
from robot.api import logger

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

        cursor = None
        try:
            if connection.is_connected():
                cursor = connection.cursor()

                tabelaProdutosEstoque = []
                tabelaAuditoriaEstoque = []

                # Modalidade do produto
                consultaProdutos = "SELECT ModalidadeControle FROM produtos WHERE Codigo = %s"
                cursor.execute(consultaProdutos, (idProduto,))

                row_produto = cursor.fetchone()
                if row_produto is None:
                    print("Produto não encontrado.")
                    return False

                Modalidade = row_produto[0]

                if Modalidade == "Normal":

                    # produtosestoque
                    consultaProdutosEstoque = (
                        "SELECT Estoque, Tela, Operacao FROM produtosestoque "
                        "WHERE CodigoOperacao = %s AND CodigoProduto = %s"
                    )
                    cursor.execute(consultaProdutosEstoque, (idMovimentacao, idProduto))

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
                        "WHERE IDMov = %s AND CodigoProduto = %s "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAuditoriaEstoque, (idMovimentacao, idProduto))

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
                        "WHERE IDMov = %s AND CodigoProduto = %s "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAuditoriaEstoqueMovAnterior, (idMovimentacao, idProduto))

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
                            logger.console("=" * 60)
                            logger.console("ERRO: Estoque NÃO baixou corretamente!")
                            logger.console(f"  Produto (idProduto)       : {idProduto}")
                            logger.console(f"  Movimentação (idMovimento): {idMovimentacao}")
                            logger.console(f"  Quantidade baixada        : {quantidade_baixa}")
                            logger.console(f"  Estoque anterior          : {int(row_prev[0])}")
                            logger.console(f"  Estoque esperado          : {estoqueValidacao}  ({int(row_prev[0])} - {quantidade_baixa})")
                            logger.console(f"  Estoque atual (obtido)    : {estoqueAtual}")
                            logger.console("=" * 60)
                            return False
                    else:
                        pe_estoque, pe_tela, pe_operacao = tabelaProdutosEstoque[0]
                        aud_estoque, aud_tela, aud_operacao = tabelaAuditoriaEstoque[0]
                        logger.console("=" * 60)
                        logger.console("ERRO: Auditoria de estoque NÃO está de acordo!")
                        logger.console(f"  {'Campo':<12} {'produtosestoque':<25} {'auditoriaestoque':<25} {'OK?'}")
                        logger.console(f"  {'-'*12} {'-'*25} {'-'*25} {'-'*4}")
                        logger.console(f"  {'Estoque':<12} {str(pe_estoque):<25} {str(aud_estoque):<25} {'OK' if pe_estoque == aud_estoque else 'DIVERGE'}")
                        logger.console(f"  {'Tela':<12} {str(pe_tela):<25} {str(aud_tela):<25} {'OK' if pe_tela == aud_tela else 'DIVERGE'}")
                        logger.console(f"  {'Operacao':<12} {str(pe_operacao):<25} {str(aud_operacao):<25} {'OK' if pe_operacao == aud_operacao else 'DIVERGE'}")
                        logger.console("=" * 60)
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

    def Valida_Movimentacao_Estoque_Devolucao(self, idProduto, idMovimentacao, quantidade_devolvida):
        
        connection = mysql.connector.connect(
            host=ipservidor,
            user='root',
            password='vssql',
            database=dbname,
            port=porta)

        cursor = None
        try:
            if connection.is_connected():
                cursor = connection.cursor()

                # Modalidade do produto
                cursor.execute("SELECT ModalidadeControle FROM produtos WHERE Codigo = %s", (idProduto,))
                row_produto = cursor.fetchone()
                if row_produto is None:
                    print("Produto não encontrado.")
                    return False

                Modalidade = row_produto[0]

                if Modalidade == "Normal":

                    # produtosestoque
                    consultaPE = (
                        "SELECT Estoque, Tela, Operacao FROM produtosestoque "
                        "WHERE CodigoOperacao = %s AND CodigoProduto = %s"
                    )
                    cursor.execute(consultaPE, (idMovimentacao, idProduto))
                    row_pe = cursor.fetchone()
                    if row_pe is None:
                        print("Linha em produtosestoque não encontrada para a devolução/produto.")
                        return False

                    print("-------- " + consultaPE + " --------")

                    estoqueAtual = int(row_pe[0])
                    tabelaProdutosEstoque = [(int(row_pe[0]), row_pe[1], row_pe[2])]

                    # auditoriaestoque (último registro — devolução)
                    consultaAud = (
                        "SELECT EstoqueAtual, Tela_Nova, Operacao_Nova FROM auditoriaestoque "
                        "WHERE IDMov = %s AND CodigoProduto = %s "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAud, (idMovimentacao, idProduto))
                    row_aud = cursor.fetchone()
                    if row_aud is None:
                        print("Auditoria não encontrada para a devolução/produto.")
                        return False

                    tabelaAuditoriaEstoque = [(int(row_aud[0]), row_aud[1], row_aud[2])]
                    print(tabelaAuditoriaEstoque)
                    print(consultaAud)

                    # EstoqueAnterior da mesma linha mais recente
                    consultaAudAnterior = (
                        "SELECT EstoqueAnterior FROM auditoriaestoque "
                        "WHERE IDMov = %s AND CodigoProduto = %s "
                        "ORDER BY ID DESC LIMIT 1;"
                    )
                    cursor.execute(consultaAudAnterior, (idMovimentacao, idProduto))
                    row_prev = cursor.fetchone()
                    if row_prev is None:
                        print("Auditoria (EstoqueAnterior) não encontrada.")
                        return False

                    estoqueValidacao = int(row_prev[0]) + int(quantidade_devolvida)

                    if tabelaProdutosEstoque == tabelaAuditoriaEstoque:
                        print("Auditoria de estoque (devolução) está de acordo.")
                        if estoqueAtual == estoqueValidacao:
                            print("Estoque retornou corretamente após devolução.")
                            return True
                        else:
                            print(f"Estoque NÃO retornou corretamente. Esperado {estoqueValidacao}, obtido {estoqueAtual}.")
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