import mysql.connector
import leituraConfig as config

dbname = config.config.Database
porta = config.config.Porta
connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database=dbname, port=porta)
cursor = connection.cursor()

class validaParametros:

    def Valida_Pametros_Config(self):

        avisosMapeados = ("AvisoVendedor, Aviso_Info_Financeiro, Aviso_Info_Financeiro_Prev, BloqueiaVendaClienteInativo, BloqVenda_CaixaFechado, "
                          "ExigeSenhaCancelarVenda, Vende_Sem_Estoque, Venda_Rapida, VendedorDiferente, ExigeSenhaMudarVendedorVenda, IncluiDireto, "
                          "Aviso_Sem_Est, IndicacaoVenda, ControlaCreditoClientes, PVexibeAnteriores, NDias_Credito_Atu, Senha_supervisor_multiplo, "
                          "ExibeFotoCli, ControlaEntregaPrevista, LocalNegociacao, ImprimirOrdemEntrega, PermiteVariasTabelas, ImprimirOrdemEntrega, "
                          "SuprimirOS, Orc_DesabilitaServico, SelecionaFunc_OS, FaturarOS, ImprimirCarneOS, ImprimirOS, Vende_Sem_Estoque_Condicional, "
                          "ImprimiCondicional, RealizaVendaSemEstoque_PreVenda, RealizaVendaSemEstoque_OS, DevolucaoAvulsa, ExigeObsTroca, Dev_PermiteAberta, "
                          "RealizaVendaSemEstoque_Venda, PrevendaBloqueioVendaParcial")

        avisosMarcados = []
        updatesParametros = []

        cursor.execute("SELECT " + avisosMapeados + " FROM config;")

        parametrosMarcados = cursor.fetchone()

        while parametrosMarcados is not None:

            for i in range(len(cursor.description)):

                desc = cursor.description[i] 
                nomeColuna = str("{}".format(desc[0]))

                if parametrosMarcados[i] is None:
                    break

                elif nomeColuna == "NDias_Credito_Atu":

                    if parametrosMarcados[i] > 0:

                        updatesParametros.append(nomeColuna)

                elif parametrosMarcados[i] == 1:

                    avisosMarcados.append(nomeColuna)

            parametrosMarcados = cursor.fetchone()

        if len(updatesParametros) > 0:

            cursor.execute("UPDATE config SET NDias_Credito_Atu = 0;")

        return avisosMarcados
    
    def valida_Config_Empresa(self):

        parametrosMapeados = ("Venda_ImprimeCupom, ImprimirVenda_FinalizarVenda, ImprimirDup_FinalizarVenda, BaixaCentralizada, BaixaAutomatico, CodigoCX, ImpRecEnt_FinalizarVenda, "
                              "ImprimirContrato_FinalizarVenda, ImpPromissoria_FinalizarVenda, ImprimirBol_FinalizarVenda, Dev_Ativa_Vale")

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

        sqlConsulta = "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento WHERE formarecebimento IS NOT NULL ORDER BY IF(Padrao_Venda = 0, Descricao, 0) LIMIT 1;"

        cursor.execute(sqlConsulta)

        formaPadraoOS = cursor.fetchall()

        formaEntrada = formaPadraoOS[0][5].split(' ')

        formaParcelamento.append(formaPadraoOS[0][0])
        formaParcelamento.append(formaPadraoOS[0][3])
        formaParcelamento.append(formaPadraoOS[0][4])
        formaParcelamento.append(formaEntrada[0])
        formaParcelamento.append(formaPadraoOS[0][2])

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

        formaEntrada = formaPadraoOS[0][5].split(' ')

        formaParcelamento.append(formaPadraoOS[0][0])
        formaParcelamento.append(formaPadraoOS[0][3])
        formaParcelamento.append(formaPadraoOS[0][4])
        formaParcelamento.append(formaEntrada[0])
        formaParcelamento.append(formaPadraoOS[0][2])

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

        return formaParcelamento

    def valida_Forma_Parcelamento(self, tela):

        formasPadrao = ("30 DIAS", "À VISTA", "PERSONALIZADA")

        formaParcelamento = []

        condicao = ""

        if tela == "Venda":
            condicao = "Padrao_Venda"
        elif tela == "OS":
            condicao = "Padrao_OS"
        elif tela == "Devolução":
            condicao = "Padrao_Devolucao"
        elif tela == "Pedido":
            condicao = "Padrao_Pre"

        sqlConsulta =  "SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento, Personalizavel FROM formaparcelamento WHERE formarecebimento IS NOT NULL ORDER BY IF("+condicao+" = 0, Descricao, 0) LIMIT 1;"

        cursor.execute(sqlConsulta)

        formaPadraoOS = cursor.fetchall()

        formaEntrada = formaPadraoOS[0][5].split(' ')

        formaParcelamento.append(formaPadraoOS[0][0])
        formaParcelamento.append(formaPadraoOS[0][3])
        formaParcelamento.append(formaPadraoOS[0][4])
        formaParcelamento.append(formaEntrada[0])
        formaParcelamento.append(formaPadraoOS[0][2])

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

        return formaParcelamento

    def seleciona_forma_prazo(self):

        consultaForma = "SELECT Descricao FROM formaparcelamento WHERE (ComEntrada = 0 AND Personalizavel = 0) AND (NPagamentos >= 1 AND Cancelado IS NULL);"

        cursor.execute(consultaForma)

        formaParcelamento = cursor.fetchall()

        if not formaParcelamento:
            sqlInsert = "INSERT INTO `formaparcelamento` (`Descricao`, `ComEntrada`, `NPagamentos`, `TaxaJuro`, `PrazoMedio`, `Personalizavel`, `Tipo_Intervalo`, `Comissao_Produtos`, `Comissao_Servicos`, `DataAlteracao`, `EnviaMymobile`, `FormaRecebimento`, `Comissao_Produtos_Ent`, `Comissao_Servicos_Ent`, `Padrao_Venda`, `Padrao_OS`, `Padrao_Pre`, `TPCalculo`, `AtivaIntervalos`, `Digitavel`, `TaxaFlex`, `ListaPreco`, `PrazoFixado`, `DataPrazoFixado`, `PDesconto`, `Padrao_Orc`, `DiaExtra`, `Empresas`, `ValorMinimo`, `CodigoPreOcorrencia`, `DescricaoPreOcorrencia`, `CodigoGrupo`, `DescricaoGrupo`, `CodigoIdentificador`, `Padrao_Devolucao`, `ConsiderarOfertas`, `ParcelamentoPadrao`, `Cancelado`, `ValorMaximo`, `PDescontoMaximo`, `Considera_DescMax_produto`) VALUES ('30 DIAS', 0, 1, 0, 30, 0, 'Dias', 1, 1, '2023-10-26 11:07:42', 1, 'DINHEIRO                       1    ', 1, 1, 0, 0, 0, 'TP', 0, 0, 0, 0, 0, NULL, 0, 1, 999, NULL, 0, NULL, NULL, NULL, NULL, '', 1, 1, 0, NULL, 0, 0, 1);"
            cursor.execute(sqlInsert)

            print("Realizou o Insert da forma 30 DIAS")
            consultaForma = "SELECT Descricao FROM formaparcelamento WHERE (ComEntrada = 0 AND Personalizavel = 0) AND (NPagamentos >= 1 AND Cancelado IS NULL);"

            cursor.execute(consultaForma)

            formaParcelamento = cursor.fetchall()
        
        formaParcelamento = formaParcelamento[0][0]

        print(formaParcelamento)

        return  formaParcelamento
    
#validaParametros.valida_Forma_Parcelamento("Venda")
#validaParametros.valida_Configuracoes_OS()
#validaParametros.valida_Config_Empresa()
#validaParametros.valida_Configuracoes_Venda()
#validaParametros.seleciona_forma_prazo()