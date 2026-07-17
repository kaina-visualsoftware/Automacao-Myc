*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    DateTime
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/estoque.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Telas
${ABA_A_PAGAR}                                aba_contasAPagar.png
${ABA_A_RECEBER}                              aba_contasAReceber.png
${TELA_CONTAS_A_PAGAR}                        tela_ContasPagar.png
${TELA_RECEBIMENTO_PAGAMENTO}                 caixa_FinalizacaoRecebimentoPagamento.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}          tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                      tela_CaixaPrinicipalCarregando.png
${TELA_CONTAS_A_RECEBER}                      tela_ContasReceber.png
${TELA_RECEBIMENTO_DUPLICATAS}                tela_RecebimentoDuplicatas.png
${TELA_REGISTROS_ESTORNOS}                    tela_RegistrosDeEstornos.png
${TELA_ADIANTAMENTOS}                         tela_Adiantamenos_Caixa.png
${TELA_REC_PAG_RÁPIDO}                        tela_RecPagRápido.png

# Telas Avisos
${AVISO_REALMENTE_EFETUAR_BAIXA}              aviso_PerguntaQualquer.png
${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}              aviso_confirmacaoBaixaConta.png

# Botões
${BT_ESTORNAR}                                bt_Estornar.png
${BT_SIM}                                     bt_Sim.png
${BT_SETA_DIREITA_DATAS}                      bt_SetaDireitaDatas.png

# Outros
${INPUT_NUMERO_DOCUMENTO}                     caixa_PesquisaPorNDoc.png
${INPUT_RAZAO/NOME_VAZIO}                     campo_RazaoSocialNomeVazio.png
${INPUT_NUMERO_VENDA}                         caixa_PesquisaPorNVendac.png
${LABEL_NENHUMA_CONTA_RECEBER}                lb_NenhumaContaPendente.png
${LABEL_APENAS_A_RECEBER}                     label_ApenasAReceber.png
${CHECK_BOX_MARCADO}                          checkBox_Marcado.png
${CHECK_BOX_CONTA_PAGA}                       checkBox_ContaPaga.png
${LABEL_APENAS_A_PAGAR}                       label_ApenasAPagar.png
${CHECK_BOX_CONTAS_PAGA}                      checkBox_Marcado_Selecionado.png
${INPUT_NUMERO_NFS}                           input_NumeroNFS.png
${LABEL_DATA_LANCAMENTO}                      lb_CaixaDataLancamento.png
${INPUT_DATA_LANCAMENTO_A_RECEBER}            input_DataLancamentoAReceber.png
${INPUT_DATA_LANCAMENTO_A_PAGAR}              input_DataLancamentoAPagar.png
${CHECKBOX_CONTA_A_PAGAR}                     checkBox_CaixaContaAPagar.png
${LABEL_STATUS_ABERTO}                        lb_StatusAbertoCaixa.png
${Total_Recebido_Venda}                       ${0}
${LABEL_APENAS_A_RECEBER_HABILITADO}          label_ApenasAReceberHabilitado.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${Forma_Recebimento}                          None
${Forma_Pagamento}                            None
${Codigo_Cliente}                             None
${CODIGO_OPERACAO_MOV}                        None
${VALOR_FINAL_OPERAÇÃO}                       None
${CODIGO_CAIXA}                               None
${Sequencia_Caixa_Abertura}                   None
${COD_DEVOLUCAO}                              None
${Valor_Pago_Parcela}                         None
${N_Documento_Parcelas}                       ${None}
${Controle_Pag_Rec_Diario}                    ${None}
${valor_adiantamento}                         ${None}
${VALOR_RECEBIMENTO_ATUAL}                    ${None}

*** Keywords ***
Carregar dados de formas
    
    ${Forma_Recebimento}    Verifica Forma Recebimento Padrao
    ${Forma_Pagamento}      Verifica Forma Pagamento Padrao

    Set Test Variable    ${Forma_Recebimento}
    Set Test Variable    ${Forma_Pagamento}

Quando insiro o código do cliente(${GUIA})
    
    IF    '${GUIA}' == 'aReceber'
        
        Press Combination    KEY.ALT    KEY.C

    ELSE IF    '${GUIA}' == 'aPagar'

        Press Combination    KEY.ALT    KEY.F
        
    END

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    
    Wait Until Screen Not Contain    ${INPUT_RAZAO/NOME_VAZIO}    ${SLEEP_ALTO}

    Verifica se cliente possui condicional em aberto(${Codigo_Cliente})

Quando insiro um novo cliente
    
    ${Codigo_Cliente}    Seleciona cliente
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${Codigo_Cliente}

E pesquiso pela conta recém gerada

    ${Campo_N_Venda}    Exists    ${INPUT_NUMERO_VENDA}
    ${Campo_N_NFS}      Exists    ${INPUT_NUMERO_NFS}

    ${I}    Evaluate    0

    WHILE    ${Campo_N_Venda} == False

        IF    ${I} == 0

            SikuliLibrary.Click    ${BT_SETA_DIREITA}

            ${I}    Set Variable    1

        END

        IF    ${I} > 0

            Press Special Key    RIGHT
            Sleep    ${SLEEP_BAIXO}

            ${Campo_N_Venda}    Exists    ${INPUT_NUMERO_VENDA}
            ${Campo_N_NFS}      Exists    ${INPUT_NUMERO_NFS}

        END

        IF    ${Campo_N_NFS}

            WHILE    ${Campo_N_Venda} == False

                Press Special Key    LEFT
                Sleep    ${SLEEP_BAIXO}

                ${Campo_N_Venda}    Exists    ${INPUT_NUMERO_VENDA}
                ${Campo_N_NFS}      Exists    ${INPUT_NUMERO_NFS}

            END

            IF    ${Campo_N_Venda}

                Exit For Loop

            END
        END
    END
    
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${INPUT_NUMERO_VENDA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    Informa a data de lançamento da conta a receber

    FOR    ${I}    IN RANGE    ${FORMA_PADRAO[4]}
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE
        
    END

E pesquiso pela conta a pagar gerada

    SikuliLibrary.Click    ${INPUT_NUMERO_DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}
    
    Press Special Key    TAB
    
    Informa a data de lançamento da conta a pagar

    Press Special Key    SPACE

    Sleep    ${SLEEP_MEDIO}

Então concluo o pagamento da mesma
    
    Press Combination    KEY.ALT    KEY.g 
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT    KEY.C 
    # Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA_A_PAGAR}    ${SLEEP_ALTO}
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    # Press Combination    KEY.ALT    KEY.S
    SikuliLibrary.Click    ${BT_SIM}

    Wait Until Screen Not Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${SLEEP_ALTO}

    Valida tela de confirmação de data

    IF    '${Forma_Pagamento}' == 'Outros'

        Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

        Input Text    ${EMPTY}    ${VALOR_FINAL_OPERAÇÃO}

        Press Special Key    TAB
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.C
    
    ELSE IF     '${Forma_Pagamento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Pagamento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Pagamento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Consulta sequencia caixa(${Controle_Pag_Rec_Diario[0][2]})

    Validação movimentou caixa(Débito)

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

Quando acesso o caixa aberto

    Recupera sequencia caixa

    Carregar dados de formas

    Remove os grids personalizados do caixa
    
    Sleep    ${SLEEP_ALTO}
    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    Wait Until Screen Contain    ${LABEL_STATUS_ABERTO}    ${TEMPO_TELA}

E vou para a aba de contas a pagar

    SikuliLibrary.Click    ${ABA_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR}    ${SLEEP_ALTO}

E vou para a aba de contas a receber

    Verifica se cliente possui condicional em aberto(${Codigo_Cliente}) 
    
    SikuliLibrary.Click    ${ABA_A_RECEBER}
    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_MEDIO}

# Então faço o recebimento da conta
    
#     Sleep    ${SLEEP_BAIXO}
#     Press Combination    KEY.ALT    KEY.R
#     Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}
#     Sleep    ${SLEEP_BAIXO}

#     Press Combination    KEY.ALT    KEY.C
#     Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${TEMPO_TELA}
#     Sleep    ${SLEEP_BAIXO}

#     ${tela_baixa_conta_visivel}    Exists    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}
    
#     Sleep    ${SLEEP_BAIXO}
    
#     ${bt_sim_visivel}    Exists    ${BT_SIM}

#     SikuliLibrary.Click    ${BT_SIM}

#     Wait Until Screen Not Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${SLEEP_ALTO}

#     Valida tela de confirmação de data

#     IF    '${Forma_Recebimento}' == 'Outros'

#         Finalização com recebimento de duplicatas(${VALOR_FINAL_OPERAÇÃO})
    
#     ELSE IF     '${Forma_Recebimento}' == 'Cartão Oper.'
        
#         Finalização com recebimento de cartão de crédito/débito

#     ELSE IF     '${Forma_Recebimento}' == 'Moeda'
        
#         Log To Console    Tipo moeda não executada novas telas

#     ELSE IF     '${Forma_Recebimento}' == 'Bancária'
        
#         Finalização com o tipo bancaria

#     END

#     Wait Until Screen Contain    ${LABEL_NENHUMA_CONTA_RECEBER}    ${TEMPO_TELA}

#     Consulta sequencia caixa(${CODIGO_CAIXA})

#     Validação movimentou caixa(Crédito)

Quando desmarco a opção somente a receber
    
    Sleep    ${SLEEP_BAIXO}
    ${apenasAReceberHabilitado}    Exists    ${LABEL_APENAS_A_RECEBER_HABILITADO}
    
    WHILE    ${apenasAReceberHabilitado}

        SikuliLibrary.Click    ${LABEL_APENAS_A_RECEBER}
        Sleep    ${SLEEP_MEDIO}

        Verifica se cliente possui condicional em aberto(${Codigo_Cliente})
        
        ${apenasAReceberHabilitado}    Exists    ${LABEL_APENAS_A_RECEBER_HABILITADO}

    END

Quando desmarco a opção somente a pagar
    
    SikuliLibrary.Click    ${LABEL_APENAS_A_PAGAR}
    Sleep    ${SLEEP_MEDIO}

E dou um duplo clique na conta recém paga
    
    SikuliLibrary.Double Click    ${CHECK_BOX_CONTA_PAGA}
    Wait Until Screen Contain    ${TELA_REGISTROS_ESTORNOS}    ${SLEEP_ALTO}

E dou um duplo clique na conta a pagar já paga
    
    SikuliLibrary.Double Click    ${CHECK_BOX_CONTA_PAGA}
    Wait Until Screen Contain    ${TELA_REGISTROS_ESTORNOS}    ${SLEEP_ALTO}

Então estorno a conta - A pagar
    
    SikuliLibrary.Click    ${BT_ESTORNAR}
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    ${VALOR_FINAL_OPERAÇÃO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.C

    Validação movimentou caixa(Crédito)

Então estorno a conta - A receber
    
    SikuliLibrary.Click    ${BT_ESTORNAR}
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    ${VALOR_FINAL_OPERAÇÃO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.C

    Validação movimentou caixa(Débito)

    Wait Until Screen Contain    ${TELA_REGISTROS_ESTORNOS}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

E vou para a aba de adiantamentos
    
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${TELA_ADIANTAMENTOS}     ${TEMPO_TELA}

E insiro as informações do adiantamento(${Valor_Documento})
    
    Cria novo NDocumento a partir da sequencia do caixa 

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    H

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${Conta_Histórico}    Seleciona plano de contas - Débito

    Input Text    ${EMPTY}    ${Conta_Histórico}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${Valor_Documento}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Documento}

E insiro as informações do adiantamento - Recebimento(${Valor_Documento})
    
    Cria novo NDocumento a partir da sequencia do caixa 

    Press Special Key    RIGHT
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    H

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${Conta_Histórico}    Seleciona plano de contas - Crédito

    Input Text    ${EMPTY}    ${Conta_Histórico}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${Valor_Documento}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Documento}
    
Então finalizo o lançamento(${Tipo_Mov})

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Contain    ${AVISO_REALMENTE_EFETUAR_BAIXA}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S

    Valida tela de confirmação data - caixa

    Sleep    ${SLEEP_MEDIO}
    Validação movimentou caixa(${Tipo_Mov})

    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.S

E vou para a aba de rec/pag rapido
    
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT    KEY.d
    Wait Until Screen Contain    ${TELA_REC_PAG_RÁPIDO}    ${TEMPO_TELA}

E insiro as informações necessárias - recebimento rápido(${Valor_Documento})
    
    Cria novo NDocumento a partir da sequencia do caixa 

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    RIGHT
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Type    ${EMPTY}    Teste recebimento rapido
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${Conta_Histórico}    Seleciona plano de contas - Crédito

    Input Text    ${EMPTY}    ${Conta_Histórico}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${Valor_Documento}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Documento}

E insiro as informações necessárias - pagamento rápido(${Valor_Documento})
    
    Cria novo NDocumento a partir da sequencia do caixa 

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Type    ${EMPTY}    Teste pagamento rapido
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END
    
    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${Conta_Histórico}    Seleciona plano de contas - Débito

    Input Text    ${EMPTY}    ${Conta_Histórico}

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${Valor_Documento}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Documento}

Validação movimentou caixa(${Tipo_Mov})
    
    ${DATA_ATUAL}    Get Current Date    result_format=%Y-%m-%d
    Sleep    ${SLEEP_BAIXO}

    # Usa VALOR_RECEBIMENTO_ATUAL se definido, senão usa VALOR_FINAL_OPERAÇÃO
    ${valor_esperado}    Get Variable Value    \${VALOR_RECEBIMENTO_ATUAL}    ${None}

    IF    $valor_esperado is None
        ${valor_esperado}    Set Variable    ${VALOR_FINAL_OPERAÇÃO}
    END

    ${valor_esperado}    Convert To Number    ${valor_esperado}

    ${Consulta_CaixaMovimento}    Query    SELECT CodigoCliente, ValorDocumento, ValorPago, Data, TipoMovimento FROM caixamovimentos WHERE CodigoAbertura = ${Sequencia_Caixa_Abertura} AND NDocumento LIKE '%${CODIGO_OPERACAO_MOV}%' ORDER BY Sequencia DESC;

    ${Data_Banco}    Convert To String    ${Consulta_CaixaMovimento[0][3]}

    Should Be Equal    ${Consulta_CaixaMovimento[0][0]}    ${Codigo_Cliente}
    Should Be Equal As Numbers    ${Consulta_CaixaMovimento[0][1]}    ${valor_esperado}
    Should Be Equal As Numbers    ${Consulta_CaixaMovimento[0][1]}    ${Consulta_CaixaMovimento[0][2]}
    Should Be Equal    ${Data_Banco}    ${DATA_ATUAL}
    Should Be Equal    ${Consulta_CaixaMovimento[0][4]}    ${Tipo_Mov}

Consulta sequencia caixa(${Codigo_Caixa})
    
    ${Consulta_Seq}    Query    SELECT Sequencia FROM caixaaberturas WHERE CodigoCaixa = ${CODIGO_CAIXA} ORDER BY Sequencia DESC LIMIT 1

    Set Test Variable    ${Sequencia_Caixa_Abertura}    ${Consulta_Seq[0][0]}

Valida tela de confirmação de data
    
    IF    ${Parametro_CaixaControladoPorUsuario}
        
        # No MyCommerce, valida se o caixa aberto — seja por usuário ou por terminal — possui marcado o recebimento ou pagamento diário. Caso contrário, exibe a tela de confirmação de data.
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec, Codigo FROM caixas WHERE Usuario = ( SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1 ) AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )
        
        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa 

        END

    ELSE
        
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec, Codigo FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa 

        END

    END

    Set Test Variable    ${Controle_Pag_Rec_Diario}

Recupera sequencia caixa

    Log To Console    Terminal=[${NomeTerminalExecucao}]

    IF    ${Parametro_CaixaControladoPorUsuario}
        
        # No MyCommerce, valida se o caixa aberto — seja por usuário ou por terminal — possui marcado o recebimento ou pagamento diário. Caso contrário, exibe a tela de confirmação de data.
        Sleep    ${SLEEP_BAIXO}
        ${Controle_Pag_Rec_Diario}    Query    SELECT Codigo FROM caixas WHERE Usuario = (SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1) AND `Status` LIKE 'Aberto' AND Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    ELSE
        
        Sleep    ${SLEEP_BAIXO}
        ${Controle_Pag_Rec_Diario}    Query    SELECT Codigo FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

    END
    
    Log To Console    Resultado=${Controle_Pag_Rec_Diario}

    Set Test Variable    ${CODIGO_CAIXA}    ${Controle_Pag_Rec_Diario[0][0]}

Cria novo NDocumento a partir da sequencia do caixa
    
    ${Ultima_Sequencia}    Query    SELECT Sequencia FROM caixamovimentos ORDER BY Sequencia DESC LIMIT 1;

    IF    len($Ultima_Sequencia) == 0

        Fail    Nenhuma sequência encontrada no caixa.
        
    END

    ${Novo_NDoc}    Evaluate    ${Ultima_Sequencia[0][0]} + 1

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Novo_NDoc}

Então concluo o pagamento

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Contain    ${AVISO_REALMENTE_EFETUAR_BAIXA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S

    IF    '${Forma_Pagamento}' == 'Outros'

        Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

        Input Text    ${EMPTY}    ${VALOR_FINAL_OPERAÇÃO}
        Sleep    ${SLEEP_MEDIO}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.C
    
    ELSE IF     '${Forma_Pagamento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Pagamento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Pagamento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Validação movimentou caixa(Débito)
    Sleep    ${SLEEP_MEDIO}

Então concluo o recebimento

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Contain    ${AVISO_REALMENTE_EFETUAR_BAIXA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S

    IF    '${Forma_Recebimento}' == 'Outros'

        Finalização com recebimento de duplicatas(${VALOR_FINAL_OPERAÇÃO})
    
    ELSE IF     '${Forma_Recebimento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Recebimento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Recebimento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Validação movimentou caixa(Crédito)
    Sleep    ${SLEEP_MEDIO}

Informa a data de lançamento da conta a receber
    
    Sleep    ${SLEEP_BAIXO}
    ${inputDataLancAReceber}    Exists    ${INPUT_DATA_LANCAMENTO_A_RECEBER}

    IF    ${inputDataLancAReceber}

        Sleep    ${SLEEP_BAIXO}
        ${CampoDataLancamentoAReceber}    Exists    ${LABEL_DATA_LANCAMENTO}

        IF    '${CampoDataLancamentoAReceber}' == 'False'
                
            SikuliLibrary.Click    ${BT_SETA_DIREITA_DATAS}
            Wait Until Screen Contain    ${LABEL_DATA_LANCAMENTO}    ${SLEEP_MEDIO}

        END
        
        SikuliLibrary.Click    ${INPUT_DATA_LANCAMENTO_A_RECEBER}

        Type With Modifiers    H
        Press Special Key    TAB
        Type With Modifiers    H
        Press Special Key    TAB

    END

Informa a data de lançamento da conta a pagar
    
    Sleep    ${SLEEP_BAIXO}
    ${inputDataLancAPagar}    Exists    ${INPUT_DATA_LANCAMENTO_A_PAGAR}

    IF    ${inputDataLancAPagar}

        Sleep    ${SLEEP_BAIXO}
        ${CampoDataLancamentoAPagar}    Exists    ${LABEL_DATA_LANCAMENTO}

        IF    '${CampoDataLancamentoAPagar}' == 'False'
                
            SikuliLibrary.Click    ${BT_SETA_DIREITA_DATAS}
            Wait Until Screen Contain    ${LABEL_DATA_LANCAMENTO}    ${SLEEP_MEDIO}

        END
        
        SikuliLibrary.Click    ${INPUT_DATA_LANCAMENTO_A_PAGAR}

        Type With Modifiers    H
        Press Special Key    TAB
        Type With Modifiers    H
        Press Special Key    TAB

    END

Então faço o recebimento das parcelas da conta
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    Key.R
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C 
    # Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA_A_RECEBER}    ${TEMPO_TELA}
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    # Press Combination    KEY.ALT    KEY.S
    SikuliLibrary.Click    ${BT_SIM}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Not Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${SLEEP_ALTO}

    Valida tela de confirmação de data

    IF    '${Forma_Recebimento}' == 'Outros'

        Finalização com recebimento de duplicatas(${Valores_Parcelas[${POSICAO_PARCELA}]})
    
    ELSE IF     '${Forma_Recebimento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Recebimento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Recebimento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Wait Until Screen Contain    ${LABEL_NENHUMA_CONTA_RECEBER}    ${TEMPO_TELA}

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Consulta o valor pago da parcela(${POSICAO_PARCELA})

    Valida o recebimento da venda com base no somatório das parcelas pagas

    Validação movimentou parcelas no caixa(Crédito)

Validação movimentou parcelas no caixa(${Tipo_Mov})
    
    ${DATA_ATUAL}    Get Current Date    result_format=%Y-%m-%d
    Sleep    ${SLEEP_BAIXO}

    ${Consulta_CaixaMovimento}    Query    SELECT CodigoCliente, ValorDocumento, ValorPago, Data, TipoMovimento FROM caixamovimentos WHERE CodigoAbertura = ${Sequencia_Caixa_Abertura} AND NDocumento LIKE '%${CODIGO_OPERACAO_MOV}%' ORDER BY Sequencia DESC;

    ${Data_Banco}    Convert To String    ${Consulta_CaixaMovimento[0][3]}

    ${Valores_Parcelas_Convertido}    Convert To Number    ${Valores_Parcelas[${POSICAO_PARCELA}]}

    Should Be Equal    ${Consulta_CaixaMovimento[0][0]}    ${Codigo_Cliente}
    Should Be Equal    ${Consulta_CaixaMovimento[0][1]}    ${Valores_Parcelas_Convertido}
    Should Be Equal    ${Consulta_CaixaMovimento[0][1]}    ${Consulta_CaixaMovimento[0][2]}
    Should Be Equal    ${Data_Banco}    ${DATA_ATUAL}
    Should Be Equal    ${Consulta_CaixaMovimento[0][4]}    ${Tipo_Mov}

Consulta o valor pago da parcela(${i})
        
    ${valorPagoParc}    Query    SELECT cr.ValorPago FROM contasareceber cr WHERE cr.CodigoVenda = ${CODIGO_OPERACAO_MOV} AND cr.NDocumento LIKE '%${N_Documento_Parcelas[${i}]}%' AND cr.Quitado = 1 ORDER BY cr.Npagamento LIMIT 1;

    Set Test Variable    ${Valor_Pago_Parcela}    ${valorPagoParc[0][0]}

Valida o recebimento da venda com base no somatório das parcelas pagas

    ${Total_Recebido_Venda}    Evaluate    ${Total_Recebido_Venda} + ${Valor_Pago_Parcela}

    Set Test Variable    ${Total_Recebido_Venda}

E pesquiso pela venda e pela devolução recém geradas

    Informa a data de lançamento da conta a receber

    FOR    ${i}    IN RANGE    2
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE
        
    END

    Press Special Key    TAB

Valida as movimentações no caixa - Venda e Devolução(${Tipo_Mov})
    
    ${DATA_ATUAL}    Get Current Date    result_format=%Y-%m-%d
    Sleep    ${SLEEP_BAIXO}

    ${Consulta_CaixaMovimento}    Query    SELECT CodigoCliente, ValorDocumento, ValorPago, Data, TipoMovimento FROM caixamovimentos WHERE CodigoAbertura = ${Sequencia_Caixa_Abertura} AND NVenda IN (${COD_DEVOLUCAO}, ${COD_VENDA}) ORDER BY NVenda;
    
    ${VALOR_FINAL_OPERAÇÃO}    Set Variable    ${VALOR_FINAL_VENDA}

    FOR    ${i}    IN RANGE    2
        
        ${Data_Banco}    Convert To String    ${Consulta_CaixaMovimento[${i}][3]}

        ${Valor_Final_Operação_Convertido}    Convert To Number    ${VALOR_FINAL_OPERAÇÃO}

        Should Be Equal    ${Consulta_CaixaMovimento[${i}][0]}    ${Codigo_Cliente}
        Should Be Equal    ${Consulta_CaixaMovimento[${i}][1]}    ${Valor_Final_Operação_Convertido}
        Should Be Equal    ${Consulta_CaixaMovimento[${i}][1]}    ${Consulta_CaixaMovimento[${i}][2]}
        Should Be Equal    ${Data_Banco}    ${DATA_ATUAL}
        Should Be Equal    ${Consulta_CaixaMovimento[${i}][4]}    ${Tipo_Mov}

        ${VALOR_FINAL_OPERAÇÃO}    Set Variable    ${VALOR_FINAL_DEVOLUCAO}

    END

Então faço o recebimento da venda e da devolução
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.R
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C 
    # Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA_A_RECEBER}    ${TEMPO_TELA}
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    # Press Combination    KEY.ALT    KEY.S
    SikuliLibrary.Click    ${BT_SIM}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Not Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${SLEEP_ALTO}

    Valida tela de confirmação de data

    IF    '${Forma_Recebimento}' == 'Outros'

        Finalização com recebimento de duplicatas(${VALOR_FINAL_OPERAÇÃO})
    
    ELSE IF     '${Forma_Recebimento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Recebimento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Recebimento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Wait Until Screen Contain    ${LABEL_NENHUMA_CONTA_RECEBER}    ${TEMPO_TELA}

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Valida as movimentações no caixa - Venda e Devolução(Crédito)

Calcula valor da OS com adiantamento
    [Arguments]    ${valor_total_os}

    ${ja_usou_adiantamento}    Get Variable Value    \${_ja_usou_adiantamento}    False

    IF    not ${ja_usou_adiantamento}

        Set Test Variable    ${_ja_usou_adiantamento}    True

        RETURN    ${valor_adiantamento}

    END

    ${valor_restante_os}    Evaluate    round(${valor_total_os} - ${valor_adiantamento}, 2)

    RETURN    ${valor_restante_os}

Então faço o recebimento da conta

    ${valor_os}    Get Variable Value    \${VALOR_RECEBIMENTO_ATUAL}    ${None}

    IF    $valor_os is None
        ${valor_os}    Set Variable    ${VALOR_FINAL_OPERAÇÃO}
    END

    Press Combination    KEY.ALT    KEY.R
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_SIM}

    Wait Until Screen Not Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}    ${SLEEP_ALTO}

    Valida tela de confirmação de data

    IF    '${Forma_Recebimento}' == 'Outros'

        Finalização com recebimento de duplicatas(${valor_os})

    ELSE IF     '${Forma_Recebimento}' == 'Cartão Oper.'
        
        Finalização com recebimento de cartão de crédito/débito

    ELSE IF     '${Forma_Recebimento}' == 'Moeda'
        
        Log To Console    Tipo moeda não executada novas telas

    ELSE IF     '${Forma_Recebimento}' == 'Bancária'
        
        Finalização com o tipo bancaria

    END

    Wait Until Screen Contain    ${LABEL_NENHUMA_CONTA_RECEBER}    ${TEMPO_TELA}

    Consulta sequencia caixa(${CODIGO_CAIXA})

    Validação movimentou caixa(Crédito)

    # Limpa o valor customizado para não impactar nas próximas chamadas
    Set Test Variable    ${VALOR_RECEBIMENTO_ATUAL}    ${None}

E preparo recebimento com adiantamento

    ${valor_recebimento}    Calcula valor da OS com adiantamento    ${VALOR_FINAL_OPERAÇÃO}
    Set Test Variable    ${VALOR_RECEBIMENTO_ATUAL}    ${valor_recebimento}