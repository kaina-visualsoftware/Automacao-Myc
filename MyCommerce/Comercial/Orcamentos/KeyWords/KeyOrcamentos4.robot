*** Settings ***
Documentation    Testes básicos em orçamentos, inlcuindo produtos, excluindo, editando. Finalizando venda incluindo e desdobrando os pagamentos.

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    C:\\Automacao\\MyCommerce-Automacao\\MyCommerce\\libs\\verificaProduto.py


*** Variables ***
${IMAGES}                    ./MyCommerce/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    bdvinicius
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${TELA_ORCAMENTO}            tela_Orcamentos.png
${TELA_ORC_ADICIONAR}        tela_Orcamentos_Adicionar.png
${TELA_ORC_SEM_OBJETO}       tela_Orcamentos_Sem_Objeto.png
${TELA_SELECAO_GRADE}        tela_SelecaoGrade.png
${TELA_EXCLUIR_PRODUTO}      tela_Orcamentos_ExcluirProduto.png
${AVISO_DESEJA_EXCLUIR}      aviso_DesejaExcluir.png
${TELA_EXCLUSAO_ORC}         tela_ExclusaoOrc.png
${TELA_PESQUISA_PRODUTO}     tela_PesquisaProduto.png
#Botões
${BT_ABRIR_OBJETO}           bt_Abrir_Objeto.png
${BT_DOWN_OBJETO}            bt_DowbObjeto_Orc.png
${BT_SELECIONAR}             bt_Selecionar.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_NORMAL2}       7
${COD_NUMSERIAL/PLACA}       1234
${COD_SERVIÇO_GERAL}         1
${COD_SERVIÇO_COMPUT}        3
${COD_PRODUTO_GRADE}         6
${COD_PRODUTO_LOTE}          5
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43
#Diversos
${TX_DETAL_SERVIÇO}          ALTERNADOR   

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de orçamentos
    Type With Modifiers    O    CTRL
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}

E insiro Vendedor e Cliente
    Input Text    ${EMPTY}    ${COD_VENDEDOR}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_CLIENTE}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

Quando insiro o produto com insert(${REPETICOES})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    F1
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PESQUISA_PRODUTO}    ${TEMPO_TELA}

    FOR    ${I}    IN RANGE    ${REPETICOES}
        
        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END

        Sleep    ${SLEEP_BAIXO}
        Input Text  ${EMPTY}    ${COD_PRODUTO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    INSERT
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    BACKSPACE
        Sleep    ${SLEEP_BAIXO}
        
    END

E seleciono clicando no botão
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_SELECIONAR}
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}   

E seleciono clicando no atalho botão
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}   

Então finalizo o orçamento como a vista
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
