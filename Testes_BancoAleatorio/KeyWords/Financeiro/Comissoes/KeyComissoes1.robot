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
${IMAGES}                                ./testes_bancoAleatorio/images

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
${BT_JÁ_SELECIONADO}                     ${False}

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

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

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
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Wait Until Screen Contain    ${LISTAGEM_GRID}    ${SLEEP_ALTO}

Pesquisa código da operação com zeros a esquerda
    
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

    Sleep    ${SLEEP_BAIXO}
    ${gridBranco}    Exists    ${CHECKBOX_COMISSAO_FOCO_GRID}
    Sleep    ${SLEEP_BAIXO}
    ${gridAmarelo}    Exists    ${CHECKBOX_CONTA_FOCO_GRID_2}

    IF    ${gridBranco}

        SikuliLibrary.Click    ${CHECKBOX_COMISSAO_FOCO_GRID}

    ELSE IF    ${gridAmarelo}
            
        SikuliLibrary.Click    ${CHECKBOX_CONTA_FOCO_GRID_2}

    END

E seleciono a comissao da venda
    
    Sleep    ${SLEEP_BAIXO}
    ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

    IF    ${gridSemRegistro}
        
        Press Combination    KEY.ALT    KEY.I
        Sleep    ${SLEEP_ALTO}
        Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    END

    IF    '${BT_JÁ_SELECIONADO}' == 'False'

        SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    END

    Sleep    ${SLEEP_BAIXO}
    ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}
    
    IF    ${gridPassouTamPadrao}

        SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}
        
    END
    
    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    IF    ${SelecionaProdutoComLinha}

        IF    ${Codigos_Produtos} is None
                
            Calcula comissao com por produto - apenas 1 produto

        ELSE

            Set Test Variable    ${POSIÇÃO_VALOR}    ${0}
            Calcula comissao por produto

        END

        Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Final}

    ELSE

        Calcula total da comissao

        ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_OPERAÇÃO} * (-1))
        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_DEVOLUCAO}

    END

E seleciono a comissao do servico

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    Calcula total comissao por servico

E seleciono a comissão da venda e devolução

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}
    
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

        Sleep    ${SLEEP_BAIXO}
        ${gridBranco}    Exists    ${CHECKBOX_COMISSAO_FOCO_GRID}
        Sleep    ${SLEEP_BAIXO}
        ${gridAmarelo}    Exists    ${CHECKBOX_CONTA_FOCO_GRID_2}

        IF    ${gridBranco}

            SikuliLibrary.Click    ${CHECKBOX_COMISSAO_FOCO_GRID}

        ELSE IF    ${gridAmarelo}
            
            SikuliLibrary.Click    ${CHECKBOX_CONTA_FOCO_GRID_2}

        END

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

    SikuliLibrary.Click    ${CHECKBOX_CONTA_FOCO_GRID}
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

Calcula total da comissao
    
    ${Calculo_Comissao}    Evaluate    round((${VALOR_FINAL_OPERAÇÃO} * (${PercentualComissao} / 100)), 2)
    
    ${Total_Comissao}    Evaluate    round((${Total_Comissao} + ${Calculo_Comissao}), 2)

    Set Test Variable    ${Total_Comissao}
    
    Log To Console    Valor Calculado|Parcial| da comissão: ${Calculo_Comissao}
    Log To Console    Valor final da comissão: ${Total_Comissao}

#Se você entender essa keyword meus parabéns. Tempo gasto nessa keyword até o momento: 3:30 horas - Ultima Atualização - 19/01/2024
#Tava dando muito B.O na questão de abater os valores e calcular correto (positivo e negativo), teve que ser criado uma lista com todos os valores de venda e devolução
Calcula comissao por produto

    ${Quantidade_Produtos_Calculo}    Get Length    ${Codigos_Produtos}

    FOR    ${I}    IN RANGE    ${Quantidade_Produtos_Calculo}

        ${Comisssao_Produto}    Query    SELECT SUM(p.VendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}

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

    ${VALOR_VALE}    Evaluate    (${VALOR_FINAL_VENDA} * -1)
    Finalização com recebimento de duplicatas(${VALOR_VALE})

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_VALE_COMPRA}     ${TEMPO_TELA}

    Press Special Key    ESC

E seleciono as comissaos das vendas

    ${QuantidadeVendas}    Get Length    ${Codigo_Vendas}

    FOR    ${I}    IN RANGE    ${QuantidadeVendas}
        
        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendas[${I}]}
    
        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Final_Vendas[${I}]}

        Set Test Variable    ${PercentualComissao}    ${DESCONTOS_COMISSOES[${I}][1]}
        
        E seleciono a comissao da venda
        
        Set Test Variable    ${BT_JÁ_SELECIONADO}    ${True}

    END
    
E vou para a aba de servicos

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ABA_SERVICOS}    ${SLEEP_ALTO}

Calcula total comissao por servico
    
    ${Comissao_Servico}    Query    SELECT SUM(v.TotalServicos * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN servicos as s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${COD_SERVICO} INNER JOIN vendas AS v ON v.Codigo = ${CODIGO_OPERACAO_MOV}
    
    ${Total_Comissao}    Evaluate    round((${Comissao_Servico[0][0]}),2)

    Set Test Variable    ${Total_Comissao}

    Log To Console    Total parcial da comissão do servico: ${Total_Comissao}