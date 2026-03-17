from decimal import Decimal, ROUND_HALF_UP

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


    def calcula_comissao_linha_produto_unico(self, valor_comissao_unitario, quantidade_produto, total_comissao_produto):
        
        comissao_produto = Decimal(str(valor_comissao_unitario)) * Decimal(str(quantidade_produto))

        total_comissao_produto = Decimal(str(total_comissao_produto)) + comissao_produto
        total_comissao_produto = self.converte_para_decimal(total_comissao_produto, 4)
        total_comissao_produto = self.converte_para_decimal(total_comissao_produto, 2)

        return total_comissao_produto


    def calcula_comissao_linha_produto_multiplos(self, valores_comissao_por_produto, quantidade_produto, dados_venda_devolucao, posicao_valor):
        
        total_comissao = Decimal("0")
        total_comissao_produtos = Decimal("0")

        for valor_comissao in valores_comissao_por_produto or []:

            if valor_comissao is None:
                continue

            comissao_produto = Decimal(str(valor_comissao)) * Decimal(str(quantidade_produto))

            total_comissao_produtos = self.converte_para_decimal(total_comissao_produtos + comissao_produto, 4)

        valor_base = Decimal(str(dados_venda_devolucao[posicao_valor][1]))

        if valor_base > 0:
            percent_comissao = (total_comissao_produtos / valor_base) * Decimal("100")
        else:
            percent_comissao = Decimal("0")

        total_comissao_produtos = self.converte_para_decimal(valor_base * (percent_comissao / Decimal("100")), 2)
        total_comissao = self.converte_para_decimal(Decimal(str(total_comissao)) + total_comissao_produtos, 2)

        return (total_comissao_produtos, total_comissao, percent_comissao)


    def calcula_comissao_linha_produto_parcela_personalizada(self, valores_comissao_por_produto, quantidade_produto, dados_venda_devolucao, valores_parcelas, indice_parcela, total_comissao_atual):
        
        soma_comissao_parcela = Decimal("0")

        for valor_comissao in valores_comissao_por_produto or []:

            if valor_comissao is None:
                continue

            comissao_produto = Decimal(str(valor_comissao)) * Decimal(str(quantidade_produto))
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

    def calcula_comissao_linha_servico_unico(self, valor_comissao_servico):
        
        if valor_comissao_servico is None:
            raise ValueError("Valor de comissão do serviço não pode ser None.")

        total_comissao_os = self.converte_para_decimal(valor_comissao_servico, 2)

        return total_comissao_os

    def calcula_comissao_servico_com_aliquota(self, valor_base_servico, aliquota):
        
        valor_base = Decimal(str(valor_base_servico))
        aliq = Decimal(str(aliquota))

        comissao = valor_base * (aliq / Decimal("100"))
        return self.converte_para_decimal(comissao, 2)

    def calcula_comissao_servico_aliquota_somada(self, valor_base_servico, aliquota, aliquota_execucao):
        
        valor_base = Decimal(str(valor_base_servico))
        aliq = Decimal(str(aliquota))
        aliq_exec = Decimal(str(aliquota_execucao))

        aliquota_total = aliq + aliq_exec
        comissao = valor_base * (aliquota_total / Decimal("100"))
        return self.converte_para_decimal(comissao, 2)

    def calcula_comissao_servico_vendedores_diferentes(self, valor_base_servico, aliquota_executor, aliquota_vendedor_os):
        
        valor_base = Decimal(str(valor_base_servico))
        aliq_exec = Decimal(str(aliquota_executor))
        aliq_vend = Decimal(str(aliquota_vendedor_os))

        # Comissão do executor
        if aliq_exec > Decimal("0"):
            comissao_executor = self.converte_para_decimal(valor_base * (aliq_exec / Decimal("100")), 2)
        else:
            comissao_executor = Decimal("0.00")

        # Comissão do vendedor da OS
        if aliq_vend > Decimal("0"):
            comissao_vendedor = self.converte_para_decimal(valor_base * (aliq_vend / Decimal("100")), 2)
        else:
            comissao_vendedor = Decimal("0.00")

        return {
            'comissao_executor': comissao_executor,
            'comissao_vendedor_os': comissao_vendedor
        }

    def busca_comissao_servico_gerada(self, resultado_query):
        
        if resultado_query is None or len(resultado_query) == 0:
            return None

        valor = resultado_query[0][0]
        if valor is None:
            return None

        return self.converte_para_decimal(valor, 2)

    def verifica_comissao_servico_existe(self, resultado_query):
        
        if resultado_query is None or len(resultado_query) == 0:
            return False

        count = resultado_query[0][0]
        return int(count) > 0