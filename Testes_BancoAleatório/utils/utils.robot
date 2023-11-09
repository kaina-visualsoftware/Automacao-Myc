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

Valida local da negociação

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${MODAL_LOCAL_NEGOCIACAO} 

    IF    ${MSG}  
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN
        SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}

    END