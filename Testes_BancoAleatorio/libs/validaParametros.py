import mysql.connector
import leituraConfig as config

dbname = config.config.Database
porta = config.config.Porta
ipservidor = config.config.IpServidor

connection = mysql.connector.connect(host=ipservidor, user='root', password='vssql', database=dbname, port=porta)
cursor = connection.cursor()

class validaParametros:

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def __init__(self):
        self._usuario_logado = None

    def _get_usuario_logado(self):
        
        if self._usuario_logado is None:
            cursor.execute(
                "SELECT u.Codigo "
                "FROM usuario_acesso ua "
                "INNER JOIN usuarios u ON u.UserName = ua.ua_usuario_mycommerce "
                "WHERE ua.ua_data = CURDATE() "
                "ORDER BY ua.ua_id DESC, u.Codigo ASC "
                "LIMIT 1"
            )
            resultado = cursor.fetchone()
            self._usuario_logado = resultado[0] if resultado else None
        return self._usuario_logado

    def _carregar_permissoes_lista(self, sql, params=()):
        
        cursor.execute(sql, params)
        linha = cursor.fetchone()
        if not linha:
            return []
        return [
            cursor.description[i][0]
            for i in range(len(cursor.description))
            if linha[i] == 1
        ]

    def Valida_Parametros_Config(self):

        avisosMapeados = ("AvisoVendedor, Aviso_Info_Financeiro, Aviso_Info_Financeiro_Prev, BloqueiaVendaClienteInativo, BloqVenda_CaixaFechado, "
                          "ExigeSenhaCancelarVenda, Vende_Sem_Estoque, Venda_Rapida, VendedorDiferente, ExigeSenhaMudarVendedorVenda, IncluiDireto, "
                          "Aviso_Sem_Est, IndicacaoVenda, ControlaCreditoClientes, PVexibeAnteriores, NDias_Credito_Atu, Senha_supervisor_multiplo, "
                          "ExibeFotoCli, ControlaEntregaPrevista, LocalNegociacao, ImprimirOrdemEntrega, PermiteVariasTabelas, ImprimirOrdemEntrega, "
                          "SuprimirOS, Orc_DesabilitaServico, SelecionaFunc_OS, FaturarOS, ImprimirCarneOS, ImprimirOS, Vende_Sem_Estoque_Condicional, "
                          "ImprimiCondicional, RealizaVendaSemEstoque_PreVenda, RealizaVendaSemEstoque_OS, DevolucaoAvulsa, ExigeObsTroca, Dev_PermiteAberta, "
                          "RealizaVendaSemEstoque_Venda, PrevendaBloqueioVendaParcial, CaixaUsuario, DescontoFinalIgualmente, OrcamentoComEstoque_Bloq, "
                          "BaixaEstoquePreVenda, Venda_Padrao_Entregue, TrazerDescricaoAutomaticaEntrega, FaturarOS, OS_ComVendedorEexecutor, NaoDeduzirISSQNComissao, "
                          "BuscaReferencia, ConsultaSCPCVenda, FocoClienteVenda, IndicacaoPreVenda, TelasQtdePadraoProduto, QuantidadePadraoVenda, DiasInativo, "
                          "ControlaCreditoORC, ControlaCreditoCond, ControlaCreditoGeraPreOrcamento, ControlaCreditoOS, ControlaCreditoDevTroca, ControlaCreditoPRE, "
                          "ControlaCredPreSepPreVenda, DescontaChPre_CreditoCliente, Aviso_Info_Financeiro_Orc, VinculaDevolucaoEntrega, ObrigarMotivoDevolucao, "
                          "IndicacaoOrcamento, IndicacaoOS, ImprimirPreVenda_FinalizarPreVenda, PrevendaDireto, ValorMinimoBoleto, Exibir_Campo_Nped_Venda, "
                          "pula_foco_npedido, LiberaDescontoMaiorMaximo")

        telasQtdePadraoProduto = None
        quantidadePadraoVenda = None
        diasInativo = None
        valorMinimoBoleto = None
        avisosMarcados = []
        updatesParametros = []

        cursor.execute("SELECT " + avisosMapeados + " FROM config;")

        parametrosMarcados = cursor.fetchone()

        while parametrosMarcados is not None:

            for i in range(len(cursor.description)):

                desc = cursor.description[i]
                nomeColuna = str("{}".format(desc[0]))

                if parametrosMarcados[i] is None:
                    continue

                elif nomeColuna == "NDias_Credito_Atu":

                    if parametrosMarcados[i] > 0:
                        updatesParametros.append(nomeColuna)

                elif nomeColuna == "TelasQtdePadraoProduto":

                    telasQtdePadraoProduto = parametrosMarcados[i]

                elif nomeColuna == "QuantidadePadraoVenda":

                    quantidadePadraoVenda = parametrosMarcados[i]

                elif nomeColuna == "DiasInativo":

                    diasInativo = parametrosMarcados[i] or 0

                elif nomeColuna == "ValorMinimoBoleto":

                    valorMinimoBoleto = parametrosMarcados[i]

                elif parametrosMarcados[i] == 1:

                    avisosMarcados.append(nomeColuna)

            parametrosMarcados = cursor.fetchone()

        if len(updatesParametros) > 0:

            cursor.execute("UPDATE config SET NDias_Credito_Atu = 0;")

        return avisosMarcados, telasQtdePadraoProduto, quantidadePadraoVenda, diasInativo, valorMinimoBoleto

    def valida_Config_Empresa(self):

        parametrosMapeados = ("Venda_ImprimeCupom, ImprimirVenda_FinalizarVenda, ImprimirDup_FinalizarVenda, BaixaCentralizada, BaixaAutomatico, CodigoCX, "
                              "ImpRecEnt_FinalizarVenda, ImprimirContrato_FinalizarVenda, ImpPromissoria_FinalizarVenda, ImprimirBol_FinalizarVenda, Dev_Ativa_Vale, "
                              "FaturaVendaDireto, Entrega_StatusConcluido, Entrega_ImpressaoEntrega, Entrega_UmaEntregaPorVenda, Entrega_ConsideraDoacoes")

        cursor.execute("SELECT "+parametrosMapeados+" FROM configempresa WHERE empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);")

        parametrosValidados = []

        parametrosMarcados = cursor.fetchone()

        while parametrosMarcados is not None:

            for i in range(len(cursor.description)):

                desc = cursor.description[i]
                nomeColuna = str("{}".format(desc[0]))

                if parametrosMarcados[i] is None:

                    break

                elif nomeColuna == 'CodigoCX':

                    if parametrosMarcados[i] != 0:

                        parametrosValidados.append(nomeColuna)

                elif parametrosMarcados[i] == 1:

                    parametrosValidados.append(nomeColuna)

            parametrosMarcados = cursor.fetchone()

        return parametrosValidados

    def valida_Configuracoes_Venda(self):

        formasPadrao = ("30 DIAS", "À VISTA", "PERSONALIZADA")

        formaParcelamento = []

        sqlConsulta = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel, Comissao_Produtos FROM formaparcelamento WHERE formarecebimento IS NOT NULL ORDER BY IF(Padrao_Venda = 0, Descricao, 0) LIMIT 1;"

        cursor.execute(sqlConsulta)

        formaPadraoOS = cursor.fetchall()

        formaEntrada = formaPadraoOS[0][5].split(' ')  # FormaRecebimento

        formaParcelamento.append(formaPadraoOS[0][0])  # Descricao
        formaParcelamento.append(formaPadraoOS[0][3])  # PDesconto
        formaParcelamento.append(formaPadraoOS[0][4])  # ValorMinimo
        formaParcelamento.append(formaEntrada[0])      # FormaRecebimento (primeira palavra)
        formaParcelamento.append(formaPadraoOS[0][2])  # NPagamentos
        formaParcelamento.append(formaPadraoOS[0][7])  # Comissao_Produtos

        if formaParcelamento[0] not in formasPadrao:
            print(formaParcelamento)

            if formaPadraoOS[0][1] == 1 and formaPadraoOS[0][2] == 0:   # comEntrada e NPagamentos
                formaParcelamento[0] = "À VISTA"
                print(formaParcelamento)

            elif formaPadraoOS[0][6] == 1:   # Personalizavel
                formaParcelamento[0] = "PERSONALIZADA"
                print(formaParcelamento)

            elif formaPadraoOS[0][2] > 0 and formaPadraoOS[0][1] == 0:   # NPagamentos e comEntrada
                formaParcelamento[0] = "30 DIAS"
                print(formaParcelamento)

        print(formaParcelamento)

        return formaParcelamento

    def valida_Forma_Parcelamento_Cliente(self, codigo_cliente):

        formasPadrao = ("30 DIAS", "À VISTA", "PERSONALIZADA")

        formaParcelamento = []

        sqlConsulta = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento AS fp INNER JOIN clientes_parcelamento AS cp ON fp.Codigo = cp.CodigoForma WHERE CodigoCliente = " + str(codigo_cliente) + " AND formarecebimento IS NOT NULL ORDER BY IF(Padrao_Venda = 0, Descricao, 0) LIMIT 1;"

        cursor.execute(sqlConsulta)

        formaPadraoOS = cursor.fetchall()

        if formaPadraoOS == []:

            formaParcelamento = False

        else:

            formaEntrada = formaPadraoOS[0][5].split(' ')  # FormaRecebimento

            formaParcelamento.append(formaPadraoOS[0][0])  # Descricao
            formaParcelamento.append(formaPadraoOS[0][3])  # PDesconto
            formaParcelamento.append(formaPadraoOS[0][4])  # ValorMinimo
            formaParcelamento.append(formaEntrada[0])      # FormaRecebimento (primeira palavra)
            formaParcelamento.append(formaPadraoOS[0][2])  # NPagamentos


            if formaParcelamento[0] not in formasPadrao:
                print(formaParcelamento)

                if formaPadraoOS[0][1] == 1 and formaPadraoOS[0][2] == 0:
                    formaParcelamento[0] = "À VISTA"
                    print(formaParcelamento)

                elif formaPadraoOS[0][6] == 1:
                    formaParcelamento[0] = "PERSONALIZADA"
                    print(formaParcelamento)

                elif formaPadraoOS[0][2] > 0 and formaPadraoOS[0][1] == 0:
                    formaParcelamento[0] = "30 DIAS"
                    print(formaParcelamento)

        print(formaParcelamento)

        return formaParcelamento

    def valida_Configuracoes_OS(self):

        formasPadrao = ("30 DIAS", "À VISTA", "PERSONALIZADA")

        formaParcelamento = []

        sqlConsulta = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento WHERE formarecebimento IS NOT NULL ORDER BY IF(Padrao_OS = 0, Descricao, 0) LIMIT 1;"

        cursor.execute(sqlConsulta)

        formaPadraoOS = cursor.fetchall()

        formaEntrada = formaPadraoOS[0][5].split(' ')  # FormaRecebimento

        formaParcelamento.append(formaPadraoOS[0][0])  # Descricao
        formaParcelamento.append(formaPadraoOS[0][3])  # PDesconto
        formaParcelamento.append(formaPadraoOS[0][4])  # ValorMinimo
        formaParcelamento.append(formaEntrada[0])      # FormaRecebimento (primeira palavra)
        formaParcelamento.append(formaPadraoOS[0][2])  # NPagamentos

        if formaParcelamento[0] not in formasPadrao:
            print(formaParcelamento)

            if formaPadraoOS[0][1] == 1 and formaPadraoOS[0][2] == 0:   # comEntrada e NPagamentos
                formaParcelamento[0] = "À VISTA"
                print(formaParcelamento)

            elif formaPadraoOS[0][6] == 1:   # Personalizavel
                formaParcelamento[0] = "PERSONALIZADA"
                print(formaParcelamento)

            elif formaPadraoOS[0][2] > 0 and formaPadraoOS[0][1] == 0:   # NPagamentos e comEntrada
                formaParcelamento[0] = "30 DIAS"
                print(formaParcelamento)

        return formaParcelamento

    def valida_forma_parcelamento(self, tela):

        formasPadrao = ("30 DIAS", "À VISTA", "PERSONALIZADA")
        formaParcelamento = []

        mapa_padrao = {
            "OS": "Padrao_OS",
            "Devolução": "Padrao_Devolucao",
            "Pedido": "Padrao_Pre"
        }

        if tela not in mapa_padrao:
            raise ValueError(f"Tela inválida: {tela}")

        coluna_padrao = mapa_padrao[tela]

        sqlConsulta = f"SELECT Descricao, comEntrada, NPagamentos, PDesconto, COALESCE(ValorMinimo,0) AS ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento WHERE formarecebimento IS NOT NULL AND {coluna_padrao} = 1 ORDER BY Descricao LIMIT 1;"

        cursor.execute(sqlConsulta)
        formaPadrao = cursor.fetchall()

        if not formaPadrao:
            sqlConsulta = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, COALESCE(ValorMinimo,0) AS ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento WHERE formarecebimento IS NOT NULL ORDER BY Descricao LIMIT 1;"
            
            cursor.execute(sqlConsulta)
            formaPadrao = cursor.fetchall()

        if not formaPadrao:
            raise Exception("Nenhuma forma de parcelamento encontrada.")

        formaPadrao = formaPadrao[0]

        formaEntrada = formaPadrao[5].split(' ') if formaPadrao[5] else [""]

        formaParcelamento.append(formaPadrao[0])  # Descricao
        formaParcelamento.append(formaPadrao[3])  # PDesconto
        formaParcelamento.append(formaPadrao[4])  # ValorMinimo
        formaParcelamento.append(formaEntrada[0]) # FormaRecebimento
        formaParcelamento.append(formaPadrao[2])  # NPagamentos
        formaParcelamento.append(formaPadrao[6])  # Personalizavel

        if formaParcelamento[0] not in formasPadrao:
            print(formaParcelamento)

            if formaPadrao[1] == 1 and formaPadrao[2] == 0:
                formaParcelamento[0] = "À VISTA"

            elif formaPadrao[6] == 1:
                formaParcelamento[0] = "PERSONALIZADA"

            elif formaPadrao[2] > 0 and formaPadrao[1] == 0:
                formaParcelamento[0] = "30 DIAS"

            print(formaParcelamento)

        print(formaParcelamento)

        return formaParcelamento

    def seleciona_forma_prazo(self):

        formaParcelamento = []

        consultaForma = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel, Comissao_Produtos FROM formaparcelamento WHERE (ComEntrada = 0 AND Personalizavel = 0) AND (NPagamentos >= 1 AND Cancelado IS NULL);"

        cursor.execute(consultaForma)

        formaParcelamentoFetch = cursor.fetchall()

        if not formaParcelamentoFetch:
            sqlInsert = "INSERT INTO `formaparcelamento` (`Descricao`, `ComEntrada`, `NPagamentos`, `TaxaJuro`, `PrazoMedio`, `Personalizavel`, `Tipo_Intervalo`, `Comissao_Produtos`, `Comissao_Servicos`, `DataAlteracao`, `EnviaMymobile`, `FormaRecebimento`, `Comissao_Produtos_Ent`, `Comissao_Servicos_Ent`, `Padrao_Venda`, `Padrao_OS`, `Padrao_Pre`, `TPCalculo`, `AtivaIntervalos`, `Digitavel`, `TaxaFlex`, `ListaPreco`, `PrazoFixado`, `DataPrazoFixado`, `PDesconto`, `Padrao_Orc`, `DiaExtra`, `Empresas`, `ValorMinimo`, `CodigoPreOcorrencia`, `DescricaoPreOcorrencia`, `CodigoGrupo`, `DescricaoGrupo`, `CodigoIdentificador`, `Padrao_Devolucao`, `ConsiderarOfertas`, `ParcelamentoPadrao`, `Cancelado`, `ValorMaximo`, `PDescontoMaximo`, `Considera_DescMax_produto`) VALUES ('30 DIAS', 0, 1, 0, 30, 0, 'Dias', 1, 1, '2023-10-26 11:07:42', 1, 'DINHEIRO                       1    ', 1, 1, 0, 0, 0, 'TP', 0, 0, 0, 0, 0, NULL, 0, 1, 999, NULL, 0, NULL, NULL, NULL, NULL, '', 1, 1, 0, NULL, 0, 0, 1);"
            cursor.execute(sqlInsert)

            print("Realizou o Insert da forma 30 DIAS")
            consultaForma = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel, Comissao_Produtos FROM formaparcelamento WHERE (ComEntrada = 0 AND Personalizavel = 0) AND (NPagamentos >= 1 AND Cancelado IS NULL);"

            cursor.execute(consultaForma)

            formaParcelamentoFetch = cursor.fetchall()

        formaEntrada = formaParcelamentoFetch[0][5].split(' ')

        formaParcelamento.append(formaParcelamentoFetch[0][0])  # Descricao
        formaParcelamento.append(formaParcelamentoFetch[0][3])  # PDesconto
        formaParcelamento.append(formaParcelamentoFetch[0][4])  # ValorMinimo
        formaParcelamento.append(formaEntrada[0])               # FormaRecebimento (primeira palavra)
        formaParcelamento.append(formaParcelamentoFetch[0][2])  # NPagamentos
        formaParcelamento.append(formaParcelamentoFetch[0][7])  # Comissao_Produtos

        print(formaParcelamento)

        return  formaParcelamento

    def seleciona_forma_prazo_com_comissao(self):

        formaParcelamento = []

        consultaForma = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel, Comissao_Produtos FROM formaparcelamento WHERE Comissao_Produtos > 0 AND ComEntrada = 0 AND Personalizavel = 0 AND NPagamentos >= 1 AND Cancelado IS NULL;"

        cursor.execute(consultaForma)
        formaParcelamentoFetch = cursor.fetchall()

        # Caso não exista nenhuma forma com comissão > 0
        if not formaParcelamentoFetch:

            sqlInsert = "INSERT INTO formaparcelamento (Descricao,ComEntrada,NPagamentos,TaxaJuro,PrazoMedio,Personalizavel,Tipo_Intervalo,Comissao_Produtos,Comissao_Servicos,DataAlteracao,EnviaMymobile,FormaRecebimento,Comissao_Produtos_Ent,Comissao_Servicos_Ent,Padrao_Venda,Padrao_OS,Padrao_Pre,TPCalculo,AtivaIntervalos,Digitavel,TaxaFlex,ListaPreco,PrazoFixado,DataPrazoFixado,PDesconto,Padrao_Orc,DiaExtra,Empresas,ValorMinimo,CodigoPreOcorrencia,DescricaoPreOcorrencia,CodigoGrupo,DescricaoGrupo,CodigoIdentificador,Padrao_Devolucao,ConsiderarOfertas,ParcelamentoPadrao,Cancelado,ValorMaximo,PDescontoMaximo,Considera_DescMax_produto,Padrao_EmissaoManualNF) VALUES ('FORMA_COMISSAO_PRODUTOS',0,1,0,30,0,'Dias',1,0,NOW(),1,'DINHEIRO                       1    ',0,0,0,0,0,'TP',0,0,0,0,0,NULL,0,0,999,NULL,0,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,0,0,0,0);"
            cursor.execute(sqlInsert)

            print("Realizou o Insert da forma de parcelamento 'FORMA_COMISSAO_PRODUTOS' com comissão > 0.")

            cursor.execute(consultaForma)
            formaParcelamentoFetch = cursor.fetchall()

        formaEntrada = formaParcelamentoFetch[0][5].split(' ')

        formaParcelamento.append(formaParcelamentoFetch[0][0])   # Descricao
        formaParcelamento.append(formaParcelamentoFetch[0][3])   # PDesconto
        formaParcelamento.append(formaParcelamentoFetch[0][4])   # ValorMinimo
        formaParcelamento.append(formaEntrada[0])                # FormaRecebimento simples
        formaParcelamento.append(formaParcelamentoFetch[0][2])   # NPagamentos
        formaParcelamento.append(formaParcelamentoFetch[0][7])   # Comissao_Produtos

        print(formaParcelamento)

        return formaParcelamento

    def valida_Permissoes_Usuario(self):
        
        codigo = self._get_usuario_logado()
        sql = (
            "SELECT MenuInicializacao, Avisos_menu, AvisoChequeCompensar, "
            "AvisoChequesCompensarVencidos, ContaAvisoTodas, AvisoCortes, "
            "Crm_Notify, prod_EstAviso, AvisoNcmCest, Entrega_Aviso, "
            "AvisoVendaAberta, AvisoProdutosLoteValidade, AvisoAniversariantes, "
            "AvisoClienteSemCompra, ContaAviso, AvisoNFCPendente "
            "FROM usuarios WHERE Codigo = %s"
        )
        return self._carregar_permissoes_lista(sql, (codigo,))

    def valida_Permissoes_Usuario_Auxiliar(self):
        
        codigo = self._get_usuario_logado()
        sql = (
            "SELECT uax.uau_avisa_ferias, uax.Uau_Cons_Avisos_Manutencoes_Inicializar, "
            "uax.Uau_Cons_Avisos_TransfRecusadas_Inicializar, uax.Uau_Avisos_Cotacao_Moeda, "
            "uax.Uau_Importa_Produtos, uax.uau_BloqDev_ComValorNegativo, "
            "uax.uau_PreVenda_BotaoConferencia, uax.uau_PreVenda_Conferencia_AoFinalizar "
            "FROM usuarios_auxiliar uax "
            "WHERE uax.uau_codigo_usuario = %s"
        )
        return self._carregar_permissoes_lista(sql, (codigo,))

# validaParametros.valida_Forma_Parcelamento("Venda")
# validaParametros.valida_Configuracoes_OS()
# validaParametros.valida_Config_Empresa()
# validaParametros.valida_Forma_Parcelamento("Venda")
# validaParametros.seleciona_forma_prazo()