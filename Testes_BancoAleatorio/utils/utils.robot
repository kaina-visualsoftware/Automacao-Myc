*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Library    Collections
Library    Telnet
Library    String
Library    ../libs/validaTelasIni.py

Variables    ../libs/leituraConfig.py

*** Variables ***
# Conexão com o Banco de Dados
${DBHost}                                              ${config.IpServidor}
${DBName}                                              ${config.Database}
${DBPass}                                              vssql
${DBPort}                                              ${config.Porta}
${DBUser}                                              root

# Repositório de Imagens
${IMAGENS}                                             ./Testes_BancoAleatorio/images

# Sleep's    
${SLEEP_BAIXO}                                         0.7
${SLEEP_MEDIO}                                         1.5
${SLEEP_ALTO}                                          3
${TEMPO_TELA}                                          25

# Telas
${TELA_RECB_DUPLICATAS}                                tela_RecebimentoDuplicatas.png
${TELA_IMPRESSAO}                                      tela_Impressao.png
${TELA_SOLICITACAO_SENHA_USUARIO}                      tela_SolicitaSenha.png
${TELA_OBSERVACAO_PRODUTO}                             tela_ObservacaoProduto.png
${TELA_SELECIONA_TIPO_ENTREGA}                         tela_SelecionaEntrega.png
${TELA_SOLICITACAO_CREDITO}                            tela_SolicitaLiberacaoCredito.png
${TELA_CONTROLE_CRÉDITO}                               tela_ControleDeCredito.png
${TELA_CONFIRMA_LIBERACAO_CREDITO}                     tela_ConfirmaLiberacao.png
${TELA_DETALHAMENTO_SERVIÇO}                           tela_DetalhamentoServico.png
${TELA_FUNCIONARIO_COMISSIONADO}                       modal_FuncionarioComissionadoServico.png
${TELA_PERSONALIZACAO_PAGAMENTO}                       modal_PersonalizacaoPagamento.png
${TELA_RECEBIMENTO_CARTAO}                             tela_RecebimentoCartaoCreditoDebito.png
${TELA_MOVIMENTACAO_CONTA_CORRENTE}                    tela_MovimentacaoContaCorrente.png
${TELA_CONS_FINAL}                                     tela_cons_final.png
${TELA_TRANSP_FAT_NF}                                  tela_TranspFatNotaFiscal.png
${MODAL_LOCAL_NEGOCIACAO}                              tela_LocalNegociacao.png
${TELA_CONDICIONAIS}                                   tela_Condicionais.png
${TELA_DEVOLUÇÕES}                                     tela_Devolucoes.png
${TELA_ORCAMENTO}                                      tela_Orcamento.png
${TELA_ORDEM_DE_SERVICO}                               tela_OrdemDeServico.png
${TELA_VENDAS}                                         tela_VendasDeBalcao.png
${TELA_PEDIDOS}                                        tela_Pedidos.png
${TELA_CONTAS_A_PAGAR_AVULSA}                          tela_CadastroContasAPagar.png
${TELA_NOTA_FISCAL_MANUAL}                             tela_NotaFiscalPreenchimentoManual.png
${TELA_COMISSOES}                                      tela_Comissoes.png
${CAIXA_PRINCIPAL}                                     tela_CaixaPrinicipal.png
${TELA_LIBERACAO_DESCONTO_MAXIMO}                      tela_liberacaoDesconto.png
${MODAL_CANCELAR_VENDA}                                modal_CancelarVenda
${TELA_MOTIVO_PRECO_ZERADO_PRODUTO}                    tela_MotivoPrecoZeradoProduto.png
${TELA_IMPRESSAO_DIRETA}                               tela_ImpressaoDireta.png
${MODAL_PERSONALIZACAO_PAGAMENTO}                      modal_PersonalizacaoPagamento.png
${TELA_RELATORIO_COMISSOES}                            tela_RelatorioComissoes.png
${TELA_LIBERACAO_STATUS}                               tela_LiberacaoStatus.png
${TELA_AGRUPAMENTO_PRODUTO_ORCAMENTO}                  tela_Agrupamento.png
${TELA_LIBERACAO_STATUS_ORCAMENTO}                     tela_LiberacaoStatusOrcamento.png

# Telas Avisos
${AVISO_SEM_ESTOQUE}                                   aviso_QuantidadeSemEstoque.png
${AVISO_QTDE_SEM_ESTOQUE_ORCAMENTO}                    aviso_qtde_sem_estoque_orcamento.png
${AVISO_JA_INCLUIU_PRODUTO_NO_GRID}                    aviso_JaIncluiuProdutoNoGrid.png
${AVISO_USAR_ESSE_VENDEDOR}                            aviso_UsarEsseVendedor.png
${AVISO_EST_INSUFICIENTE_CONTINUAR}                    aviso_EstoqueInsuficienteContinuar.png
${AVISO_PRODUTO_JA_INCLUSO}                            aviso_ProdutoJaIncluso.png
${AVISO_CADASTRE_CANAL_DE_VENDA}                       aviso_CadastreCanaisVenda.png
${AVISO_ESPECIFIQUE_VLR_UNIT_PRODUTO}                  aviso_EspecifiqueVlrUnitProduto.png
${AVISO_DESC_ESCALA_COMISSAO}                          aviso_DescEscalaComissao.png

# Botões
${BT_CONFIRMA_CANAL_NEGOCIACAO}                        bt_ConfirmarCanal.png
${BT_SOLICITAR_CRÉDITO}                                bt_SolicitarCredito.png
${BT_SETA_DIREITA}                                     bt_SetaDireita.png
${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}                    bt_IncluirProdutoNFeSaidaManual.png
${BT_ADICIONAR}                                        bt_Adicionar.png
${BT_GRAVAR}                                           bt_Gravar.png
${BT_EDITAR}                                           bt_Editar.png
${BT_EXCLUIR}                                          bt_Excluir.png
${BT_SALVAR}                                           bt_Salvar.png
${BT_LISTAR}                                           bt_Listar.png
${BT_OK}                                               bt_Ok.png
${BT_INCLUIR}                                          bt_Incluir.png
${BT_SIM}                                              bt_Sim.png
${BT_NAO}                                              bt_Nao.png

# Inputs
${INPUT_COD_CLIENTE}                                   lb_CodCliente.png
${INPUT_COD_CLIENTE_VENDA}                             lb_CodClienteVenda.png
${INPUT_COD_CLIENTE_ORDEM_DE_SERVICO}                  lb_CodClienteOS.png
${INPUT_COD_CLIENTE_CONDICIONAL}                       lb_CodClienteCondicional.png
${INPUT_CODIGO_CLIENTE_DEVOLUCAO}                      lb_CodClienteDevolucao.png
${INPUT_COD_BENEFICIADO_DOACAO}                        lb_CodBeneficiadoDoacao.png
${INPUT_COD_CLIENTE_NFE_SAIDA_MANUAL}                  input_CodCliente.png
${INPUT_VALOR_UNITARIO_PRODUTO}                        input_ValorUnitarioProduto.png

# Labels
${LABEL_AVISO_CREDITO_LIBERADO}                        lb_CreditoLiberado.png
${LABEL_AVISO_CREDITO_LIBERADO2}                       lb_CreditoLiberado2.png
${LABEL_REF_PRODUTO}                                   label_RefProduto.png

# Rows
${ROW_PROD_INCLUSO}                                    row_ProdIncluso.png
${ROW_FUNCIONARIO_INCLUSO_SERVICO_OS}                  row_FuncComissionadoInclusoServicoOS.png

# Outros
${CORRIGE_FOCO}                                        corrigeFoco.png
${AJUSTE_FOCO}                                         bt_SetaUltimaVenda.png
${AJUSTE_FOCO_DEVOLUCAO}                               ajusteFocoDevolucao.png
${NomeTerminalExecucao}                                ${config.terminal_name}
${CHECKBOX_INFORMA_AGRUPAMENTO}                        checkBox_InformaAgrupamento.png

# Flags booleanas (inicializadas em runtime via Set Test Variable)
${Aviso_Vendedor_Existe_Comissao}                      ${False}
${Teste_Comissao_Linha_Servico}                        ${False}
${Teste_Comissao_Servico}                              ${False}
${Vendedor_Selecionada_Escalonada}                     ${False}
${Teste_Comissao_Escalonada}                           ${False}
${Teste_Comissao_Total_Venda}                          ${False}
${Teste_Comissao_Linha}                                ${False}
${Teste_Comissao_Forma_Parcelamento}                   ${False}
${OS_Vendedor_E_Tecnico_Diferentes}                    ${False}
${Cenario_Sem_Comissao_Servico}                        ${False}
${Atualizacao_Ambiente_MyCommerce}                     ${False}
${VendedorPossuiSenha}                                 ${False}
${Parametro_QtdePadraoDevolucao}                       ${False}
${Parametro_QtdePadraoDoacao}                          ${False}
${Parametro_QtdePadraoEmissaoManualSaida}              ${False}
${Parametro_QtdePadraoOrcamentos}                      ${False}
${Parametro_QtdePadraoOS}                              ${False}
${Parametro_QtdePadraoPreVendas}                       ${False}
${Parametro_QtdePadraoVendas}                          ${False}
${Teste_Orcamento_Agrupamento_Produto}                 ${False}

# Variáveis escalares (inicializadas em runtime via Set Test Variable)
${COD_PRODUTO}                                         None
${COD_SERVICO}                                         None
${COD_VENDA}                                           None
${CODIGO_OPERACAO_MOV}                                 None
${Codigo_Pedido}                                       None
${COD_ORCAMENTO}                                       None
${VALOR_FINAL_VENDA}                                   None
${VALOR_FINAL_OPERAÇÃO}                                None
${VALOR_FINAL_DEVOLUCAO}                               None
${VALOR_FINAL_OS}                                      None
${TOTAL_PEDIDO}                                        None
${codVendedor}                                         None
${Codigo_Tecnico_Servico}                              None
${NOVO_VENDEDOR}                                       None
${QUANTIDADE_PRODUTOS}                                 1
${POSICAO_PARCELA}                                     None
${PercentualComissaoFormaParcParcela_Produto}          None
${PercentualComissaoTotalVenda_Produto}                None
${Tipo_Comissao_Linha}                                 None
${PercentualComissaoTotalVenda_Servico}                None
${PercentualComissaoEscalonada_Servico}                None
${PercentualComissaoEscalonada_Servico_Executor}       None
${Desconto_Escalonada}                                 None
${Aliquota_Escalonada}                                 None
${Quantidade_Padrao_Produto}                           None
${Total_Tributos_Servico}                              0

# Variáveis indexadas / checadas com is None (requerem ${None})
${Cenario_Comissao_Linha}                              ${None}
${Cenario_Comissao_Linha_Servico}                      ${None}
${Cenario_Comissao_Tabela_Preco}                       ${None}
${FORMA_PADRAO}                                        ${None}
${FORMA_PRAZO}                                         ${None}
${FORMA_PADRAO_PEDIDO}                                 ${None}
${Valores_Parcelas}                                    ${None}
${Faixas_Escalonada}                                   ${None}
${Id_Tabela_Preco_Selecionada}                         ${None}
${Codigos_Produtos}                                    ${None}
${Codigos_Pedidos}                                     ${None}
${Desconto_Produto}                                    ${None}

# Variáveis de operação (inicializadas em runtime — compartilhadas com validacaoAviso.robot)
${Codigo_Vendedor}                                     None
${Codigo_Cliente}                                      None
${TELA}                                                None

# Parâmetros do sistema — compartilhados com validacaoAviso.robot
${Aviso_ProdutoSemEstoque}                             ${False}
${Parametro_BloqueiaOrcamentoSemEstoque}               ${False}
${Parametro_BloquearCampoNpedPreVenda}                 ${False}
${Parametro_ConsultaSCPCVenda}                         ${False}
${Parametro_Controla_Entrega}                          ${False}
${Parametro_ControlaCreditoCondicional}                ${False}
${Parametro_ControlaCreditoDescontaChequePreEmMaos}    ${False}
${Parametro_ControlaCreditoDevTroca}                   ${False}
${Parametro_ControlaCreditoGerarPreVendaOrcamento}     ${False}
${Parametro_ControlaCreditoOrcamento}                  ${False}
${Parametro_ControlaCreditoOS}                         ${False}
${Parametro_ControlaCreditoPreSeparacaoPreVenda}       ${False}
${Parametro_ControlaCreditoPreVenda}                   ${False}
${Parametro_ControlaCreditoPreVendaAuditoria}          ${False}
${Parametro_ControlaCreditoVenda}                      ${False}
${Parametro_ExibirCampoNpedVenda}                      ${False}
${Parametro_ExigeSenhaMultiplo}                        ${False}
${Parametro_FocoCampoCliente}                          ${False}
${Parametro_ImpressaoDiretaPreVenda}                   ${False}
${Parametro_IncluiDireto}                              ${False}
${Parametro_Local_Negociacao}                          ${False}
${Parametro_NaoDeduzirISSQNComissaoOS}                 ${False}
${Parametro_PesquisaCodigoCodFabricaReferencia}        ${False}
${Parametro_QuantidadePadraoProduto}                   None
${Parametro_RealizaVendaSemEstoque}                    ${False}
${Parametro_Seleciona_Funcionario_Comissao_Servico}    ${False}
${Parametro_TelasQtdePadraoProduto}                    None
${Parametro_VinculaProdutoDevolvidoEntrega}            ${False}
${Parametro_Permite_Varias_Tabelas}                    ${False}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Finalização com recebimento de duplicatas(${valor_operacao})

    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    IF    $Valores_Parcelas is not None

        Input Text    ${EMPTY}    ${Valores_Parcelas[${POSICAO_PARCELA}]}
        
    ELSE
    
        Input Text    ${EMPTY}    ${valor_operacao}
        
    END
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C

Finalização com recebimento de cartão de crédito/débito
    
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_CARTAO}    ${TEMPO_TELA}

    Press Special Key    ENTER

    Input Text    ${EMPTY}    1

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    1

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Not Contain    ${TELA_RECEBIMENTO_CARTAO}    ${TEMPO_TELA}

Finalização com o tipo bancaria 
    
    Wait Until Screen Contain    ${TELA_MOVIMENTACAO_CONTA_CORRENTE}    ${TEMPO_TELA}

    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.G

Personalização de Pagamentos
    
    ${msg}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

    IF    ${msg}

        FOR    ${I}    IN RANGE    3

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
        
        END

        Press Combination    KEY.ALT    KEY.G
        Sleep    ${SLEEP_BAIXO}
        
    END


Adicionar Vendedor e Cliente(${TELA})

    IF    '${TELA}' != 'NFeSaidasManual'

        IF    not ${Vendedor_Selecionada_Escalonada}

            Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${False}
            Sleep    ${SLEEP_BAIXO}

            ${codVendedor}    Seleciona vendedor

            Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

            # Valida se o teste será de comissão.
            Valida teste de comissão

        END

        Valida vendedor padrao

        Input Text    ${EMPTY}    ${Codigo_Vendedor}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        IF    ${Parametro_ExibirCampoNpedVenda}

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        IF    not ${Parametro_BloquearCampoNpedPreVenda}

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

            # Para cenários de comissão por Tabela de Preço POR LINHA, seleciona a tabela específica no combobox.
            # Cenários de "Tabela de Preco Geral" NÃO usam o combobox — a seleção é feita pela
            # tela popup que aparece após incluir o produto (em 'Valida a tela de preços & prazos de pagamentos').
            Seleciona Tabela De Preco No Combobox    ${Id_Tabela_Preco_Selecionada}

        ELSE IF    $Cenario_Comissao_Tabela_Preco == 'PROD__TAB_PRECO_ESCALONADA__COM_DESC' and ('${TELA}' not in ('Venda', 'Pedido', 'Orcamento') or not ${Parametro_Permite_Varias_Tabelas})

            # Para TPE: o popup de seleção de tabela só aparece em Venda/Pré-venda/Orçamento quando
            # Parametro_Permite_Varias_Tabelas está habilitado. Nas demais telas (ex: OS) ou quando
            # o parâmetro está desabilitado, a tabela deve ser selecionada pelo combobox ao informar o vendedor.
            Seleciona Tabela De Preco No Combobox    ${Id_Tabela_Preco_Selecionada}

        ELSE

            Verifica seleção de tabela de preço(${TELA})

        END
        
    END

    ${codCliente}    Seleciona cliente
    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    IF    '${TELA}' == 'Orcamento'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE}
        
    ELSE IF     '${TELA}' == 'Venda'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}

    ELSE IF     '${TELA}' == 'OrdemDeServico'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_ORDEM_DE_SERVICO}
        Sleep    ${SLEEP_MEDIO}

    ELSE IF     '${TELA}' == 'Condicional'
        
        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_CONDICIONAL}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE IF     '${TELA}' == 'Devolução'
        
        SikuliLibrary.Double Click    ${INPUT_CODIGO_CLIENTE_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}

    ELSE IF     '${TELA}' == 'Pedido'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE IF    '${TELA}' == 'Doação'

        SikuliLibrary.Click    ${INPUT_COD_BENEFICIADO_DOACAO}
        Sleep    ${SLEEP_BAIXO}

    ELSE IF    '${TELA}' == 'NFeSaidasManual'

        SikuliLibrary.Click    ${INPUT_COD_CLIENTE_NFE_SAIDA_MANUAL}
        Sleep    ${SLEEP_BAIXO}

    END
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    # Reaproveitando a tela que está para validar apenas na inserção de produto que precisa de estoque o estoque em Pedidos.
    Set Test Variable    ${TELA}

    ${Forma_Padrao_Cliente}    valida_Forma_Parcelamento_Cliente    ${Codigo_Cliente}

    IF    $Forma_Padrao_Cliente != False
        
        Log To Console    Possui forma padrão no cliente: ${Forma_Padrao_Cliente}

        Set Test Variable    ${FORMA_PADRAO}    ${Forma_Padrao_Cliente}

    END

Seleciona vendedor
    
    ${codVendedor}    Query    SELECT c.Codigo FROM clientes AS c WHERE (c.Tipo LIKE 'D' OR c.Tipo LIKE 'V') AND c.Ativo = -1 AND c.`Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codVendedor[0][0]}

Seleciona cliente 
    
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) AND Codigo <> 1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    
    IF    len($codCliente) == 0
        
        Fail    Nenhum cliente foi encontrado.

    END

    RETURN    ${codCliente[0][0]}

Seleciona plano de contas - Débito

    ${Plano_de_Contas}    Query    SELECT ID FROM plano_subcontas WHERE IDConta IN (SELECT ID FROM plano_contas WHERE Tipo = 'D') AND Excluido IS NULL ORDER BY RAND() LIMIT 1;

    IF    len($Plano_de_Contas) == 0
        
        Fail    Nenhum plano de contas débito encontrado.

    END

    RETURN    ${Plano_de_Contas[0][0]}

Seleciona plano de contas - Crédito
    
    ${Plano_de_Contas}    Query    SELECT ID FROM plano_subcontas WHERE IDConta IN (SELECT ID FROM plano_contas WHERE Tipo LIKE 'R') ORDER BY RAND() LIMIT 1;

    RETURN    ${Plano_de_Contas[0][0]}

Seleciona modalidade de cobrança 
    
    ${Modalidade_de_Cobranca}    Query    SELECT Codigo FROM modalidadecb WHERE Cancelado IS NULL ORDER BY RAND() LIMIT 1;

    RETURN    ${Modalidade_de_Cobranca[0][0]}

#Essa Keyword é necessária para que não seja preciso duplicar o código de seleção de vendedor e cliente e nem criar um outro montador de cenário
#Ela simplesmente valida o nome do teste em execução e se for de comissão, irá selecionar um funcionário que seja comissionado 
Valida teste de comissão
        
    ${Test_Comissao}    Run Keyword And Return Status    Should Contain    ${SUITE_NAME}    Comissoes
    
    IF    not ${Test_Comissao}
        RETURN
    END

    ${Teste_Comissao_Escalonada}            Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Escalonada
    ${Teste_Comissao_Total_Venda}           Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Total Venda
    ${Teste_Comissao_Linha}                 Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha
    ${Teste_Comissao_Forma_Parcelamento}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Forma Parcelamento
    ${Teste_Comissao_Servico}               Run Keyword And Return Status    Should Contain    ${TEST_NAME}    serviço
    ${Teste_Comissao_Devolucao}             Run Keyword And Return Status    Should Contain    ${TEST_NAME}    devolução
    ${Teste_Comissao_Tab_Preco_Geral}       Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Tabela de Preço Geral

    Set Test Variable    ${Teste_Comissao_Escalonada}
    Set Test Variable    ${Teste_Comissao_Total_Venda}
    Set Test Variable    ${Teste_Comissao_Linha}
    Set Test Variable    ${Teste_Comissao_Forma_Parcelamento}
    Set Test Variable    ${Teste_Comissao_Servico}
    Set Test Variable    ${Teste_Comissao_Devolucao}
    Set Test Variable    ${Teste_Comissao_Tab_Preco_Geral}

    ${Eh_Comissao_Linha_Simples}           Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha Simples
    ${Eh_Comissao_Linha_Dif_Vendedor}      Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha Diferenciada Por Vendedor
    ${Eh_Comissao_Linha_Mista}             Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha Mista
    ${Eh_Comissao_Linha_Tabela_Preco}      Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha Tabela de Preco

    IF    ${Teste_Comissao_Linha}

        IF    ${Eh_Comissao_Linha_Simples}

            Set Test Variable    ${Tipo_Comissao_Linha}    Simples

        ELSE IF    ${Eh_Comissao_Linha_Dif_Vendedor}

            Set Test Variable    ${Tipo_Comissao_Linha}    Diferenciada Por Vendedor

        ELSE IF    ${Eh_Comissao_Linha_Mista}

            Set Test Variable    ${Tipo_Comissao_Linha}    Mista

        ELSE IF    ${Eh_Comissao_Linha_Tabela_Preco}

            Set Test Variable    ${Tipo_Comissao_Linha}    Tabela de Preco

        ELSE IF    ${Teste_Comissao_Tab_Preco_Geral}

            # Testes de "Tabela de Preço Geral" contêm "Linha" implicitamente no contexto,
            # mas usam PComissao da tabela geral, não comissaoporlinha_tabpreco.
            Set Test Variable    ${Tipo_Comissao_Linha}    Tabela de Preco Geral

        ELSE
            
            Fail    Teste de comissão por linha detectado, mas nenhum subtipo reconhecido no nome do Test Case ('${TEST_NAME}'). Inclua no nome: 'Linha Simples', 'Linha Diferenciada Por Vendedor', 'Linha Mista' ou 'Linha Tabela de Preco'.

        END

    ELSE IF    ${Teste_Comissao_Tab_Preco_Geral}

        # Teste de tabela de preço geral: NÃO contém a palavra "Linha" no nome,
        # mas requer vendedor com ComissaoDiferenciadapor = 'L'.
        Set Test Variable    ${Tipo_Comissao_Linha}    Tabela de Preco Geral

    END

    ${Dados_Vendedor}    Query    SELECT ComissaoDiferenciadapor, ComissaoPercentualProdutos, ComissaoServicos, ComissaoPercentualServicos, ComissaoVendaProdutos, Codigo, RazaoSocial FROM clientes WHERE Codigo = ${Codigo_Vendedor}

    ${Tipo_Comissao}    Set Variable    ${Dados_Vendedor[0][0]}
    ${Eh_Tab_Preco_Escalonada}    Evaluate    $Cenario_Comissao_Tabela_Preco == 'PROD__TAB_PRECO_ESCALONADA__COM_DESC'

    IF    ${Teste_Comissao_Escalonada}

        IF    ${Eh_Tab_Preco_Escalonada}

            ${SelecionarVendedor}    Set Variable    ${False}

            IF    $Tipo_Comissao != 'TPE' or '${Dados_Vendedor[0][4]}' != '1'

                ${SelecionarVendedor}    Set Variable    ${True}

            END

            IF    ${SelecionarVendedor}

                Seleciona vendedor comissionado('TPE')

            END

            ${resultado_tabela}    Query    SELECT t.Codigo, t.Descricao FROM tabelas t WHERE t.Cancelada IS NULL AND t.TP_Preco = 'G' AND t.TpComissao = 'E' AND EXISTS (SELECT 1 FROM comissao_escalonadatab cet WHERE cet.IDTabela = t.Codigo) AND EXISTS (SELECT 1 FROM comissao_escalonadatab cet0 WHERE cet0.IDTabela = t.Codigo AND cet0.Ate = 0) ORDER BY RAND() LIMIT 1;

            IF    len($resultado_tabela) == 0
                Fail    Nenhuma tabela de preço (TP_Preco='G', TpComissao='E') com faixas em comissao_escalonadatab (incluindo faixa Ate=0) foi encontrada.
            END

            ${Id_Tabela_Preco_Selecionada}           Set Variable    ${resultado_tabela[0][0]}
            ${Descricao_Tabela_Preco_Selecionada}    Set Variable    ${resultado_tabela[0][1]}

            Set Test Variable    ${Id_Tabela_Preco_Selecionada}

            Log To Console    Tabela de preço escalonada selecionada: ${Id_Tabela_Preco_Selecionada} - ${Descricao_Tabela_Preco_Selecionada}

            Gera desconto aleatório para tabela de preço escalonada    ${Id_Tabela_Preco_Selecionada}

            Log To Console    \nComissão por tabela de preço escalonada.

        ELSE

            ${SelecionarVendedor}    Set Variable    ${False}

            IF    $Tipo_Comissao != 'D' or '${Dados_Vendedor[0][4]}' != '1'

                ${SelecionarVendedor}    Set Variable    ${True}

            ELSE IF    ${Teste_Comissao_Servico} and ($Dados_Vendedor[0][2] is None or '${Dados_Vendedor[0][2]}' != '1')

                ${SelecionarVendedor}    Set Variable    ${True}

            ELSE IF    ${Teste_Comissao_Servico} and not ${Cenario_Sem_Comissao_Servico} and ($Dados_Vendedor[0][3] is None or ${Dados_Vendedor[0][3]} == 0)

                # Cenário exige percentual > 0, mas vendedor atual tem 0 ou NULL
                ${SelecionarVendedor}    Set Variable    ${True}

            ELSE IF    ${Teste_Comissao_Servico} and ${Cenario_Sem_Comissao_Servico} and $Dados_Vendedor[0][3] is not None and ${Dados_Vendedor[0][3]} > 0

                # Cenário exige percentual = 0/NULL, mas vendedor atual tem > 0
                ${SelecionarVendedor}    Set Variable    ${True}

            END

            IF    ${SelecionarVendedor}

                Seleciona vendedor comissionado escalonada

            ELSE IF    ${Teste_Comissao_Servico}

                Set Test Variable    ${PercentualComissaoEscalonada_Servico}    ${Dados_Vendedor[0][3]}

            END

            Gera desconto aleatório para comissão escalonada

            Log To Console    \nComissão escalonada (Tipo Padrão).

        END

    ELSE IF    ${Teste_Comissao_Total_Venda}
        
        ${SelecionarVendedor}    Set Variable    ${False}
        
        IF    $Tipo_Comissao != 'T' or (${Teste_Comissao_Servico} and '${Dados_Vendedor[0][2]}' != '1')

            ${SelecionarVendedor}    Set Variable    ${True}

        ELSE

            IF    $Dados_Vendedor[0][1] is not None and ${Dados_Vendedor[0][1]} > 0

                Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${Dados_Vendedor[0][1]}

            ELSE

                ${SelecionarVendedor}    Set Variable    ${True}

            END
            
            IF    ${Teste_Comissao_Servico}

                IF    $Dados_Vendedor[0][3] is not None and ${Dados_Vendedor[0][3]} > 0

                    Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

                ELSE

                    ${SelecionarVendedor}    Set Variable    ${True}

                END

            END

        END

        IF    ${SelecionarVendedor}

            Seleciona vendedor comissionado('T')

        END

        Log To Console    \nComissão sobre total da venda.

    ELSE IF    ${Teste_Comissao_Linha}

        ${SelecionarVendedor}    Set Variable    ${False}

        IF    $Tipo_Comissao != 'L' or '${Dados_Vendedor[0][4]}' != '1'

            ${SelecionarVendedor}    Set Variable    ${True}

        ELSE IF    ${Teste_Comissao_Servico} and ($Dados_Vendedor[0][2] is None or '${Dados_Vendedor[0][2]}' != '1')

            ${SelecionarVendedor}    Set Variable    ${True}

        END

        # Em testes com produto e serviço combinados e MESMO_VEND, o cenário de serviço é mais restritivo (inclui filtro de AliquotaExecucao), então deve prevalecer na validação/seleção do vendedor.
        ${Cenario_Linha_Para_Selecao_Vendedor}    Set Variable    ${Cenario_Comissao_Linha}
        ${_cenario_servico_esta_definido}    Evaluate    $Cenario_Comissao_Linha_Servico is not None

        IF    ${_cenario_servico_esta_definido}
            ${_cenario_servico_usa_mesmo_vendedor}    Evaluate    'MESMO_VEND' in $Cenario_Comissao_Linha_Servico

            IF    ${_cenario_servico_usa_mesmo_vendedor}
                ${Cenario_Linha_Para_Selecao_Vendedor}    Set Variable    ${Cenario_Comissao_Linha_Servico}
            END
        END

        IF    ${SelecionarVendedor} == ${False}

            ${cenario_definido}    Evaluate    $Cenario_Comissao_Linha is not None

            IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

                IF    ${cenario_definido}

                    IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__DIF_POR_VEND__COM_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__DIF_POR_VEND__SEM_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    END

                END

            ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

                IF    ${cenario_definido}

                    IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__MISTA__COM_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__MISTA__COM_ALIQ_ZERO'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__MISTA__SEM_REG_CPLV'

                        ${vendedor_tem_cpv}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1;

                        IF    ${vendedor_tem_cpv}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO'

                        ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0;

                        IF    not ${vendedor_atende_ao_cenario}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV' or '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

                        ${vendedor_tem_cpv}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cp.Tipo = 'D' AND cp.Mista = 1;

                        IF    ${vendedor_tem_cpv}
                            ${SelecionarVendedor}    Set Variable    ${True}
                        END

                    END

                END

            ELSE IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

                IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__TAB_PRECO__COM_ALIQ'

                    ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_tabpreco cpt INNER JOIN comissaoporlinha cp ON cp.Codigo = cpt.IDLinhaComissao WHERE cp.Tipo = 'DT' AND cpt.Aliquota > 0;

                    IF    not ${vendedor_atende_ao_cenario}
                        ${SelecionarVendedor}    Set Variable    ${True}
                    END

                ELSE IF    '${Cenario_Linha_Para_Selecao_Vendedor}' == 'PROD__TAB_PRECO__SEM_ALIQ'

                    ${vendedor_atende_ao_cenario}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_tabpreco cpt INNER JOIN comissaoporlinha cp ON cp.Codigo = cpt.IDLinhaComissao WHERE cp.Tipo = 'DT' AND cpt.Aliquota = 0;

                    IF    not ${vendedor_atende_ao_cenario}
                        ${SelecionarVendedor}    Set Variable    ${True}
                    END

                END

            END

        END

        IF    ${SelecionarVendedor}

            IF    $Cenario_Comissao_Linha is None
                Fail    Variável \${Cenario_Comissao_Linha} não definida. Para testes de comissão por linha, defina o cenário no [Setup] ou no corpo do teste antes de chamar o montadorDeCenarios.
            END

            # Guarda o cenário original de produto antes da seleção, pois 'Seleciona Vendedor Comissão Linha' sobrescreve ${Cenario_Comissao_Linha} com o cenário passado como argumento.
            ${_cenario_produto_original}    Set Variable    ${Cenario_Comissao_Linha}

            Seleciona Vendedor Comissão Linha    ${Tipo_Comissao_Linha}    ${Cenario_Linha_Para_Selecao_Vendedor}

            # Restaura o cenário de produto original se foi substituído pelo cenário de serviço
            IF    '${Cenario_Linha_Para_Selecao_Vendedor}' != '${_cenario_produto_original}'
                Set Test Variable    ${Cenario_Comissao_Linha}    ${_cenario_produto_original}
            END

        END

        # Para cenários de Tabela de Preço, determina qual idTabela usar e salva como variável de teste.
        # Deve rodar SEMPRE (independente de SelecionarVendedor) pois a seleção de produto depende do idTabela.
        IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

            IF    '${Cenario_Comissao_Linha}' == 'PROD__TAB_PRECO__COM_ALIQ'

                ${resultado_tabela}    Query    SELECT cpt.idTabela, t.Descricao FROM comissaoporlinha_tabpreco cpt INNER JOIN comissaoporlinha cp ON cp.Codigo = cpt.IDLinhaComissao INNER JOIN tabelas t ON t.Codigo = cpt.idTabela WHERE cp.Tipo = 'DT' AND cpt.Aliquota > 0 AND t.Cancelada IS NULL AND t.TP_Preco = 'G' ORDER BY RAND() LIMIT 1;

            ELSE IF    '${Cenario_Comissao_Linha}' == 'PROD__TAB_PRECO__SEM_ALIQ'

                ${resultado_tabela}    Query    SELECT cpt.idTabela, t.Descricao FROM comissaoporlinha_tabpreco cpt INNER JOIN comissaoporlinha cp ON cp.Codigo = cpt.IDLinhaComissao INNER JOIN tabelas t ON t.Codigo = cpt.idTabela WHERE cp.Tipo = 'DT' AND cpt.Aliquota = 0 AND t.Cancelada IS NULL AND t.TP_Preco = 'G' ORDER BY RAND() LIMIT 1;

            END

            IF    len($resultado_tabela) == 0
                Fail    Nenhuma tabela de preço encontrada na comissaoporlinha_tabpreco para cenário '${Cenario_Comissao_Linha}'.
            END

            ${Id_Tabela_Preco_Selecionada}           Set Variable    ${resultado_tabela[0][0]}
            ${Descricao_Tabela_Preco_Selecionada}    Set Variable    ${resultado_tabela[0][1]}

            Set Test Variable    ${Id_Tabela_Preco_Selecionada}

            Log To Console    \nTabela de preço selecionada: ${Id_Tabela_Preco_Selecionada} - ${Descricao_Tabela_Preco_Selecionada}

        END

        IF    ${Teste_Comissao_Servico}

            Set Test Variable    ${Teste_Comissao_Linha_Servico}    ${True}
                
        END
    
    ELSE IF    ${Teste_Comissao_Forma_Parcelamento}
        
        ${SelecionarVendedor}    Set Variable    ${False}

        # Necessário para os cenários de comissões por forma de parcelamento.
        Set Test Variable    ${FORMA_PRAZO}

        IF    $Tipo_Comissao != 'F' or '${Dados_Vendedor[0][4]}' != '1'

            ${SelecionarVendedor}    Set Variable    ${True}

        END

        IF    ${SelecionarVendedor}

            Seleciona vendedor comissionado('F')

        END

        IF    ${FORMA_PRAZO[5]} == 0

            ${FORMA_PRAZO}    validaParametros.Seleciona Forma Prazo Com Comissao
            
        END

        Set Test Variable    ${PercentualComissaoFormaParcParcela_Produto}    ${FORMA_PRAZO[5]}
        Set Test Variable    ${FORMA_PRAZO}
        Set Test Variable    ${FORMA_PADRAO}    ${FORMA_PRAZO}

        Log To Console    \nComissão sobre formas de parcelamento.

    ELSE IF    ${Teste_Comissao_Tab_Preco_Geral}

        # Tabela de Preço Geral: produto SEM vínculo de comissão por linha (CodigoComissao nulo/0),
        # mas o vendedor DEVE estar cadastrado para comissão por linha (ComissaoDiferenciadapor = 'L').
        # A comissão é baseada em tabelas.PComissao.

        ${SelecionarVendedor}    Set Variable    ${False}

        IF    $Tipo_Comissao != 'L' or '${Dados_Vendedor[0][4]}' != '1'
            ${SelecionarVendedor}    Set Variable    ${True}
        END

        IF    ${SelecionarVendedor}

            IF    $Cenario_Comissao_Tabela_Preco is None
                Fail    Variável \${Cenario_Comissao_Tabela_Preco} não definida. Para testes de comissão por tabela de preço geral, defina o cenário no [Setup] antes de chamar o montadorDeCenarios.
            END

            Seleciona Vendedor Comissão Linha    Tabela de Preco Geral    ${Cenario_Comissao_Tabela_Preco}

        END

        # Determina qual tabela de preço usar na tela de seleção:
        # COM_PERC → tabela com PComissao > 0
        # SEM_PERC → tabela com PComissao = 0 (ou NULL)
        IF    '${Cenario_Comissao_Tabela_Preco}' == 'PROD__TAB_PRECO_GERAL__COM_PERC'

            ${resultado_tabela}    Query    SELECT t.Codigo, t.Descricao FROM tabelas t WHERE t.Cancelada IS NULL AND t.PComissao > 0 AND t.TP_Preco = 'G' AND t.TpComissao = 'G' ORDER BY RAND() LIMIT 1;
            
        ELSE IF    '${Cenario_Comissao_Tabela_Preco}' == 'PROD__TAB_PRECO_GERAL__SEM_PERC'

            ${resultado_tabela}    Query    SELECT t.Codigo, t.Descricao FROM tabelas t WHERE t.Cancelada IS NULL AND (t.PComissao = 0 OR t.PComissao IS NULL) AND t.TP_Preco = 'G' AND t.TpComissao = 'G' ORDER BY RAND() LIMIT 1;

        END

        IF    len($resultado_tabela) == 0
            Fail    Nenhuma tabela de preço encontrada para cenário '${Cenario_Comissao_Tabela_Preco}'. Verifique a coluna PComissao na tabela 'tabelas'.
        END

        ${Id_Tabela_Preco_Selecionada}           Set Variable    ${resultado_tabela[0][0]}
        ${Descricao_Tabela_Preco_Selecionada}    Set Variable    ${resultado_tabela[0][1]}

        Set Test Variable    ${Id_Tabela_Preco_Selecionada}

        Log To Console    Tabela de preço selecionada: ${Id_Tabela_Preco_Selecionada} - ${Descricao_Tabela_Preco_Selecionada}

        Log To Console    \nComissão por tabela de preço geral.

    END

Seleciona vendedor comissionado(${Tipo_Comissao_Selecionar})

    IF    ${Tipo_Comissao_Selecionar} == 'T'

        IF    ${Teste_Comissao_Servico}

            ${consultaVendedor}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor, ComissaoPercentualServicos FROM clientes WHERE ComissaoServicos = 1 AND ComissaoPercentualServicos > 0 AND ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

            ${vendComissServicoTotalVenda}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

            IF    not ${vendComissServicoTotalVenda}
                
                Fail    Não há cadastro de vendedor comissionado por serviço sobre o total da venda.
                
            END

            ${Dados_Vendedor}    Query    ${consultaVendedor}

            Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

        ELSE

            ${Dados_Vendedor}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

        END

    ELSE

        IF    ${Teste_Comissao_Servico}

            ${consultaVendedor}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoServicos = 1 AND ComissaoVendaProdutos = 1 ORDER BY RAND() LIMIT 1;

            ${vendComissServico}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

            IF    not ${vendComissServico}

                Fail    Não há cadastro de vendedor comissionado por serviço para o tipo de comissão ${Tipo_Comissao_Selecionar}.
                
            END

            ${Dados_Vendedor}    Query    ${consultaVendedor}

        ELSE
         
            ${Dados_Vendedor}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoVendaProdutos = 1 ORDER BY RAND() LIMIT 1;

        END

    END

    IF    len($Dados_Vendedor) > 0
    
        Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${True}
        Set Test Variable    ${Codigo_Vendedor}    ${Dados_Vendedor[0][0]}

        IF    ${Teste_Comissao_Total_Venda}

            Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${Dados_Vendedor[0][1]}

        END

    END

Seleciona vendedor comissionado escalonada

    IF    ${Teste_Comissao_Servico}

        IF    ${Cenario_Sem_Comissao_Servico}
            ${filtro_percentual}    Set Variable    AND (c.ComissaoPercentualServicos = 0 OR c.ComissaoPercentualServicos IS NULL)
        ELSE
            ${filtro_percentual}    Set Variable    AND c.ComissaoPercentualServicos > 0
        END

        ${consultaVendedor}    Set Variable    SELECT c.Codigo, c.ComissaoPercentualServicos FROM clientes c WHERE c.ComissaoDiferenciadapor = 'D' AND c.ComissaoVendaProdutos = 1 AND c.ComissaoServicos = 1 ${filtro_percentual} AND c.Tipo IN ('D','V') AND c.Ativo = -1 AND c.Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

        ${vendedorExiste}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

        IF    not ${vendedorExiste}
            Fail    Não há cadastro de vendedor comissionado escalonada (tipo 'D') com comissão de serviço habilitada (Cenario_Sem_Comissao_Servico=${Cenario_Sem_Comissao_Servico}).
        END

        ${Dados_Vendedor}    Query    ${consultaVendedor}

        Set Test Variable    ${Codigo_Vendedor}    ${Dados_Vendedor[0][0]}
        Set Test Variable    ${PercentualComissaoEscalonada_Servico}    ${Dados_Vendedor[0][1]}

    ELSE

        ${consultaVendedor}    Set Variable    SELECT c.Codigo FROM clientes c WHERE c.ComissaoDiferenciadapor = 'D' AND c.ComissaoVendaProdutos = 1 AND c.Tipo IN ('D','V') AND c.Ativo = -1 AND c.Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

        ${vendedorExiste}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

        IF    not ${vendedorExiste}
            Fail    Não há cadastro de vendedor comissionado escalonada (tipo 'D').
        END

        ${Dados_Vendedor}    Query    ${consultaVendedor}

        Set Test Variable    ${Codigo_Vendedor}    ${Dados_Vendedor[0][0]}

    END

Seleciona Vendedor Comissão Linha
    [Arguments]    ${tipo_linha}    ${cenario}

    IF    ${Teste_Comissao_Servico}
        ${filtro_servico}    Set Variable    AND c.ComissaoServicos = 1
    ELSE
        ${filtro_servico}    Set Variable    ${EMPTY}
    END

    ${base_query}    Set Variable    SELECT c.Codigo, c.ComissaoDiferenciadapor FROM clientes c
    ${base_where}    Set Variable    c.ComissaoDiferenciadapor = 'L' AND c.ComissaoVendaProdutos = 1 AND c.Tipo IN ('D','V') AND c.Ativo = -1 AND c.Status = 'ATIVA' ${filtro_servico}

    # Subconsulta reutilizável: garante que a linha de comissão possui ao menos um serviço ativo vinculado
    ${filtro_servico_na_linha}    Set Variable    AND cpv.IDLinhaComissao IN (SELECT srv.TabelaComissao FROM servicos srv WHERE srv.\`Status\` = 'g' AND srv.Ativo = 1 AND srv.Inativo = 0)

    IF    '${tipo_linha}' == 'Simples'

        ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} ORDER BY RAND() LIMIT 1;

    ELSE IF    '${tipo_linha}' == 'Diferenciada Por Vendedor'

        IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__DIF_POR_VEND__COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__DIF_POR_VEND__SEM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ'
        
            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ'
        
            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_ALIQ' or '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_SEM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE

            Fail    Cenário '${cenario}' não mapeado para Diferenciada Por Vendedor na seleção de vendedor.

        END

    ELSE IF    '${tipo_linha}' == 'Mista'

        IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__MISTA__COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__MISTA__COM_ALIQ_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__MISTA__SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cp.Tipo = 'D' AND cp.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv.CodigoVendedor FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cp ON cp.Codigo = cpv.IDLinhaComissao WHERE cp.Tipo = 'D' AND cp.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE

            Fail    Cenário '${cenario}' não mapeado para Mista na seleção de vendedor.

        END

    ELSE IF    '${tipo_linha}' == 'Tabela de Preco'

        IF    '${cenario}' == 'PROD__TAB_PRECO__COM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_tabpreco cpt ON cpt.IDLinhaComissao IN (SELECT cp.Codigo FROM comissaoporlinha cp WHERE cp.Tipo = 'DT') WHERE ${base_where} AND cpt.Aliquota > 0 ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__TAB_PRECO__SEM_ALIQ'

            ${consultaVendedor}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_tabpreco cpt ON cpt.IDLinhaComissao IN (SELECT cp.Codigo FROM comissaoporlinha cp WHERE cp.Tipo = 'DT') WHERE ${base_where} AND cpt.Aliquota = 0 ORDER BY RAND() LIMIT 1;

        ELSE

            Fail    Cenário '${cenario}' não mapeado para Tabela de Preco na seleção de vendedor.

        END

    ELSE IF    '${tipo_linha}' == 'Tabela de Preco Geral'

        # Tabela de Preço Geral: produto SEM CodigoComissao (sem vínculo de comissão por linha).
        # O vendedor deve ser comissionado por linha (ComissaoDiferenciadapor = 'L').
        # A comissão é calculada com base em tabelas.PComissao.

        IF    '${cenario}' == 'PROD__TAB_PRECO_GERAL__COM_PERC'

            # Vendedor com linha de comissão cadastrada (qualquer tipo) — a tabela de preço usada deve ter PComissao > 0
            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PROD__TAB_PRECO_GERAL__SEM_PERC'

            # Vendedor com linha de comissão cadastrada (qualquer tipo) — a tabela de preço usada deve ter PComissao = 0
            ${consultaVendedor}    Set Variable    ${base_query} WHERE ${base_where} ORDER BY RAND() LIMIT 1;

        ELSE

            Fail    Cenário '${cenario}' não mapeado para Tabela de Preco Geral na seleção de vendedor.

        END

    END

    ${vendedorExiste}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

    IF    not ${vendedorExiste}
        Fail    Nenhum vendedor elegível encontrado para comissão por linha tipo '${tipo_linha}', cenário '${cenario}'. Verifique os cadastros no MyCommerce.
    END

    ${Dados_Vendedor}    Query    ${consultaVendedor}

    Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${True}
    Set Test Variable    ${Codigo_Vendedor}    ${Dados_Vendedor[0][0]}
    Set Test Variable    ${Cenario_Comissao_Linha}    ${cenario}

Seleciona Tabela De Preco No Combobox
    [Arguments]    ${id_tabela}

    ${resultado_posicao}    Query    SELECT COUNT(*) FROM tabelas WHERE Cancelada IS NULL AND Codigo < ${id_tabela};
    ${posicao}    Set Variable    ${resultado_posicao[0][0]}

    Press Special Key    HOME
    Sleep    ${SLEEP_BAIXO}

    FOR    ${i}    IN RANGE    ${posicao}
        Press Special Key    DOWN
        Sleep    0.2
    END

    Sleep    ${SLEEP_BAIXO}

Seleciona tabela de preço na tela de preços e prazos de pagamentos
    [Arguments]    ${id_tabela}

    # Consulta a posição (0-indexed) da tabela alvo no grid da tela popup
    ${resultado_posicao}    Query    SELECT COUNT(*) FROM tabelas WHERE Cancelada IS NULL AND Codigo < ${id_tabela};
    ${posicao}    Set Variable    ${resultado_posicao[0][0]}

    # Vai para o topo da listagem e navega DOWN até a posição da tabela desejada
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    PAGE_UP
    Sleep    ${SLEEP_BAIXO}

    FOR    ${i}    IN RANGE    ${posicao} - 1
        Press Special Key    DOWN
        Sleep    0.2
    END

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

Valida vendedor padrao
    
    ${VENDEDOR_PADRAO}    Run Keyword And Return Status    Check If Exists In Database    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente} AND c.CodigoVendedor IS NOT NULL;
    
    IF     ${VENDEDOR_PADRAO}

        ${NOVO_VENDEDOR}    Query    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente};

        Set Test Variable    ${codVendedor}    ${NOVO_VENDEDOR}
    
    END

Inserir serviço

    ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IS NULL ORDER BY RAND() LIMIT 1;

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.S

    Sleep    ${SLEEP_BAIXO}
    ${codServico}    Query    ${consultaServico}

    Sleep    ${SLEEP_MEDIO}
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    ${consultaServico}

    IF    ${condicao}
    
        Input Text    ${EMPTY}    ${codServico[0][0]}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0
            
            Insere detalhamento no serviço

        END

        Set Test Variable    ${COD_SERVICO}    ${codServico[0][0]} 

    ELSE

        Fail    Banco de dados sem serviço cadastrado ou serviço inativo.
        
    END

Seleciona serviço com linha de comissão

    IF    '${Tipo_Comissao_Linha}' == 'Simples'

        ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'N' AND cl.Aliquota > 0) ORDER BY RAND() LIMIT 1;

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

        ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL)) ORDER BY RAND() LIMIT 1;

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

        ${cenario}    Set Variable    ${Cenario_Comissao_Linha}

        IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND cl.Mista = 1) AND s.TabelaComissao NOT IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor}) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0 AND cpv.AliquotaExecucao > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0 AND cpv.AliquotaExecucao > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND cl.Mista = 1) AND s.TabelaComissao NOT IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor}) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Tecnico_Servico} AND cpv.Aliquota > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Tecnico_Servico} AND cpv.Aliquota = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Tecnico_Servico} AND cpv.AliquotaExecucao > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Tecnico_Servico} AND cpv.AliquotaExecucao = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND cl.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND cl.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Tecnico_Servico} AND cpv.AliquotaExecucao = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ'

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0) ORDER BY RAND() LIMIT 1;

        ELSE

            ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo = 'D' AND cl.Mista = 1) ORDER BY RAND() LIMIT 1;

        END

    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.S

    Sleep    ${SLEEP_BAIXO}
    ${codServico}    Query    ${consultaServico}

    Sleep    ${SLEEP_MEDIO}
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    ${consultaServico}

    IF    ${condicao}
        
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${codServico[0][0]}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0 
            
            Insere detalhamento no serviço

        END

        Set Test Variable    ${COD_SERVICO}    ${codServico[0][0]} 

    ELSE

        Fail    Cliente sem serviços ou serviço inativo, OS sem serviço.
        
    END

Inserir Produto normal - Necessita de estoque

    ${Qtde_Minima_Estoque}    Set Variable    0

    IF    '${TELA}' == 'NFeSaidasManual'

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.P
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_SETA_DIREITA}
        Sleep    ${SLEEP_BAIXO}
        
        Type With Modifiers    P    SHIFT
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.P
        Sleep    ${SLEEP_BAIXO}

    END

    IF    ${Parametro_QuantidadePadraoProduto} == 0

        ${Qtde_Minima_Estoque}    Set Variable    1

    ELSE

        ${Qtde_Minima_Estoque}    Set Variable    ${Parametro_QuantidadePadraoProduto}

    END

    IF    '${TELA}' == 'Pedido'
        
        ${codProduto}    Query    SELECT p.Codigo AS codigoProduto FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto LEFT JOIN (SELECT CodigoProduto, Empresa, SUM(Quantidade - QtdeGerada) AS QuantidadePendente FROM pedidosvendaprodutos WHERE Cancelada IS NULL AND Quantidade > QtdeGerada GROUP BY CodigoProduto, Empresa) AS pendente ON p.Codigo = pendente.CodigoProduto AND pe.Empresa = pendente.Empresa WHERE p.ModalidadeControle LIKE 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND pe.Estoque >= ${Qtde_Minima_Estoque} AND pe.Estoque > COALESCE(pendente.QuantidadePendente, 0) ORDER BY RAND() LIMIT 1;

    ELSE

        ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque >= ${Qtde_Minima_Estoque} WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;

    END
    
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

    Set Test Variable    ${Qtde_Minima_Estoque}

    # IF    ${TesteUtilizaDescontoMaximoProduto}

    #     Altera o desconto máximo do produto
        
    # END

Inserir Produto sem comissão por linha
    [Arguments]    ${permite_sem_estoque}=${False}

    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    IF    ${permite_sem_estoque}

        ${codProduto}    Query    SELECT p.Codigo FROM produtos p WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND (p.CodigoComissao IS NULL OR p.CodigoComissao = 0) ORDER BY RAND() LIMIT 1;

    ELSE

        ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque > 1 WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND (p.CodigoComissao IS NULL OR p.CodigoComissao = 0) AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;

    END

    IF    len($codProduto) == 0
        Fail    Nenhum produto sem comissão por linha (CodigoComissao IS NULL ou 0) encontrado com estoque. Verifique os cadastros no MyCommerce.
    END

    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

Inserir Produto normal - Permite sem estoque

    IF    '${TELA}' == 'NFeSaidasManual'

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.P
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_SETA_DIREITA}
        Sleep    ${SLEEP_BAIXO}
        
        Type With Modifiers    P    SHIFT
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.P
        Sleep    ${SLEEP_BAIXO}

    END

    ${codProduto}    Query    SELECT p.Codigo FROM produtos p WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

    # IF    ${TesteUtilizaDescontoMaximoProduto}

    #     Altera o desconto máximo do produto
        
    # END
    
Inserir produto pré-definido(${Produto})
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Produto} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

Valida parametros após incluir produto

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    IF    '${TELA}' == 'Orcamento'

        Valida o checkbox informa agrupamento

    END

    IF     ${Parametro_ExigeSenhaMultiplo}
    
        Valida solicitação de senha do usuário supervisor
    
    END

    IF    ${Parametro_IncluiDireto} != ${True}
        
        IF    '${TELA}' == 'NFeSaidasManual'
            
            SikuliLibrary.Click    ${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}
            Sleep    ${SLEEP_BAIXO}

        ELSE

            Press Combination    KEY.ALT    KEY.I
            Sleep    ${SLEEP_BAIXO}
            
        END

    END

    Valida desconto que não se encaixa em nenhuma escala de comissão

    IF    '${TELA}' == 'Orcamento'

        Valida inserção de produto com agrupamento em orçamentos
        
    END
    
    Valida produto com preço unitário zerado

    Valida produto já incluso

    IF    ${Parametro_RealizaVendaSemEstoque}

        ${avisoProdEstoqueInsuficiente}    Exists    ${AVISO_EST_INSUFICIENTE_CONTINUAR}

       IF    ${avisoProdEstoqueInsuficiente}
           
            Press Combination    KEY.ALT    KEY.S
            Sleep    ${SLEEP_BAIXO}

       END
        
    END

    Valida a inserção do mesmo produto várias vezes no grid

    IF    ${Aviso_ProdutoSemEstoque}
        
        Aviso produto sem estoque 

    END

    Verifica observacao do produto 

    IF    ${Parametro_BloqueiaOrcamentoSemEstoque}
        
        Valida aviso de quantidade não existente em estoque - Orçamento

        IF    ${AVISO_SEM_ESTOQUE}

            Inserir Produto normal - Necessita de estoque
            Valida parametros após incluir produto

        END
    END

    IF    ${Parametro_Controla_Entrega}

        Valida controle de entrega

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

Valida local de negociação da venda

    IF    ${Parametro_Local_Negociacao}
        
        Sleep    ${SLEEP_BAIXO}
        ${possuiCanaisVenda}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM canaisvenda LIMIT 1;

        IF    ${possuiCanaisVenda}

            ${tela}    Run Keyword And Return Status    Wait Until Screen Contain    ${MODAL_LOCAL_NEGOCIACAO}    ${TEMPO_TELA}

            IF    ${tela}

                Press Special Key    TAB
                Sleep    ${SLEEP_BAIXO}
                Press Special Key    DOWN

                SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}
            
            END

        ELSE
            
            ${aviso}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CADASTRE_CANAL_DE_VENDA}    ${TEMPO_TELA}

            IF    ${aviso}

                Press Special Key    ENTER
        
            END

        END
 
    END

Valida impressao direta de venda(${Parametro})
    
    IF    ${Parametro}

        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.S

        Wait Until Screen Not Contain    ${TELA_IMPRESSAO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}
            
    END

Valida solicitação de senha do usuário supervisor

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Verifica observacao do produto 
    
    ${ObservaçãoProduto}    Run Keyword And Return Status    Check If Exists In Database    SELECT ObservaVenda FROM produtos WHERE Codigo = ${COD_PRODUTO} AND ObservaVenda <> 0 AND ObservaVenda IS NOT NULL

    IF    ${ObservaçãoProduto}
        
        Sleep    ${SLEEP_ALTO}
        ${MSG}    Exists    ${TELA_OBSERVACAO_PRODUTO}

        IF    ${MSG}  
            
            Type    ${EMPTY}    Obs Produto Teste

            Press Combination    KEY.ALT    KEY.O
            Sleep    ${SLEEP_MEDIO}

        END

    END

Valida controle de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TIPO_ENTREGA}

    IF    ${MSG}  
        
        Input Text    ${EMPTY}    S
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.G
        Sleep    ${SLEEP_MEDIO}

    END

Aviso produto sem estoque 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_MEDIO}

    END

Verifica vendedor com senha

    ${VendedorComSenha} =     Run Keyword And Return Status     Check If Exists In Database    SELECT SenhaVendedor FROM clientes WHERE Codigo = ${Codigo_Vendedor} AND SenhaVendedor IS NOT NULL AND SenhaVendedor NOT LIKE ''
    
    Set Test Variable    ${VendedorPossuiSenha}    ${False}

    IF    ${VendedorComSenha}
        
        Execute Sql String    UPDATE clientes SET SenhaVendedor = 'W' WHERE Codigo = ${Codigo_Vendedor}
        Set Test Variable    ${VendedorPossuiSenha}    ${True}

    ELSE

        Set Test Variable    ${VendedorPossuiSenha}    ${False}

    END

Valida Controle de Credito - Liberação(${VALOR_FINAL})

    ${VALOR_CREDITO}    Query    SELECT ValorCredito FROM clientes WHERE Codigo = ${Codigo_Cliente}

    IF    ${VALOR_FINAL} > ${VALOR_CREDITO[0][0]}
        
        SikuliLibrary.Click    ${CORRIGE_FOCO}

        Sleep    ${SLEEP_BAIXO}
        ${MSG}    Exists    ${TELA_SOLICITACAO_CREDITO}

        IF    ${MSG}  
            
            SikuliLibrary.Click    ${BT_SOLICITAR_CRÉDITO}
            Wait Until Screen Contain    ${TELA_CONTROLE_CRÉDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

            Press Combination    KEY.ALT    KEY.L
            Wait Until Screen Contain    ${TELA_CONFIRMA_LIBERACAO_CREDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

            Press Combination    KEY.ALT    KEY.o
            
            #Valida o status = Liberado e a label Crédito liberado, por que na OS não existe o status = Liberado
            ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${LABEL_AVISO_CREDITO_LIBERADO}    ${SLEEP_ALTO}
            ${MSG2}    Run Keyword And Return Status    Wait Until Screen Contain    ${LABEL_AVISO_CREDITO_LIBERADO2}    ${SLEEP_ALTO}

            IF    ${MSG} or ${MSG2}
                
                Sleep    ${SLEEP_MEDIO}
                Press Combination    KEY.ALT    KEY.O

                Sleep    ${SLEEP_MEDIO}

                Press Combination    KEY.ALT    KEY.F
                Sleep    ${SLEEP_BAIXO}

            END 

        END

    END

Insere detalhamento no serviço
    
    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVIÇO}    ${SLEEP_ALTO}

    IF    ${MSG}
        
        Type    ${EMPTY}    Detalhamento de Servico - Teste de Automacao
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.C 
        Sleep    ${SLEEP_BAIXO}

    END

Exclui ordem de entrega(${COD_OPERACAO})
    
    Execute Sql String    DELETE FROM produtos_entregues WHERE IDEntrega = (SELECT ID FROM entregas WHERE CodigoVenda = ${COD_OPERACAO});
    Execute Sql String    DELETE FROM entregas WHERE CodigoVenda = ${COD_OPERACAO};

Cancela venda com senha 
    
    #${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${MODAL_CANCELAR_VENDA}    ${SLEEP_ALTO}
    #Sistema não reconhece a imagem do modal de jeito nenhum, então deixei dessa maneira, já que se estiver com o parametro marcado irá aparecer de certeza

    Sleep    ${SLEEP_ALTO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.O
    Sleep    ${SLEEP_BAIXO}

Seleciona produto com linha cadastrada(${Parametro_Operação_Sem_Estoque})

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    Key.P
    Sleep    ${SLEEP_BAIXO}

    ${tipo_linha_definido}    Run Keyword And Return Status    Variable Should Exist    ${Tipo_Comissao_Linha}

    IF    ${tipo_linha_definido} and '${Tipo_Comissao_Linha}' == 'Simples'

        ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'N' AND cp.Aliquota > 0

    ELSE IF    ${tipo_linha_definido} and '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

        ${cenario_prod_dif_definido}    Run Keyword And Return Status    Variable Should Exist    ${Cenario_Comissao_Linha}

        IF    ${cenario_prod_dif_definido} and '${Cenario_Comissao_Linha}' == 'PROD__DIF_POR_VEND__COM_ALIQ'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND p.CodigoComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0)

        ELSE IF    ${cenario_prod_dif_definido} and '${Cenario_Comissao_Linha}' == 'PROD__DIF_POR_VEND__SEM_ALIQ'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL) AND p.CodigoComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0)

        ELSE

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND (cp.Mista = 0 OR cp.Mista IS NULL)

        END

    ELSE IF    ${tipo_linha_definido} and '${Tipo_Comissao_Linha}' == 'Mista'

        ${cenario_prod_definido}    Run Keyword And Return Status    Variable Should Exist    ${Cenario_Comissao_Linha}

        IF    ${cenario_prod_definido} and '${Cenario_Comissao_Linha}' == 'PROD__MISTA__COM_ALIQ'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND cp.Mista = 1 AND p.CodigoComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota > 0)

        ELSE IF    ${cenario_prod_definido} and '${Cenario_Comissao_Linha}' == 'PROD__MISTA__COM_ALIQ_ZERO'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND cp.Mista = 1 AND p.CodigoComissao IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND cpv.Aliquota = 0)

        ELSE IF    ${cenario_prod_definido} and '${Cenario_Comissao_Linha}' == 'PROD__MISTA__SEM_REG_CPLV'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND cp.Mista = 1 AND p.CodigoComissao NOT IN (SELECT cpv.IDLinhaComissao FROM comissaoporlinha_vendedor cpv WHERE cpv.CodigoVendedor = ${Codigo_Vendedor})

        ELSE

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'D' AND cp.Mista = 1

        END

    ELSE IF    ${tipo_linha_definido} and '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

        ${cenario_tab_definido}    Run Keyword And Return Status    Variable Should Exist    ${Cenario_Comissao_Linha}

        IF    ${cenario_tab_definido} and '${Cenario_Comissao_Linha}' == 'PROD__TAB_PRECO__COM_ALIQ'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'DT' AND p.CodigoComissao IN (SELECT cpt.IDLinhaComissao FROM comissaoporlinha_tabpreco cpt WHERE cpt.idTabela = ${Id_Tabela_Preco_Selecionada} AND cpt.Aliquota > 0)

        ELSE IF    ${cenario_tab_definido} and '${Cenario_Comissao_Linha}' == 'PROD__TAB_PRECO__SEM_ALIQ'

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'DT' AND p.CodigoComissao IN (SELECT cpt.IDLinhaComissao FROM comissaoporlinha_tabpreco cpt WHERE cpt.idTabela = ${Id_Tabela_Preco_Selecionada} AND cpt.Aliquota = 0)

        ELSE

            ${filtro_tipo_comissao}    Set Variable    cp.Tipo = 'DT'

        END

    END

    IF     ${Parametro_Operação_Sem_Estoque}

        ${codProduto}    Query    SELECT p.Codigo FROM produtos p INNER JOIN comissaoporlinha cp ON cp.Codigo = p.CodigoComissao WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND ${filtro_tipo_comissao} AND p.VendaT1 > 0 ORDER BY RAND() LIMIT 1;

        Sleep    ${SLEEP_MEDIO}

    ELSE
        
        IF    '${TELA}' == 'Pedido'
            
            ${codProduto}    Query    SELECT p.Codigo AS codigoProduto FROM produtos AS p INNER JOIN produtosestoque AS pe ON pe.CodigoProduto = p.Codigo INNER JOIN comissaoporlinha cp ON cp.Codigo = p.CodigoComissao WHERE pe.Estoque > 1 AND p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND COALESCE((SELECT SUM(pvp.Quantidade - pvp.QtdeGerada) FROM pedidosvendaprodutos AS pvp WHERE pvp.CodigoProduto = p.Codigo AND pvp.Cancelada IS NULL), 0) < pe.Estoque AND ${filtro_tipo_comissao} AND p.VendaT1 > 0 ORDER BY RAND() LIMIT 1;

        ELSE

            ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque > 1 INNER JOIN comissaoporlinha cp ON cp.Codigo = p.CodigoComissao WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND ${filtro_tipo_comissao} AND p.VendaT1 > 0 ORDER BY RAND() LIMIT 1;

        END

    END
    
    Input Text    ${EMPTY}    ${codProduto[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

Pesquisa comissões por escalonamento
    
    ${Descontos_Comissoes}    Query    SELECT Ate, Comissao FROM comissao_escalonadaprod LIMIT 2

    RETURN    ${Descontos_Comissoes}

Gera desconto aleatório para comissão escalonada

    ${faixas}    Query    SELECT ce.Ate, ce.Comissao FROM comissao_escalonadaprod ce ORDER BY ce.Ate ASC

    IF    len($faixas) == 0
        Fail    Nenhuma faixa encontrada na tabela comissao_escalonadaprod.
    END

    ${ultima_faixa_ate}    Set Variable    ${faixas[-1][0]}
    ${limite_rand}    Evaluate    int(${ultima_faixa_ate})

    ${desconto_aleatorio}    Evaluate    random.randint(0, ${limite_rand})    modules=random

    ${aliquota_escalonada}    Set Variable    ${faixas[-1][1]}

    FOR    ${faixa}    IN    @{faixas}
        ${ate}    Set Variable    ${faixa[0]}
        IF    ${desconto_aleatorio} <= ${ate}
            ${aliquota_escalonada}    Set Variable    ${faixa[1]}
            BREAK
        END
    END

    Set Test Variable    ${Desconto_Escalonada}    ${desconto_aleatorio}
    Set Test Variable    ${Aliquota_Escalonada}    ${aliquota_escalonada}
    Set Test Variable    ${Faixas_Escalonada}    ${faixas}

    Log To Console    Desconto: ${desconto_aleatorio}% | Alíquota da faixa: ${aliquota_escalonada}%

Gera desconto aleatório para tabela de preço escalonada
    [Arguments]    ${id_tabela}

    ${faixas}    Query    SELECT cet.Ate, cet.Comissao FROM comissao_escalonadatab cet WHERE cet.IDTabela = ${id_tabela} ORDER BY cet.Ate ASC

    IF    len($faixas) == 0
        Fail    Nenhuma faixa encontrada na tabela comissao_escalonadatab para a tabela de preço ${id_tabela}.
    END

    ${tem_faixa_zero}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissao_escalonadatab cet WHERE cet.IDTabela = ${id_tabela} AND cet.Ate = 0;

    IF    not ${tem_faixa_zero}
        Fail    A tabela de preço ${id_tabela} não possui faixa obrigatória de desconto 0 em comissao_escalonadatab.
    END

    ${ultima_faixa_ate}    Set Variable    ${faixas[-1][0]}
    ${limite_rand}    Evaluate    int(${ultima_faixa_ate})

    ${desconto_aleatorio}    Evaluate    random.randint(0, ${limite_rand})    modules=random

    ${aliquota_escalonada}    Set Variable    ${faixas[-1][1]}

    FOR    ${faixa}    IN    @{faixas}
        ${ate}    Set Variable    ${faixa[0]}
        IF    ${desconto_aleatorio} <= ${ate}
            ${aliquota_escalonada}    Set Variable    ${faixa[1]}
            BREAK
        END
    END

    Set Test Variable    ${Desconto_Escalonada}    ${desconto_aleatorio}
    Set Test Variable    ${Aliquota_Escalonada}    ${aliquota_escalonada}
    Set Test Variable    ${Faixas_Escalonada}    ${faixas}

    Log To Console    Desconto: ${desconto_aleatorio}% | Alíquota da faixa (tabela ${id_tabela}): ${aliquota_escalonada}%

Valida a inserção do mesmo produto várias vezes no grid

    ${AVISO}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_JA_INCLUIU_PRODUTO_NO_GRID}    ${SLEEP_ALTO}

    IF    ${AVISO}
        
        Press Combination    KEY.Alt    KEY.s

    END

Valida tela de transportadora/faturamento nota fiscal

    ${TELA_TRANSP}    Exists    ${TELA_TRANSP_FAT_NF}

    IF    ${TELA_TRANSP}
        
        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_BAIXO}

    END

Verifica seleção de tabela de preço(${TELA})
    
    Sleep    ${SLEEP_MEDIO}
    ${tabelaPadrao}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT * FROM tabelas AS t WHERE t.Cancelada IS NULL AND t.Padrao = 1;

    Sleep    ${SLEEP_MEDIO}
    ${tabelaVendedor}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT * FROM tabelas_vendedores tb WHERE tb.idVendedor = ${Codigo_Vendedor} AND tb.MyCommerce = 1 AND tb.Excluido = 0;

    # Validação por conta que, nas telas 'OrdemDeServico', 'Condicional', 'Devolução' e 'Doação' ao informar o vendedor, o sistema 
    # não seleciona no combobox a primeira tabela de preço  da listagem, conforme ocorre nas outras telas, quando o cenário das sql's acima.
    IF    '${TELA}' == 'OrdemDeServico' or '${TELA}' == 'Condicional' or '${TELA}' == 'Devolução' or '${TELA}' == 'Doação'

        Sleep    ${SLEEP_BAIXO}
        Run Keyword If    ${tabelaPadrao} or ${tabelaVendedor}    Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}

    END

Altera para vendedor vinculado ao cliente

    ${vendedorPadrao}    Exists    ${AVISO_USAR_ESSE_VENDEDOR}

    IF    ${vendedorPadrao}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_BAIXO}

    END

Valida quantidade de empresas

    ${qtdeEmpresa}    Query    SELECT COUNT(*) FROM empresas e WHERE e.`Status` = 'ATIVA' AND e.Ativo = 1;

    RETURN    ${qtdeEmpresa[0][0]}

Desativa avisos de inicialização nas permissões de usuário
    
    Execute Sql String    UPDATE usuarios AS u SET u.MenuInicializacao = 0, u.Avisos_menu = 0, u.AvisoChequeCompensar = 0, u.AvisoChequesCompensarVencidos = 0, u.ContaAvisoTodas = 0, u.AvisoCortes = 0, u.Crm_Notify = 0, u.prod_EstAviso = 0, u.AvisoNcmCest = 0, u.Entrega_Aviso = 0, u.AvisoVendaAberta = 0, u.AvisoProdutosLoteValidade = 0, u.AvisoAniversariantes = 0, u.AvisoClienteSemCompra = 0, u.ContaAviso = 0, u.AvisoNFCPendente = 0 WHERE u.UserName = 'Visual';
    
    Sleep    ${SLEEP_BAIXO}

    Execute Sql String    UPDATE usuarios_auxiliar AS uax JOIN usuarios AS u ON u.Codigo = uax.uau_codigo_usuario SET uax.uau_avisa_ferias = 0, uax.Uau_Cons_Avisos_Manutencoes_Inicializar = 0, uax.Uau_Cons_Avisos_TransfRecusadas_Inicializar = 0, uax.Uau_Avisos_Cotacao_Moeda = 0, uax.Uau_Importa_Produtos = 0, uax.uau_BloqDev_ComValorNegativo = 0 WHERE u.UserName = 'Visual';

E saio da tela(${TELA})    

    IF    '${TELA}' == 'Condicional'
            
        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}
    
    ELSE IF    '${TELA}' == 'Devolução'
        
        SikuliLibrary.Click    ${AJUSTE_FOCO_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Orçamento'

        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'OrdemDeServico'

        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Venda'
        
        SikuliLibrary.Double Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Pedido'
        
        SikuliLibrary.Click    ${TELA_PEDIDOS}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'ContasAPagar'

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_CONTAS_A_PAGAR_AVULSA}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'NFeSaidasManual'

        Press Special Key    ESC
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Press Special Key    ESC
        Wait Until Screen Not Contain    ${TELA_NOTA_FISCAL_MANUAL}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Comissoes'
        
        SikuliLibrary.Click    ${TELA_COMISSOES}

        Press Combination    KEY.ALT    KEY.F
        Wait Until Screen Not Contain    ${TELA_COMISSOES}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'CaixaPrincipal'
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${CAIXA_PRINCIPAL}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'RelatorioComissao'
        
        SikuliLibrary.Click    ${TELA_RELATORIO_COMISSOES}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ESC
        
        Wait Until Screen Not Contain    ${TELA_RELATORIO_COMISSOES}    ${TEMPO_TELA}

    END

Valida teste que utiliza o desconto máximo do produto

    ${TesteUtilizaDescontoMaximoProduto}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    desconto máximo do produto

    IF    ${TesteUtilizaDescontoMaximoProduto}

        Altera o desconto máximo do produto
        
    END
    
    Set Test Variable    ${TesteUtilizaDescontoMaximoProduto}

Altera o desconto máximo do produto

    Execute Sql String    UPDATE produtos p SET p.DescontoMaximo = 10 WHERE p.Codigo = ${COD_PRODUTO}

Valida solicitação de senha do usuário supervisor para liberação de desconto

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Seleciona uma forma de parcelamento personalizável

    ${formaParc}    Query    SELECT fp.Descricao FROM formaparcelamento fp WHERE fp.Personalizavel = 1 AND fp.Cancelado IS NULL LIMIT 1

    RETURN    ${formaParc[0][0]}

Remove os grids personalizados de simulação de parcelas

    Execute Sql String    DELETE FROM usuariogridflex WHERE FormName = 'frmSimulacaodeParcelas';

Remove os grids personalizados do caixa

    Execute Sql String    DELETE FROM usuariogridflex WHERE FormName = 'frmCaixa';

Verifica regime tributário da empresa

    ${regimeTributario}    Query    SELECT e.Codigo, e.RegimeFiscalSimples, e.TipoLucro, e.AliquotaISS FROM empresas e WHERE e.Codigo = (SELECT ua.ua_empresa FROM usuario_acesso AS ua WHERE ua.ua_data = CURDATE() ORDER BY ua.ua_id DESC LIMIT 1);

    RETURN    ${regimeTributario}

Seleciona técnico executor comissionado diferente do vendedor da OS(${Tipo_Comissao_Selecionar})

    IF    ${Tipo_Comissao_Selecionar} == 'T'

        ${consultaVendedorTecnicoServico}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor, ComissaoPercentualServicos FROM clientes WHERE ComissaoServicos = 1 AND ComissaoPercentualServicos > 0 AND ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' AND Tecnico = 1 AND clientes.Codigo <> ${Codigo_Vendedor} ORDER BY RAND() LIMIT 1;

        ${tecnicoComissServicoTotalVenda}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedorTecnicoServico}

        IF    not ${tecnicoComissServicoTotalVenda}
                
            Fail    Nenhum vendedor técnico executor, diferente do vendedor da OS, possui comissão por serviço sobre o total da venda.
                
        END

        ${Dados_Vendedor}    Query    ${consultaVendedorTecnicoServico}

        Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

    ELSE

        IF    ${Tipo_Comissao_Selecionar} == 'L'

            Seleciona técnico executor comissão linha
            RETURN

        ELSE

            IF    ${Teste_Comissao_Escalonada}
                IF    ${Cenario_Sem_Comissao_Servico}
                    ${filtro_perc_exec}    Set Variable    AND (ComissaoPercentualServicos = 0 OR ComissaoPercentualServicos IS NULL)
                ELSE
                    ${filtro_perc_exec}    Set Variable    AND ComissaoPercentualServicos > 0
                END
            ELSE
                ${filtro_perc_exec}    Set Variable    ${EMPTY}
            END

            ${consultaVendedorTecnicoServico}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor, ComissaoPercentualServicos FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoServicos = 1 AND ComissaoVendaProdutos = 1 AND Tecnico = 1 AND clientes.Codigo <> ${Codigo_Vendedor} ${filtro_perc_exec} ORDER BY RAND() LIMIT 1;

            ${tecnicoComissServico}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedorTecnicoServico}

            IF    not ${tecnicoComissServico}

                Fail    Não foi encontrado vendedor técnico executor, diferente do vendedor da OS, com comissão por serviço para o tipo de comissão ${Tipo_Comissao_Selecionar}.
                
            END

            ${Dados_Vendedor}    Query    ${consultaVendedorTecnicoServico}

        END

    END

    IF    len($Dados_Vendedor) > 0

        Set Test Variable    ${Codigo_Tecnico_Servico}    ${Dados_Vendedor[0][0]}

        IF    ${Teste_Comissao_Escalonada}
            Set Test Variable    ${PercentualComissaoEscalonada_Servico_Executor}    ${Dados_Vendedor[0][3]}
        END

    END

Seleciona técnico executor comissão linha

    ${base_query}    Set Variable    SELECT c.Codigo, c.ComissaoPercentualProdutos, c.ComissaoDiferenciadapor FROM clientes c
    ${base_where}    Set Variable    c.ComissaoDiferenciadapor = 'L' AND c.ComissaoVendaProdutos = 1 AND c.ComissaoServicos = 1 AND c.Tipo IN ('D','V') AND c.Ativo = -1 AND c.Status = 'ATIVA' AND c.Codigo <> ${Codigo_Vendedor}

    # Subconsulta reutilizável: garante que a linha de comissão possui ao menos um serviço ativo vinculado
    ${filtro_servico_na_linha}    Set Variable    AND cpv.IDLinhaComissao IN (SELECT srv.TabelaComissao FROM servicos srv WHERE srv.\`Status\` = 'g' AND srv.Ativo = 1 AND srv.Inativo = 0)

    IF    '${Tipo_Comissao_Linha}' == 'Simples'

        ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} WHERE ${base_where} ORDER BY RAND() LIMIT 1;

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

        IF    '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL) AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL) AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_ALIQ'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL) AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_SEM_ALIQ'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL) AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND (cl.Mista = 0 OR cl.Mista IS NULL) ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        END

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

        IF    '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.Aliquota > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.Aliquota = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${Cenario_Comissao_Linha}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv2.CodigoVendedor FROM comissaoporlinha_vendedor cpv2 INNER JOIN comissaoporlinha cp2 ON cp2.Codigo = cpv2.IDLinhaComissao WHERE cp2.Tipo = 'D' AND cp2.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.AliquotaExecucao > 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.CodigoVendedor = c.Codigo INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao WHERE ${base_where} AND cl.Tipo = 'D' AND cl.Mista = 1 AND cpv.AliquotaExecucao = 0 ${filtro_servico_na_linha} ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv2.CodigoVendedor FROM comissaoporlinha_vendedor cpv2 INNER JOIN comissaoporlinha cp2 ON cp2.Codigo = cpv2.IDLinhaComissao WHERE cp2.Tipo = 'D' AND cp2.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE IF    '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${Cenario_Comissao_Linha}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} WHERE ${base_where} AND c.Codigo NOT IN (SELECT cpv2.CodigoVendedor FROM comissaoporlinha_vendedor cpv2 INNER JOIN comissaoporlinha cp2 ON cp2.Codigo = cpv2.IDLinhaComissao WHERE cp2.Tipo = 'D' AND cp2.Mista = 1) ORDER BY RAND() LIMIT 1;

        ELSE

            ${consultaVendedorTecnicoServico}    Set Variable    ${base_query} WHERE ${base_where} ORDER BY RAND() LIMIT 1;

        END

    END

    ${tecnicoExiste}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedorTecnicoServico}

    IF    not ${tecnicoExiste}
        Fail    Nenhum técnico executor elegível encontrado para comissão por linha tipo '${Tipo_Comissao_Linha}', cenário '${Cenario_Comissao_Linha}'.
    END

    ${Dados_Vendedor}    Query    ${consultaVendedorTecnicoServico}

    Set Test Variable    ${Codigo_Tecnico_Servico}    ${Dados_Vendedor[0][0]}

Validação após incluir serviço

    FOR    ${i}    IN RANGE    2

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    IF    not ${Parametro_IncluiDireto}
            
        Press Combination    KEY.ALT    KEY.N

    END

Insere funcionários comissionados por serviço

    Wait Until Screen Contain    ${TELA_FUNCIONARIO_COMISSIONADO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    IF    ${Parametro_Seleciona_Funcionario_Comissao_Servico}
            
        Press Special Key    DOWN

    ELSE
            
        IF    ${OS_Vendedor_E_Tecnico_Diferentes}

            Input Text    ${EMPTY}    ${Codigo_Tecnico_Servico}
            
        ELSE

            Input Text    ${EMPTY}    ${Codigo_Vendedor}

        END
                
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Contain    ${ROW_FUNCIONARIO_INCLUSO_SERVICO_OS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Valida o abatimento dos tributos no valor do serviço

Valida o abatimento dos tributos no valor do serviço

    ${aliqISSEmpresa}            Evaluate    0
    ${Total_Tributos_Servico}    Evaluate    0

    IF    not ${Parametro_NaoDeduzirISSQNComissaoOS}

        ${regimeTributarioEmp}    Verifica regime tributário da empresa
        
        ${aliqISSEmpresa}         Set Variable    ${regimeTributarioEmp[0][3]}

        IF    '${regimeTributarioEmp[0][1]}' == '1'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis, 0) + COALESCE(sae.AliqCofins, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};

        ELSE IF    '${regimeTributarioEmp[0][2]}' == 'LP'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis_presumido, 0) + COALESCE(sae.AliqCofins_presumido, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};

        ELSE IF    '${regimeTributarioEmp[0][2]}' == 'LR'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis_real, 0) + COALESCE(sae.AliqCofins_real, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};
        END

        ${Total_Tributos_Servico}    Evaluate    ${aliqISSEmpresa} + ${aliqPisCofins[0][0]}

    END

    Set Test Variable    ${Total_Tributos_Servico}

Formata código venda em texto para pesquisa
    [Arguments]    ${codigo}

    ${codigo_int}    Convert To Integer    ${codigo}

    ${codigo_formatado}    Evaluate    "{:,}".format(${codigo_int}).replace(",", ".")

    RETURN    ${codigo_formatado}

Configurar pesquisa de produto por código

    IF    ${Parametro_PesquisaCodigoCodFabricaReferencia}

        Log To Console    Parametro_PesquisaCodigoCodFabricaReferencia: ${Parametro_PesquisaCodigoCodFabricaReferencia}
        
        Execute Sql String    UPDATE config SET BuscaReferencia = 0

        Set Global Variable    ${Atualizacao_Ambiente_MyCommerce}    ${True}

        Set Global Variable    ${Parametro_PesquisaCodigoCodFabricaReferencia}    ${False}

    END

Configurar foco no campo de vendedor na inclusão de vendedor

    IF    ${Parametro_FocoCampoCliente}

        Log To Console    Parametro_FocoCampoCliente: ${Parametro_FocoCampoCliente}

        Execute Sql String    UPDATE config SET FocoClienteVenda = 0

        Set Global Variable    ${Atualizacao_Ambiente_MyCommerce}    ${True}

        Set Global Variable    ${Parametro_FocoCampoCliente}    ${False}
        
    END

Configurar controle de crédito como desativado

    ${Deve_Desativar_Controle_Credito}    Evaluate    any([${Parametro_ControlaCreditoVenda}, ${Parametro_ControlaCreditoOrcamento}, ${Parametro_ControlaCreditoCondicional}, ${Parametro_ControlaCreditoGerarPreVendaOrcamento}, ${Parametro_ControlaCreditoOS}, ${Parametro_ControlaCreditoDevTroca}, ${Parametro_ControlaCreditoPreVenda}, ${Parametro_ControlaCreditoPreSeparacaoPreVenda}, ${Parametro_ControlaCreditoDescontaChequePreEmMaos}, ${Parametro_ControlaCreditoPreVendaAuditoria}])

    IF    ${Deve_Desativar_Controle_Credito}

        Log To Console    Deve_Desativar_Controle_Credito: ${Deve_Desativar_Controle_Credito}

        Execute Sql String    UPDATE config SET ControlaCreditoClientes = 0, ControlaCreditoORC = 0, ControlaCreditoCond = 0, ControlaCreditoGeraPreOrcamento = 0, ControlaCreditoOS = 0, ControlaCreditoDevTroca = 0, ControlaCreditoPRE = 0, ControlaCredPreSepPreVenda = 0, DescontaChPre_CreditoCliente = 0, AuditoriaControlaCreditoPre = 0;

        Set Global Variable    ${Atualizacao_Ambiente_MyCommerce}    ${True}

        Set Global Variable    ${Parametro_ControlaCreditoVenda}                      ${False}
        Set Global Variable    ${Parametro_ControlaCreditoOrcamento}                  ${False}
        Set Global Variable    ${Parametro_ControlaCreditoCondicional}                ${False}
        Set Global Variable    ${Parametro_ControlaCreditoGerarPreVendaOrcamento}     ${False}
        Set Global Variable    ${Parametro_ControlaCreditoOS}                         ${False}
        Set Global Variable    ${Parametro_ControlaCreditoDevTroca}                   ${False}
        Set Global Variable    ${Parametro_ControlaCreditoPreVenda}                   ${False}
        Set Global Variable    ${Parametro_ControlaCreditoPreSeparacaoPreVenda}       ${False}
        Set Global Variable    ${Parametro_ControlaCreditoDescontaChequePreEmMaos}    ${False}
        Set Global Variable    ${Parametro_ControlaCreditoPreVendaAuditoria}          ${False}

    END

Valida produto com preço unitário zerado

    Sleep    ${SLEEP_BAIXO}
    
    ${tela}     Exists    ${TELA_MOTIVO_PRECO_ZERADO_PRODUTO}
    ${aviso}    Exists    ${AVISO_ESPECIFIQUE_VLR_UNIT_PRODUTO}

    IF    ${tela}

        Press Special Key    ESC

        Wait Until Screen Not Contain    ${TELA_MOTIVO_PRECO_ZERADO_PRODUTO}    ${SLEEP_ALTO}

        Press Combination    KEY.ALT    KEY.TAB
        Sleep    ${SLEEP_BAIXO}

        Corrigir valor unitário do produto
        
    END

    IF    ${aviso}

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        Corrigir valor unitário do produto
        
    END

Valida produto já incluso

    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_PRODUTO_JA_INCLUSO}

    IF    ${aviso}

        Press Combination    KEY.ALT    KEY.S
        
    END

Valida aviso de quantidade não existente em estoque - Orçamento

    ${Existe_MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_QTDE_SEM_ESTOQUE_ORCAMENTO}    ${SLEEP_BAIXO}
    Set Test Variable    ${AVISO_SEM_ESTOQUE}    ${Existe_MSG}

   IF    ${Existe_MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    BACKSPACE

   END

Corrigir valor unitário do produto

    Informa valor unitário do produto

    Valida parametros após incluir produto

Informa valor unitário do produto

    ${valorUnitario}    Query    SELECT p.VendaT1 FROM produtos p WHERE p.Codigo = ${Codigo_Cliente}

    SikuliLibrary.Double Click    ${INPUT_VALOR_UNITARIO_PRODUTO}

    Input Text    ${EMPTY}    ${valorUnitario}

Configurar vínculo de produto devolvido na entrega como desativado

    IF    ${Parametro_VinculaProdutoDevolvidoEntrega}

        Log To Console    Parametro_VinculaProdutoDevolvidoEntrega: ${Parametro_VinculaProdutoDevolvidoEntrega}

        Execute Sql String    UPDATE config SET VinculaDevolucaoEntrega = 0

        Set Global Variable    ${Atualizacao_Ambiente_MyCommerce}    ${True}

        Set Global Variable    ${Parametro_VinculaProdutoDevolvidoEntrega}    ${False}
        
    END

Configurar consulta automática ao SCPC como desativada

    IF    ${Parametro_ConsultaSCPCVenda}

        Log To Console    Parametro_ConsultaSCPCVenda: ${Parametro_ConsultaSCPCVenda}

        Execute Sql String    UPDATE config SET ConsultaSCPCVenda = 0

        Set Global Variable    ${Atualizacao_Ambiente_MyCommerce}    ${True}

        Set Global Variable    ${Parametro_ConsultaSCPCVenda}    ${False}
        
    END

Valida impressão pré-venda ao finalizar pré-venda

    IF    ${Parametro_ImpressaoDiretaPreVenda}

        Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.S

        Wait Until Screen Not Contain    ${TELA_IMPRESSAO_DIRETA}    ${SLEEP_ALTO}
    
    ELSE
        
        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.S

        Wait Until Screen Not Contain    ${TELA_IMPRESSAO}    ${SLEEP_ALTO}

    END

Valida telas que utilizam quantidade padrão de produtos

    Set Global Variable    ${Parametro_QtdePadraoVendas}                ${False}
    Set Global Variable    ${Parametro_QtdePadraoOrcamentos}            ${False}
    Set Global Variable    ${Parametro_QtdePadraoPreVendas}             ${False}
    Set Global Variable    ${Parametro_QtdePadraoOS}                    ${False}
    Set Global Variable    ${Parametro_QtdePadraoDevolucao}             ${False}
    Set Global Variable    ${Parametro_QtdePadraoDoacao}                ${False}
    Set Global Variable    ${Parametro_QtdePadraoEmissaoManualSaida}    ${False}

    IF    $Parametro_TelasQtdePadraoProduto is None
        RETURN
    END

    @{telas}    Split String    ${Parametro_TelasQtdePadraoProduto}    ,

    IF    '0' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoVendas}    ${True}
    END

    IF    '1' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoOrcamentos}    ${True}
    END

    IF    '2' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoPreVendas}    ${True}
    END

    IF    '3' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoOS}    ${True}
    END

    IF    '4' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoDevolucao}    ${True}
    END

    IF    '5' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoDoacao}    ${True}
    END
    
    IF    '6' in @{telas}
        Set Global Variable    ${Parametro_QtdePadraoEmissaoManualSaida}    ${True}
    END

Valida quantidade padrão dos produtos na seleção

    Set Test Variable    ${Quantidade_Padrao_Produto}    0

    IF    '${TELA}' == 'Orcamento'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoOrcamentos}

    ELSE IF    '${TELA}' == 'Venda'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoVendas}

    ELSE IF    '${TELA}' == 'OrdemDeServico'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoOS}

    ELSE IF    '${TELA}' == 'Condicional'

        Log To Console    VERIFICAR DEPOIS.

    ELSE IF    '${TELA}' == 'Devolução'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoDevolucao}

    ELSE IF    '${TELA}' == 'Pedido'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoPreVendas}

    ELSE IF    '${TELA}' == 'Doação'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoDoacao}

    ELSE IF    '${TELA}' == 'NFeSaidasManual'

        Aplica quantidade padrão se parametrizado    ${Parametro_QtdePadraoEmissaoManualSaida}

    END

Aplica quantidade padrão se parametrizado
    [Arguments]    ${Parametro_Ativo}

    IF    ${Parametro_Ativo}

        Set Test Variable    ${Quantidade_Padrao_Produto}    ${Parametro_QuantidadePadraoProduto}

    END

Considera quantidade padrão de produtos quando utilizado múltiplos produtos
    [Arguments]    ${parametro}

    IF    not ${parametro} or (${parametro} and ${Parametro_QuantidadePadraoProduto} == 0)
        RETURN    1
    ELSE
        RETURN    ${Parametro_QuantidadePadraoProduto}
    END

Fechar tela de personalização de forma de parcelamento

    ${tela}    Run Keyword And Return Status    Wait Until Screen Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

    IF    ${tela}

        Press Combination    KEY.ALT    KEY.C
        
        Wait Until Screen Not Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

    END

Valida solicitação de senha do usuário supervisor para liberação de status da OS

    ${tela}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_LIBERACAO_STATUS}    ${SLEEP_ALTO}

    IF    ${tela}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Valida o checkbox informa agrupamento

    ${Teste_Orcamento_Agrupamento_Produto}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    agrupamento

    IF    ${Teste_Orcamento_Agrupamento_Produto}

        ${checkbox_informa_agrupamento_verificado}    Get Variable Value    \${checkbox_informa_agrupamento_verificado}    ${False}

        IF    not ${checkbox_informa_agrupamento_verificado}

            ${informa_agrupamento_habilitado}    validaTelasIni.Valida Telas Ini Prefixado    formulario=frmCad_Orcamento    campo=InformaAgrupamento

            Sleep    ${SLEEP_BAIXO}

            IF    not ${informa_agrupamento_habilitado}

                SikuliLibrary.Click    ${CHECKBOX_INFORMA_AGRUPAMENTO}

            END

            Set Test Variable    ${checkbox_informa_agrupamento_verificado}    ${True}

        END

        Set Test Variable    ${Teste_Orcamento_Agrupamento_Produto}

    END

Valida inserção de produto com agrupamento em orçamentos

    IF    ${Teste_Orcamento_Agrupamento_Produto}
        
        Wait Until Screen Contain    ${TELA_AGRUPAMENTO_PRODUTO_ORCAMENTO}    ${TEMPO_TELA}

        Sleep    ${SLEEP_BAIXO}
        Type    ${EMPTY}    AUTOMACAO-AGRUPAMENTO
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

        Sleep    ${SLEEP_BAIXO}
        ${consulta}    Query    SELECT op.Agrupamento, op.CodigoProduto FROM orcamentosprodutos op WHERE op.CodigoOrcamento = ${CODIGO_OPERACAO_MOV} AND op.CodigoProduto = ${COD_PRODUTO} AND op.Cancelada IS NULL;

        ${agrupamento}       Set Variable    ${consulta[0][0]}
        ${codigo_produto}    Set Variable    ${consulta[0][1]}

        Should Be Equal As Numbers    ${codigo_produto}    ${COD_PRODUTO}
        Should Be Equal As Strings    ${agrupamento}    AUTOMACAO-AGRUPAMENTO

    END

Verifica status padrão de orçamento
    [Arguments]    ${situacao_orcamento}    ${status_alterado}=${None}

    IF    $status_alterado is not None

        # Status alterado manualmente durante o lançamento
        ${status_registros}    Query    SELECT sr.Codigo, sr.Descricao FROM status_registros sr WHERE sr.Descricao = '${status_alterado}' AND sr.Excluido = 0 LIMIT 1;

        ${codigo_status}      Set Variable    ${status_registros[0][0]}
        ${descricao_status}   Set Variable    ${status_registros[0][1]}

        ${orcamento}    Query    SELECT o.IDStatusOR, o.StatusOR FROM orcamentos o WHERE o.Codigo = ${COD_ORCAMENTO};

        Should Be Equal As Integers    ${orcamento[0][0]}    ${codigo_status}
        Should Be Equal As Strings    ${orcamento[0][1]}    ${descricao_status}

    ELSE

        IF    '${situacao_orcamento}' == 'OrcamentoGravado'

            ${campo}    Set Variable    PadraoAbrir

        ELSE IF    '${situacao_orcamento}' == 'GeradoPreVenda'

            ${campo}    Set Variable    padraoGerarPreVenda

        ELSE IF    '${situacao_orcamento}' == 'GeradoVenda'

            ${campo}    Set Variable    PadraoFechar

        END

        ${status_padronizado}    Query    SELECT sr.Codigo, sr.Descricao FROM status_registros sr WHERE sr.Excluido = 0 AND sr.${campo} = 1 LIMIT 1;

        ${tem_status_padrao}    Evaluate    bool($status_padronizado)

        ${orcamento}    Query    SELECT o.IDStatusOR, o.StatusOR FROM orcamentos o WHERE o.Codigo = ${COD_ORCAMENTO};

        IF    ${tem_status_padrao}

            ${codigo_status}      Set Variable    ${status_padronizado[0][0]}
            ${descricao_status}   Set Variable    ${status_padronizado[0][1]}

            Should Be Equal As Integers    ${orcamento[0][0]}    ${codigo_status}
            Should Be Equal As Strings    ${orcamento[0][1]}    ${descricao_status}

        ELSE

            IF    '${situacao_orcamento}' == 'OrcamentoGravado'

                Should Be Equal    ${orcamento[0][0]}    ${None}
                Should Be Equal    ${orcamento[0][1]}    ${None}

            ELSE

                Log To Console    \nNenhum status padrão configurado para '${situacao_orcamento}' — o sistema não altera o status existente do orçamento; validação ignorada.

            END

        END

    END

Valida solicitação de senha do supervisor para liberação de alteração de status do orçamento
    
    ${tela}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_LIBERACAO_STATUS_ORCAMENTO}    ${SLEEP_ALTO}

    IF    ${tela}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Valida desconto que não se encaixa em nenhuma escala de comissão
    
    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_DESC_ESCALA_COMISSAO}

    WHILE    ${aviso}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

        ${aviso}    Exists    ${AVISO_DESC_ESCALA_COMISSAO}

    END

Clicar no botão Adicionar
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_ADICIONAR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_ADICIONAR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Gravar
    ${botao}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_GRAVAR}    ${SLEEP_MEDIO}
    IF    ${botao}
        SikuliLibrary.Click    ${BT_GRAVAR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Salvar
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_SALVAR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_SALVAR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Editar
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_EDITAR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_EDITAR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Excluir
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_EXCLUIR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_EXCLUIR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Listar
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_LISTAR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_LISTAR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Ok
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_OK}    5
    IF    ${existe}
        SikuliLibrary.Click    ${BT_OK}
        Sleep    ${SLEEP_BAIXO}
    END



Clicar no botão Incluir
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_INCLUIR}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Sim
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_SIM}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_SIM}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Não
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_NAO}    ${SLEEP_MEDIO}
    IF    ${existe}
        SikuliLibrary.Click    ${BT_NAO}
        Sleep    ${SLEEP_BAIXO}
    END