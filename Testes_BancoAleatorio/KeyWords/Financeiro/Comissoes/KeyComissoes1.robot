*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/estoque.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot
Resource    ../../../utils/montadorDeCenarios.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                                ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                                ${config.IpServidor}
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root

# Sleep's
${SLEEP_BAIXO}                           0.7
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20

# Telas
${TELA_COMISSOES}                        tela_Comissoes.png
${TELA_AGENDAMENTO}                      tela_Agendamento_Comissao.png
${TELA_CONTAS_A_PAGAR}                   tela_ContasPagar.png
${TELA_RECEBIMENTO_PAGAMENTO}            caixa_FinalizacaoRecebimentoPagamento.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}     tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                 tela_CaixaPrinicipalCarregando.png
${TELA_VALE_COMPRA}                      tela_ValeCompra.png
${TELA_BAIXA_VALE_COMPRA}                tela_BaixaValeCompra.png
${TELA_DETALHES_COMISSAO}                tela_DetalhesComissao.png
${CAIXA_PRINCIPAL}                       tela_CaixaPrinicipal.png
${TELA_IMPRESSAO}                        tela_Impressao.png

# Telas Avisos
${AVISO_BAIXA_SUCESSO}                   aviso_BaixaSucesso.png
${AVISO_CONFIRMAÇÃO_BAIXA}               aviso_confirmacaoBaixaContaPagar.png
${AVISO_BAIXA_VALE_COMPRA}               aviso_BaixaValeCompra.png
${AVISO_COMISSAO_ZERADA}                 aviso_ComissaoZerada.png

# Botões
${BT_BAIXAR}                             bt_Baixar.png
${BT_OK}                                 bt_OkComisssao.png
${BT_FECHAR}                             bt_fechar.png

# Outros

${MENU_FINANCEIRO}                       menu_Financeiro.png
${MENU_COMERCIAL}                        menu_Comercial.png
${SUB_MENU_COMISSOES}                    subMenu_Comissoes.png
${LISTAGEM_GRID}                         grid_Comissoes.png
${CHECK_BOX_SELE_TODOS}                  checkBox_Comissao.png
${Quantidade_Zeros_Incluidos}
${ABA_A_PAGAR}                           aba_contasAPagar.png
${GRID_COMISSOES_PAGAR}                  grid_ComissoesPagar.png
${CHECKBOX_CONTASPAGAR}                  checkBox_ContasPagar.png
${INPUT_NUMERO_DOCUMENTO}                caixa_PesquisaPorNDoc.png
${Total_Comissao}                        ${0}
${Total_Comissao_Final}                  ${0}
${COL_LOTE}                              grid_ComissoesLote.png
${LABEL_DATA_PAGAMENTO_NULA}             lb_DataPagamentoComBranco.png
${ABA_SERVICOS}                          aba_servicosSelecionada.png
${CHECK_BOX_SELE_TODOS_SERVICO}          checkBox_ComissaoServico.png
${SETA_ESQUERDA_GRID}                    setaEsqGrid.png
${CHECKBOX_COMISSAO_FOCO_GRID}           checkBox_ComissaoFocoGrid.png
${LABEL_CARREGANDO_COMISSOES_GRID}       lb_CarregandoComissoesGrid.png
${CHECKBOX_CONTA_FOCO_GRID}              checkBoxContaFocoGrid.png
${CHECKBOX_CONTA_FOCO_GRID_2}            checkBox_ComissaoFocoGrid2.png
${GRID_SEM_REGISTROS}    	             grid_ComissoesSemRegistros.png
${NomeTerminalExecucao}                  ${config.terminal_name}
${GUIA_COMISSOES_PAGAS_AGENDADAS}        guia_ComissoesPagasAgendadas.png
${LABEL_STATUS_ABERTO}                   lb_StatusAbertoCaixa.png
${TOOLTIP_ATALHOS_DATA}                  tooltip_AtalhosData.png
${Somatorio_Comissao_Parcela}            ${0}
${j}                                     ${0}

${MENU_RELATORIOS}                       menu_Relatorios.png
${SUBMENU_RELATORIOS_COMISSOES}          subMenu_Relatorios_Comissoes.png
${TELA_RELATORIO_COMISSOES}              tela_RelatorioComissoes.png
${RADIOBT_COMISSOES_AGENDADAS}           radioBT_Agendadas.png
${LABEL_GERANDO_RELATORIO_AGUARDE}       lb_GerandoRelatorioAguarde.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${RADIOBT_VISUALIZAR_IMPRESSAO}          radioBT_Visualizar_Impressao.png
${TELA_VISUALIZACAO_IMPRESSAO}           tela_VisualizacaoImpressao.png
${RADIOBT_COMISSOES_PENDENTES}           radioBT_Pendentes.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de comissoes

    SikuliLibrary.Click    ${MENU_FINANCEIRO}
    Wait Until Screen Contain    ${SUB_MENU_COMISSOES}    ${TEMPO_TELA}

    FOR    ${I}    IN RANGE    4

        Press Special Key    DOWN

    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_COMISSOES}    ${TEMPO_TELA}

Quando insiro o vendedor comissionado

    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

Pesquisa código da operação com zeros a esquerda

    Log To Console    CODIGO_OPERACAO_MOV: ${CODIGO_OPERACAO_MOV}

    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda
    ${Cod_Venda_String}    Convert To String    ${CODIGO_OPERACAO_MOV}

    ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Venda_String}

    ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}


    FOR    ${I}    IN RANGE    ${Quantidade_de_zeros_esquerda}

        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

    END
    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    9

        Press Special Key    RIGHT

    END

    Press Special Key    SPACE

E seleciono a comissao da venda

    Sleep    ${SLEEP_BAIXO}
    ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

    IF    ${gridSemRegistro}

        Press Combination    KEY.ALT    KEY.I
        Sleep    ${SLEEP_ALTO}
        Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    END

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    Sleep    ${SLEEP_BAIXO}
    ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

    IF    ${gridPassouTamPadrao}

        SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

    END

    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    #IF    ${SelecionaProdutoComLinha}
    IF    ${Teste_Comissao_Linha}

        IF    ${Codigos_Produtos} is None

            Calcula comissao com por produto - apenas 1 produto

        ELSE

            Set Test Variable    ${POSIÇÃO_VALOR}    ${0}

            IF    ${Valores_Parcelas} is not None

                Calcula comissao por produto em cada parcela personalizada

            ELSE

               Calcula comissao por produto

            END

        END

        Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Final}

    ELSE

        Calcula total da comissao

        ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_OPERAÇÃO} * (-1))
        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_DEVOLUCAO}

    END

E seleciono a comissao do servico

    Sleep    ${SLEEP_BAIXO}
    ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

    IF    ${gridSemRegistro}

        Press Combination    KEY.ALT    KEY.I
        Sleep    ${SLEEP_ALTO}
        Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    END

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    Sleep    ${SLEEP_BAIXO}
    ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

    IF    ${gridPassouTamPadrao}

        SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

    END

    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    IF    ${Teste_Comissao_Linha}

        Calcula o total da comissão por linha - Ordem de Serviço
        
    ELSE IF    ${Teste_Comissao_Total_Venda}
        
        Calcula o total da comissão sobre o valor total da venda - Ordem de Serviço

    END

E seleciono a comissão da venda e devolução

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    FOR    ${I}    IN RANGE    2

        Sleep    ${SLEEP_BAIXO}
        ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

        IF    ${gridPassouTamPadrao}

            SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

        END

        SikuliLibrary.Click    ${LISTAGEM_GRID}
        Sleep    ${SLEEP_BAIXO}

        #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda
        ${Cod_Venda_String}    Convert To String    ${CODIGO_OPERACAO_MOV}

        ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Venda_String}

        ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}


        FOR    ${J}    IN RANGE    ${Quantidade_de_zeros_esquerda}

            ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

        END
        #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda

        Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
        Sleep    ${SLEEP_BAIXO}

        FOR    ${K}    IN RANGE    9

            Press Special Key    RIGHT

        END

        Press Special Key    SPACE

        IF    ${SelecionaProdutoComLinha}

            IF    ${Codigos_Produtos} is None

                Calcula comissao com por produto - apenas 1 produto

            ELSE

                Set Test Variable    ${POSIÇÃO_VALOR}    ${I}
                Calcula comissao por produto

            END

        ELSE

            Calcula total da comissao

            ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_VENDA} * (-1))
            Set Test Variable    ${VALOR_FINAL_VENDA}    ${VALOR_DEVOLUCAO}

        END

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    END

E baixo a comissao recém recebida

    SikuliLibrary.Click    ${BT_BAIXAR}
    Wait Until Screen Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_OK}

    IF    ${Total_Comissao_Final} == 0 and ${Total_Comissao} == 0

        Wait Until Screen Contain    ${AVISO_COMISSAO_ZERADA}    ${TEMPO_TELA}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_FECHAR}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ESC

        Log To Console    Finalizando Teste pois comissão está zerada (correto para o cenário 2)

    ELSE

        Wait Until Screen Contain    ${AVISO_BAIXA_SUCESSO}    ${TEMPO_TELA}
        Press Special Key    ENTER

        Wait Until Screen Not Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

        ${id_comissao}    Query    SELECT ID FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC LIMIT 1;

        Set Test Variable    ${NDoc_Comissao}    ${id_comissao[0][0]}

    END

Quando acesso o caixa aberto

    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    Wait Until Screen Contain    ${LABEL_STATUS_ABERTO}    ${TEMPO_TELA}

E vou para a aba de contas a pagar

    SikuliLibrary.Click    ${ABA_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR}    ${TEMPO_TELA}

Então faço o pagamento da comissao

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    Wait Until Screen Contain    ${GRID_COMISSOES_PAGAR}    ${SLEEP_ALTO}

    SikuliLibrary.Click    ${INPUT_NUMERO_DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${NDoc_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    #SikuliLibrary.Click    ${CHECKBOX_CONTA_FOCO_GRID}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.g
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.S

    IF    ${Parametro_CaixaControladoPorUsuario}

        #No MyCommerce valida se o caixa que está aberto ou por usuario ou por terminal, tem marcado o recebimento ou pagamento diario, se não tiver exibe a tela de confirmação de data
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Usuario = ( SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1 ) AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa

        END

    ELSE

        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa

        END

    END

    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    ${Total_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C

    Sleep    ${SLEEP_ALTO}
    ${telaDeImpressao}    Exists    ${TELA_IMPRESSAO}

    IF    ${telaDeImpressao}

        Press Special Key    ESC
        Wait Until Screen Not Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}

    END

    Valida baixa comissao

Então visualizo os detalhes da comissao recem paga

    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${GUIA_COMISSOES_PAGAS_AGENDADAS}    ${TEMPO_TELA}

    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda
    ${Cod_Com_String}    Convert To String    ${NDoc_Comissao}

    ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Com_String}

    ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}

    FOR    ${J}    IN RANGE    ${Quantidade_de_zeros_esquerda}

        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

    END
    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${COL_LOTE}

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${NDoc_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Wait Until Screen Contain    ${TELA_DETALHES_COMISSAO}    ${SLEEP_ALTO}

    Press Special Key    ESC

E seleciono somente as recebidas

    FOR    ${I}    IN RANGE    2

        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}

    END

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Informa a data atual na data de recebimento

Calcula total da comissao

    ${Calculo_Comissao}    Evaluate    round((${VALOR_FINAL_OPERAÇÃO} * (${PercentualComissaoTotalVenda_Produto} / 100)), 2)

    ${Total_Comissao}    Evaluate    round((${Total_Comissao} + ${Calculo_Comissao}), 2)

    Set Test Variable    ${Total_Comissao}

    Log To Console    Valor Calculado|Parcial| da comissão: ${Calculo_Comissao}
    Log To Console    Valor final da comissão: ${Total_Comissao}

#Se você entender essa keyword meus parabéns. Tempo gasto nessa keyword até o momento: 3:30 horas - Ultima Atualização - 19/01/2024
#Tava dando muito B.O na questão de abater os valores e calcular correto (positivo e negativo), teve que ser criado uma lista com todos os valores de venda e devolução
Calcula comissao por produto

    ${Quantidade_Produtos_Calculo}    Get Length    ${Codigos_Produtos}

    FOR    ${I}    IN RANGE    ${Quantidade_Produtos_Calculo}

        ${Comisssao_Produto}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}

        ${Total_Comissao}    Evaluate    round((${Comisssao_Produto[0][0]} + ${Total_Comissao}), 4)

    END

    #Vai definir a % de comissão apenas positiva
    IF    ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} > 0

        ${PERCENT_COMISSAO}    Evaluate    ((${Total_Comissao} / ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]}) * 100)
        Set Suite Variable    ${PERCENT_COMISSAO}

    END

    ${Total_Comissao}    Evaluate    round((${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} * (${PERCENT_COMISSAO} / 100)), 4)

    ${Total_Comissao_Final}    Evaluate    round((${Total_Comissao_Final} + ${Total_Comissao}), 2)

    Set Test Variable    ${Total_Comissao_Final}

    Log To Console    Valor final da comissão: ${Total_Comissao}
    Log To Console    Valor final da comissão_Final: ${Total_Comissao_Final}
    Log To Console    %Comissao final: ${PERCENT_COMISSAO}

Calcula comissao com por produto - apenas 1 produto

    Sleep    ${SLEEP_BAIXO}
    ${Comisssao_Produto}    Query    SELECT SUM(v.ValorFinalPagamentos * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${COD_PRODUTO} INNER JOIN vendas AS v ON v.Codigo = ${CODIGO_OPERACAO_MOV}

    ${Total_Comissao}    Evaluate    round((${Comisssao_Produto[0][0]} + ${Total_Comissao}), 4)

    ${Total_Comissao_Final}    Evaluate    round((${Total_Comissao}), 2)

    Set Test Variable    ${Total_Comissao_Final}
    Set Test Variable    ${Total_Comissao}

    Log To Console    Valor final da comissão_Final: ${Total_Comissao_Final}

Valida baixa comissao

    Sleep    ${SLEEP_BAIXO}
    ${ComissaoPaga}    Query    SELECT Codigo, valor FROM contasapagar WHERE NDocumento = ${NDoc_Comissao} AND Quitado = 1 AND Descricao LIKE '%Comissão%' AND nComissao = ${NDoc_Comissao}
    ${Comissao_Paga_BD}    Evaluate    round((${ComissaoPaga[0][1]}), 2)

    Should Be Equal    ${ComissaoPaga[0][0]}    ${Codigo_Vendedor}
    Should Be Equal    ${Comissao_Paga_BD}    ${Total_Comissao}

    Check If Exists In Database    SELECT Sequencia, nDocumento, CodigoAbertura, ValorDocumento FROM caixamovimentos WHERE nDocumento = ${NDoc_Comissao}

    Log To Console    Validações passaram!

Dado que acesso o menu de vale compras

    SikuliLibrary.Click    ${MENU_COMERCIAL}

    FOR    ${I}    IN RANGE    9

        Press Special Key    DOWN

    END
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_VALE_COMPRA}     ${TEMPO_TELA}

E seleciono o vale gerado pela devolução

    Input Text    ${EMPTY}    ${ID_VALE_COMPRA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER

Quando faço a baixa do mesmo

    Press Combination    KEY.ALT     Key.B
    Wait Until Screen Contain    ${AVISO_BAIXA_VALE_COMPRA}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_BAIXA_VALE_COMPRA}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT     Key.C
    Sleep    ${SLEEP_BAIXO}

    Finalização com recebimento de duplicatas(${VALOR_FINAL_DEVOLUCAO})

    Wait Until Screen Contain    ${TELA_VALE_COMPRA}    ${TEMPO_TELA}

    Press Special Key    ESC

E seleciono as comissaos das vendas

    ${QuantidadeVendas}    Get Length    ${Codigo_Vendas}

    FOR    ${I}    IN RANGE    ${QuantidadeVendas}

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendas[${I}]}

        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Final_Vendas[${I}]}

        Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${DESCONTOS_COMISSOES[${I}][1]}

        E seleciono a comissao da venda

    END

E vou para a aba de servicos

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ABA_SERVICOS}    ${SLEEP_ALTO}

Calcula o total da comissão por linha - Ordem de Serviço

    ${Comissao_Servico}    Query    SELECT SUM(v.TotalServicos * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN servicos as s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${COD_SERVICO} INNER JOIN vendas AS v ON v.Codigo = ${CODIGO_OPERACAO_MOV}

    ${Total_Comissao}    Evaluate    round((${Comissao_Servico[0][0]}),2)

    Set Test Variable    ${Total_Comissao}

    Log To Console    Total parcial da comissão do servico: ${Total_Comissao}

Informa a data atual na data de recebimento

    Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}

    Type With Modifiers    H
    Press Special Key    TAB
    Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}

    Type With Modifiers    H
    Press Special Key    TAB


Calcula comissao por produto em cada parcela personalizada

    ${Quantidade_Produtos_Calculo}    Get Length    ${Codigos_Produtos}

    FOR    ${I}    IN RANGE    ${Quantidade_Produtos_Calculo}

        ${Comisssao_Produto}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}
        Log To Console    Comisssao_Produto[${I}]: ${Comisssao_Produto}

        ${Somatorio_Comissao_Parcela}    Evaluate    round((${Comisssao_Produto[0][0]} + ${Somatorio_Comissao_Parcela}), 4)
        Log To Console    Somatorio_Comissao_Parcela: ${Somatorio_Comissao_Parcela}

    END

    #Vai definir a % de comissão apenas positiva
    IF    ${Valores_Parcelas[${j}]} > 0

        ${PERCENT_COMISSAO}    Evaluate    round(((${Somatorio_Comissao_Parcela} / ${DADOS_VENDA_DEVOLUÇÃO[0][1]}) * 100), 4)

        Set Suite Variable    ${PERCENT_COMISSAO}
        Log To Console    PERCENT_COMISSAO: ${PERCENT_COMISSAO}

    END

    ${Total_Comissao_Parcela}    Evaluate    (${Valores_Parcelas[${j}]} * (${PERCENT_COMISSAO} / 100))
    Log To Console    Total_Comissao_Parcela: ${Total_Comissao_Parcela}

    ${Total_Comissao_Parcela}    Evaluate    round(${Total_Comissao_Parcela}, 2)
    Log To Console    roundTotal_Comissao_Parcela: ${Total_Comissao_Parcela}

    Set Test Variable    ${Total_Comissao_Final}    ${Total_Comissao_Parcela}
    Log To Console    Total_Comissao_Final: ${Total_Comissao_Final}

    ${j}    Evaluate    ${j} + 1
    Set Test Variable    ${j}

Calcula o total da comissão sobre o valor total da venda - Ordem de Serviço

    IF    ${OS_PossuiProduto}

        ${queryComissaoProdutos}    Query    SELECT ROUND(SUM(vp.ValorComissao), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};
        Log To Console    queryComissaoProdutos: ${queryComissaoProdutos[0][0]}
    
        Log To Console    Valor_Total_Produtos_OS: ${Valor_Total_Produtos_OS}
        Log To Console    PercentualComissaoTotalVenda_Produto: ${PercentualComissaoTotalVenda_Produto}
        ${calcComissaoProdutos}    Evaluate    round((${Valor_Total_Produtos_OS} * (${PercentualComissaoTotalVenda_Produto} / 100)), 2)

        Should Be Equal    ${queryComissaoProdutos[0][0]}    ${calcComissaoProdutos}

        Log To Console    Valor final da comissão (Produto): ${calcComissaoProdutos}
        
    END

    IF    ${OS_PossuiServico}

        ${queryComissaoServicos}    Query    SELECT ROUND(SUM(vs.ComissaoTotal), 2) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO};
        Log To Console    queryComissaoServicos: ${queryComissaoServicos[0][0]}

        Log To Console    Valor_Total_Servicos_OS: ${Valor_Total_Servicos_OS}
        Log To Console    PercentualComissaoTotalVenda_Servico: ${PercentualComissaoTotalVenda_Servico}
        ${calcComissaoServicos}    Evaluate    round((${Valor_Total_Servicos_OS} * (${PercentualComissaoTotalVenda_Servico} / 100)), 2)

        Should Be Equal    ${queryComissaoServicos[0][0]}    ${calcComissaoServicos}

        Log To Console    Valor final da comissão (Serviço): ${calcComissaoServicos}
        
    END

Dado que acesso a tela de relatório de comissão

    SikuliLibrary.Click    ${MENU_RELATORIOS}
    SikuliLibrary.Click    ${SUBMENU_RELATORIOS_COMISSOES}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${SUBMENU_RELATORIOS_COMISSOES}

    Wait Until Screen Contain    ${TELA_RELATORIO_COMISSOES}    ${TEMPO_TELA}

E gero o relatório de comissões(${tipo})

    IF    '${tipo}' == 'Agendadas'

        # É obrigatório informar vendedor
        SikuliLibrary.Click    ${RADIOBT_COMISSOES_AGENDADAS}

        Set Test Variable    ${COMISSOES_AGENDADAS}    ${True}
        
    ELSE IF    '${tipo}' == 'Pagas'

        # É obrigatório informar vendedor

        Log To Console    Implementar posteriormente.

        Set Test Variable    ${COMISSOES_PAGAS}    ${True}

    ELSE

        SikuliLibrary.Click    ${RADIOBT_COMISSOES_PENDENTES}
        
        Set Test Variable    ${COMISSOES_PENDENTES}    ${True}

    END

    Press Combination    KEY.ALT    KEY.O
    
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${LABEL_GERANDO_RELATORIO_AGUARDE}    ${TEMPO_TELA}

    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${RADIOBT_VISUALIZAR_IMPRESSAO}

    Press Combination    KEY.ALT    KEY.G
    Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${TEMPO_TELA}

    Press Special Key    ESC
    Wait Until Screen Not Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${SLEEP_ALTO}

Valida os dados do relatório de comissões

    IF    ${COMISSOES_PENDENTES}
        
        Validação de comissões pendentes        

    END

Validação de comissões pendentes

    ${consultaRelatorio}    Query    SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = 9097 AND TipoVenda = 'OS' UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = 9097 ORDER BY TipoVenda ASC;

    IF    ${OS_PossuiServico}

        # ${consultaRelatorio}    Query    SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = 9097 AND TipoVenda = 'OS' UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = 9097 AND TipoVenda = 'OS' ORDER BY TipoVenda ASC;

        ${totalOS}              Set Variable    ${consultaRelatorio[0][0]}
        ${totalServicos}        Set Variable    ${consultaRelatorio[0][2]}
        ${comissaoTotalServ}    Set Variable    ${consultaRelatorio[0][3]}
        
    END

    IF    ${OS_PossuiProduto}

        # ${consultaRelatorio}    Query    SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = 9097 AND TipoVenda = 'OS' UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = 9097 AND TipoVenda = 'VP' ORDER BY TipoVenda ASC;
        
        ${totalVenda}           Set Variable    ${consultaRelatorio[0][0]}
        ${totalProdutos}        Set Variable    ${consultaRelatorio[0][1]}
        ${comissaoTotalProd}    Set Variable    ${consultaRelatorio[0][3]}

    END

    IF    '${OS_PossuiServico}' == 'True' and '${OS_PossuiProduto}' == 'True'

        FOR    ${i}    IN RANGE    2
    
            Should Be Equal    ${consultaRelatorio[${i}][0]}    ${VALOR_FINAL_OPERAÇÃO}
            Should Be Equal    ${consultaRelatorio[${i}][1]}    ${Valor_Total_Produtos_OS}
            Should Be Equal    ${consultaRelatorio[${i}][2]}    ${Valor_Total_Servicos_OS}
            Should Be Equal    ${consultaRelatorio[${i}][3]}    second

        END
    
        # ${consultaRelatorio}    Query    SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = 9093 UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = 9093 ORDER BY TipoVenda ASC;
    
    END