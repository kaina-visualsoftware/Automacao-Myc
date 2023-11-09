import mysql.connector

class validaParametros:

    def conexao_banco(dbname):
        connection = mysql.connector.connect(host='10.1.1.220', user='root', password='vssql', database=dbname, port='3306')
        cursor = connection.cursor()

        return connection, cursor

    def Valida_Pametros_Com_Aviso(self, dbname):

        connection, cursor = validaParametros.conexao_banco(dbname)

        avisosMapeados = ("AvisoVendedor, Aviso_Info_Financeiro, Aviso_Info_Financeiro_Prev, BloqueiaVendaClienteInativo, BloqVenda_CaixaFechado, "
                          "ExigeSenhaCancelarVenda, Vende_Sem_Estoque, Venda_Rapida, VendedorDiferente, ExigeSenhaMudarVendedorVenda, IncluiDireto, "
                          "Aviso_Sem_Est, IndicacaoVenda, ControlaCreditoClientes, PVexibeAnteriores, NDias_Credito_Atu, Senha_supervisor_multiplo, "
                          "ExibeFotoCli, ControlaEntregaPrevista, LocalNegociacao, ImprimirOrdemEntrega, PermiteVariasTabelas")

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
    
    def valida_Config_Empresa(self, dbname):

        connection, cursor = validaParametros.conexao_banco(dbname)

        parametrosMapeados = ("Venda_ImprimeCupom, ImprimirVenda_FinalizarVenda, ImprimirDup_FinalizarVenda, BaixaCentralizada, BaixaAutomatico, CodigoCX")

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
                        break

                elif parametrosMarcados[i] == 1:

                    parametrosValidados.append(nomeColuna)

            parametrosMarcados = cursor.fetchone()

        return parametrosValidados

    def valida_Configuracoes_Venda(self, dbname):

        connection, cursor = validaParametros.conexao_banco(dbname)

        formaDeParcelamento = []
        
        formasPadrao = ("30 DIAS", "À VISTA")

        cursor.execute("SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento FROM formaparcelamento WHERE Padrao_Venda = 1 AND Personalizavel = 0;")

        configuracoesFormaDeParcelamento = cursor.fetchall()

        if not configuracoesFormaDeParcelamento:
            
            cursor.execute("SELECT Codigo FROM formaparcelamento WHERE ComEntrada = 0 AND (NPagamentos = 1 AND Personalizavel = 0);")
            formasSelecionadas = cursor.fetchall()

            if not formasSelecionadas:
                
                validaParametros.atualiza_formas(dbname)

                sqlInsert = "INSERT INTO `formaparcelamento` (`Descricao`, `ComEntrada`, `NPagamentos`, `TaxaJuro`, `PrazoMedio`, `Personalizavel`, `Tipo_Intervalo`, `Comissao_Produtos`, `Comissao_Servicos`, `DataAlteracao`, `EnviaMymobile`, `FormaRecebimento`, `Comissao_Produtos_Ent`, `Comissao_Servicos_Ent`, `Padrao_Venda`, `Padrao_OS`, `Padrao_Pre`, `TPCalculo`, `AtivaIntervalos`, `Digitavel`, `TaxaFlex`, `ListaPreco`, `PrazoFixado`, `DataPrazoFixado`, `PDesconto`, `Padrao_Orc`, `DiaExtra`, `Empresas`, `ValorMinimo`, `CodigoPreOcorrencia`, `DescricaoPreOcorrencia`, `CodigoGrupo`, `DescricaoGrupo`, `CodigoIdentificador`, `Padrao_Devolucao`, `ConsiderarOfertas`, `ParcelamentoPadrao`, `Cancelado`, `ValorMaximo`, `PDescontoMaximo`, `Considera_DescMax_produto`) VALUES ('30 DIAS', 0, 1, 0, 30, 0, 'Dias', 1, 1, '2023-10-26 11:07:42', 1, 'DINHEIRO                       1    ', 1, 1, 1, 0, 0, 'TP', 0, 0, 0, 0, 0, NULL, 0, 1, 999, NULL, 0, NULL, NULL, NULL, NULL, '', 1, 1, 0, NULL, 0, 0, 1);"
                cursor.execute(sqlInsert)

                print("Realizou o Insert da forma 30 DIAS")

                cursor.execute("SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento FROM formaparcelamento WHERE Padrao_Venda = 1;")

                configuracoesFormaDeParcelamento = cursor.fetchall()

                formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][0])
                entrada = configuracoesFormaDeParcelamento[0][1]
                NumeroDePagamentos = 1
                formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][3])
                formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][4])

                formaEntrada = configuracoesFormaDeParcelamento[0][5].split(' ')
                formaDeParcelamento.append(formaEntrada[0])

            else:

                formaParaAtualizar = str(formasSelecionadas[0][0])
                sqlUpdate = "UPDATE formaparcelamento SET Padrao_Venda = 1 WHERE Codigo = "+formaParaAtualizar
                cursor.execute(sqlUpdate)

                print("Atulizou a forma "+formaParaAtualizar+" para Padrao_Venda = 1")

                cursor.execute("SELECT Descricao, comEntrada, NPagamentos, PDesconto, ValorMinimo, FormaRecebimento FROM formaparcelamento WHERE Padrao_Venda = 1;")

                configuracoesFormaDeParcelamento = cursor.fetchall()

                formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][0])
                entrada = configuracoesFormaDeParcelamento[0][1]
                NumeroDePagamentos = configuracoesFormaDeParcelamento[0][2]
                formaDeParcelamento.append(str(configuracoesFormaDeParcelamento[0][3]))
                formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][4])

                formaEntrada = configuracoesFormaDeParcelamento[0][5].split(' ')
                formaDeParcelamento.append(formaEntrada[0])
        
        else:

            formaDeParcelamento.append(str(configuracoesFormaDeParcelamento[0][0]))
            entrada = configuracoesFormaDeParcelamento[0][1]
            NumeroDePagamentos = configuracoesFormaDeParcelamento[0][2]
            formaDeParcelamento.append(str(configuracoesFormaDeParcelamento[0][3]))
            formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][4])
            
            formaEntrada = configuracoesFormaDeParcelamento[0][5].split(' ')
            formaDeParcelamento.append(formaEntrada[0])

        if formaDeParcelamento not in formasPadrao:

            if entrada == 1 and NumeroDePagamentos == 0:
                formaDeParcelamento.clear()
                
                formaDeParcelamento.append(str('À VISTA'))

                #Tratamento para não retornar None e dar erro de comparação entre None e int
                if configuracoesFormaDeParcelamento[0][3] is None:
                    formaDeParcelamento.append(str(0))
                else:
                    formaDeParcelamento.append(str(configuracoesFormaDeParcelamento[0][3]))
                
                if configuracoesFormaDeParcelamento[0][4] is None:
                    formaDeParcelamento.append(str(0))
                else:
                    formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][4])

                formaEntrada = configuracoesFormaDeParcelamento[0][5].split(' ')
                formaDeParcelamento.append(formaEntrada[0])

                print("Vai considerar a forma: "+formaDeParcelamento[0]+" como A VISTA")
            
            elif entrada != 1 and NumeroDePagamentos > 0:
                formaDeParcelamento.clear()

                formaDeParcelamento.append(str('30 DIAS'))

                #Tratamento para não retornar None e dar erro de comparação entre None e int
                if configuracoesFormaDeParcelamento[0][3] is None:
                    formaDeParcelamento.append(str(0))
                else:
                    formaDeParcelamento.append(str(configuracoesFormaDeParcelamento[0][3]))

                if configuracoesFormaDeParcelamento[0][4] is None:
                    formaDeParcelamento.append(str(0))
                else:
                    formaDeParcelamento.append(configuracoesFormaDeParcelamento[0][4])
                
                formaEntrada = configuracoesFormaDeParcelamento[0][5].split(' ')
                formaDeParcelamento.append(formaEntrada[0])

                print("Vai considerar a forma: "+formaDeParcelamento[0]+" como 30 DIAS")

        print(formaDeParcelamento)

        return formaDeParcelamento


    def atualiza_formas(dbname):
        connection, cursor = validaParametros.conexao_banco(dbname)

        sqlUpdate = "UPDATE formaparcelamento SET Padrao_Venda = 0 WHERE Padrao_Venda = 1"

        cursor.execute(sqlUpdate)


#validaParametros.Valida_Pametros_Com_Aviso('9931-e')
#validaParametros.valida_Configuracoes_Venda('bdvinicius')