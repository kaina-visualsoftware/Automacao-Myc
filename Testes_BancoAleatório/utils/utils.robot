*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

*** Variables ***
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${MODAL_LOCAL_NEGOCIACAO}                tela_LocalNegociacao.png
${BT_CONFIRMA_CANAL_NEGOCIACAO}          bt_ConfirmarCanal.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${TELA_SOLICITACAO_SENHA_USUARIO}        tela_SolicitaSenha.png
${INPUT_COD_CLIENTE}                     lb_CodCliente.png
${INPUT_COD_CLIENTE_VENDA}               lb_CodClienteVenda.png
#Sleep's    
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20

*** Keywords ***
Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA})
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C

Adicionar Vendedor e Cliente(${TELA})
    
    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    
    #Não me pergunte por que, mas só na tela de orçamento que o input é igual mas o robot ve diferente
    IF    '${TELA}' == 'Orcamento'
        Input Text    ${INPUT_COD_CLIENTE}    ${codCliente[0][0]}
    ELSE
        Input Text    ${INPUT_COD_CLIENTE_VENDA}    ${codCliente[0][0]}    
    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${Codigo_Cliente}    ${codCliente[0][0]}
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor[0][0]}

Valida local da negociação

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${MODAL_LOCAL_NEGOCIACAO} 

    IF    ${MSG}  
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN
        SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}

    END

Valida impressao direta de venda(${Parametro_ImprimeVendaDireto}) 
    
    IF    ${Parametro_ImprimeVendaDireto}
        
        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.S

    END

Valida solicitacao de senha do usuário

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END
