import time
import mysql.connector
import leituraConfig as config
from decimal import Decimal, ROUND_HALF_UP

dbname = config.config.Database
porta = config.config.Porta
ipservidor = config.config.IpServidor

connection = mysql.connector.connect(host=ipservidor, user='root', password='vssql', database=dbname, port=porta)
cursor = connection.cursor()

class validaComissoes:

    def converte_para_decimal(self, valor, casas_decimais=2):
        
        valorDecimal = Decimal(str(valor))

        if casas_decimais == 2:
            quant = Decimal("0.00")
        elif casas_decimais == 4:
            quant = Decimal("0.0000")
        else:
            quant = Decimal("0." + ("0" * casas_decimais))

        return valorDecimal.quantize(quant, rounding=ROUND_HALF_UP)


    def calcula_comissao_linha_produto_unico(self, codigo_produto, codigo_operacao, quantidade_produto, total_comissao_produto):
        
        connection.commit()

        cursor.execute(
            """
            SELECT vp.ValorUnitario * (cl.Aliquota / 100) AS ValorComissao
            FROM comissaoporlinha cl
            INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo
            INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo
            WHERE p.Codigo = %s
            AND vp.CodigoVenda = %s
            AND vp.Cancelada IS NULL
            """,
            (codigo_produto, codigo_operacao),
        )

        row = cursor.fetchone()

        if row is None or row[0] is None:
            raise ValueError(
                f"Comissão não encontrada para produto {codigo_produto} "
                f"na venda {codigo_operacao}"
            )

        comissao_produto = Decimal(str(row[0])) * Decimal(str(quantidade_produto))

        total_comissao_produto = Decimal(str(total_comissao_produto)) + comissao_produto
        total_comissao_produto = self.converte_para_decimal(total_comissao_produto, 4)
        total_comissao_produto = self.converte_para_decimal(total_comissao_produto, 2)

        return total_comissao_produto


    def calcula_comissao_linha_produto_multiplos(self, codigos_produtos, quantidade_produto, dados_venda_devolucao, posicao_valor):
        
        total_comissao = Decimal("0")
        total_comissao_produtos = Decimal("0")

        for cod_produto in codigos_produtos or []:

            cursor.execute(
                """
                SELECT SUM(p.vendaT1 * (cl.Aliquota / 100))
                FROM comissaoporlinha AS cl
                INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo
                WHERE p.Codigo = %s
                """,
                (cod_produto,),
            )

            row = cursor.fetchone()

            if not row or row[0] is None:
                continue

            comissao_produto = Decimal(str(row[0])) * Decimal(str(quantidade_produto))

            total_comissao_produtos = self.converte_para_decimal(total_comissao_produtos + comissao_produto, 4)

        valor_base = Decimal(str(dados_venda_devolucao[posicao_valor][1]))

        if valor_base > 0:
            percent_comissao = (total_comissao_produtos / valor_base) * Decimal("100")
        else:
            percent_comissao = Decimal("0")

        total_comissao_produtos = self.converte_para_decimal(valor_base * (percent_comissao / Decimal("100")), 2)
        total_comissao = self.converte_para_decimal(Decimal(str(total_comissao)) + total_comissao_produtos, 2)

        return (total_comissao_produtos, total_comissao, percent_comissao)


    def calcula_comissao_linha_produto_parcela_personalizada(self, codigos_produtos, quantidade_produto, dados_venda_devolucao, valores_parcelas, indice_parcela, total_comissao_atual):
        
        soma_comissao_parcela = Decimal("0")

        qtde_produtos = len(codigos_produtos or [])

        for cod_produto in (codigos_produtos or [])[:qtde_produtos]:

            cursor.execute(
                """
                SELECT SUM(p.vendaT1 * (cl.Aliquota / 100))
                FROM comissaoporlinha AS cl
                INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo
                WHERE p.Codigo = %s
                """,
                (cod_produto,),
            )

            row = cursor.fetchone()

            if not row or row[0] is None:
                continue

            comissao_produto = Decimal(str(row[0])) * Decimal(str(quantidade_produto))
            soma_comissao_parcela = self.converte_para_decimal(soma_comissao_parcela + comissao_produto, 4)

        valor_operacao = Decimal(str(dados_venda_devolucao[0][1]))
        valor_parcela_atual = Decimal(str(valores_parcelas[indice_parcela]))

        if valor_parcela_atual > 0 and valor_operacao > 0:
            percent_comissao = (soma_comissao_parcela / valor_operacao) * Decimal("100")
        else:
            percent_comissao = Decimal("0")

        calc_comissao_total_parcela = self.converte_para_decimal(valor_parcela_atual * (percent_comissao / Decimal("100")), 2)

        total_comissao_produtos = calc_comissao_total_parcela
        total_comissao = Decimal(str(total_comissao_atual)) + total_comissao_produtos
        total_comissao = self.converte_para_decimal(total_comissao, 2)

        return (total_comissao_produtos, total_comissao, percent_comissao)


    def valida_diferenca_de_um_centavo(self, valor_calculado, valor_esperado):

        calc = Decimal(str(valor_calculado))
        esper = Decimal(str(valor_esperado))
        diferenca = abs(calc - esper)

        if diferenca > Decimal("0.01"):
            raise AssertionError(
                f"Calculado: {calc}, Esperado: {esper}"
            )

        if diferenca == Decimal("0.01"):
            print(
                f"Diferença de exatamente 1 centavo detectada. "
                f"Ajustado valor calculado de {calc} para {esper}"
            )
            return (esper, True)

        return (calc, False)
    

    def calcula_comissao_linha_servico_unico(self, cod_servico, codigo_operacao_mov, total_tributos_servico):

        connection.commit()

        cursor.execute(
            """
            SELECT SUM((v.TotalServicos - (v.TotalServicos * (%s / 100))) * (cl.Aliquota / 100))
            FROM comissaoporlinha cl
            INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = %s
            INNER JOIN vendas v ON v.Codigo = %s
            """,
            (total_tributos_servico, cod_servico, codigo_operacao_mov),
        )
        
        row = cursor.fetchone()
        
        if not row or row[0] is None:
            raise ValueError(
                f"Comissão não encontrada para serviço {cod_servico} "
                f"na venda {codigo_operacao_mov}"
            )
        
        total_comissao_os = self.converte_para_decimal(row[0], 2)
        
        return total_comissao_os