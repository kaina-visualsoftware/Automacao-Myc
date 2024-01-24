*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    ../libs/verificacoesExtras.py
Library    ../libs/estoque.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot
Resource     ../utils/montadorDeCenarios.robot

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.220
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Informações Extras
${NomeTerminalExecucao}                  ${config.terminal_name}  
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
${TEMPO_LIMITE_CARREGAMENTO_GRID}        6
#Imagens Telas
${CAIXA_PRINCIPAL}                       tela_CaixaPrinicipal.png
${ABA_A_PAGAR}                           aba_contasAPagar.png 
${ABA_A_RECEBER}                         aba_contasAReceber.png
${TELA_CONTAS_A_PAGAR}                   tela_ContasPagar.png 
${TELA_RECEBIMENTO_PAGAMENTO}            caixa_FinalizacaoRecebimentoPagamento.png
${AVISO_CONFIRMAÇÃO_BAIXA}               aviso_confirmacaoBaixaContaPagar.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}     tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                 tela_CaixaPrinicipalCarregando.png
${INPUT_NUMERO_DOCUMENTO}                caixa_PesquisaPorNDoc.png
${TELA_CONTAS_A_RECEBER}                 tela_ContasReceber.png
${INPUT_RAZAO/NOME_VAZIO}                campo_RazaoSocialNomeVazio.png
${INPUT_NUMERO_VENDA}                    caixa_PesquisaPorNVendac.png
${LABEL_NENHUMA_CONTA_RECEBER}           lb_NenhumaContaPendente.png 
${TELA_RECEBIMENTO_DUPLICATAS}           tela_RecebimentoDuplicatas.png

*** Keywords ***
Quando acesso o caixa aberto 
    
    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    
    #Highlight    ${TELA_CAIXA_CARREGANDO}    1
    
    #Ignora o erro pq tem bancos em que carrega muito rápido, então ele não percebe a mudança e da erro
    Run Keyword And Ignore Error    Wait Until Screen Not Contain    ${TELA_CAIXA_CARREGANDO}    ${TEMPO_LIMITE_CARREGAMENTO_GRID}

E vou para a aba de contas a pagar

    SikuliLibrary.Click    ${ABA_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR}    ${SLEEP_ALTO}

E vou para a aba de contas a receber
    
    SikuliLibrary.Click    ${ABA_A_RECEBER}
    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER}    ${SLEEP_ALTO}

Então faço o recebimento da conta 
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    
    Wait Until Screen Contain    ${INPUT_RAZAO/NOME_VAZIO}    ${SLEEP_ALTO}

    Verifica se condicional existe(${Codigo_Cliente})

    SikuliLibrary.Click    ${INPUT_NUMERO_VENDA}
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    ${FORMA_PADRAO[4]}
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE
        
    END

    Press Combination    KEY.ALT     Key.R
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA}    ${SLEEP_ALTO}
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

    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS}    ${SLEEP_ALTO}

    Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C

    Wait Until Screen Contain    ${LABEL_NENHUMA_CONTA_RECEBER}    ${SLEEP_ALTO}

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC


# Então faço o pagamento da comissao
    
#     Sleep    ${SLEEP_BAIXO}
#     Input Text    ${EMPTY}    ${Codigo_Vendedor}
#     Sleep    ${SLEEP_BAIXO}
#     Press Special Key    TAB
#     Wait Until Screen Contain    ${GRID_COMISSOES_PAGAR}    ${SLEEP_ALTO}
#     SikuliLibrary.Click    ${INPUT_NUMERO_DOCUMENTO}
#     Sleep    ${SLEEP_BAIXO}
#     Input Text    ${EMPTY}    ${NDoc_Comissao}
#     Sleep    ${SLEEP_BAIXO}
#     Press Special Key    TAB
#     Sleep    ${SLEEP_BAIXO}
#     Press Special Key    SPACE

#     Press Combination    KEY.ALT     Key.g 
#     Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${SLEEP_ALTO}
#     Press Combination    KEY.ALT     Key.C 
#     Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA}    ${SLEEP_ALTO}
#     Press Combination    KEY.ALT     Key.S

#     IF    ${Parametro_CaixaControladoPorUsuario}
        
#         #No MyCommerce valida se o caixa que está aberto ou por usuario ou por terminal, tem marcado o recebimento ou pagamento diario, se não tiver exibe a tela de confirmação de data
#         ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Usuario = ( SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1 ) AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )
        
#         IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

#             Valida tela de confirmação data - caixa 

#         END

#     ELSE
        
#         ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

#         IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

#             Valida tela de confirmação data - caixa 

#         END

#     END

#     Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${SLEEP_ALTO}

#     Input Text    ${EMPTY}    ${Total_Comissao}
#     Sleep    ${SLEEP_BAIXO}
#     Press Special Key    TAB
#     Sleep    ${SLEEP_BAIXO}
#     Press Combination    KEY.ALT     Key.C

#     Sleep    ${SLEEP_BAIXO}
#     Press Special Key    ESC

#     Valida baixa comissao