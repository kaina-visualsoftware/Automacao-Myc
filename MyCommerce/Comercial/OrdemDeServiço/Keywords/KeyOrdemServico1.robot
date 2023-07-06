*** Settings ***
Documentation    Testes Ordem de Serviço

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
${TELA_OS}                   tela_OrdemDeServico.png
${TELA_OS_ADICIONAR}         tela_OSPreenchida.png
${TELA_FUNC_COMISSAO}        tela_FuncionariosComissionados.png
${TELA_DETAL_SERVICO}        tela_DetalhamentoServico.png
${TELA_RECEB_DUPLICATAS}     tela_RecebimentoDuplicatas.png
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
${COD_SERVIÇO_GERAL}         1
${COD_SERVIÇO_COMPUT}        3

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a guia ordens de serviços
    Press Special Key    F3
    Wait Until Screen Contain    ${TELA_OS}     ${TEMPO_TELA}

Quando preencho código de vendedor e do cliente
    Press Combination    KEY.ALT    key.A
    Wait Until Screen Contain    ${TELA_OS_ADICIONAR}     ${TEMPO_TELA}
    Input Text    ${EMPTY}   ${COD_VENDEDOR}
    Press Special Key    ENTER 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_CLIENTE}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_OS}    ${Consulta[0][0]}

E preencho a guia serviços
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Input Text    ${EMPTY}     ${COD_SERVIÇO_GERAL} 
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_DETAL_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}   Detalhes do servico
    Press Combination    KEY.ALT    key.C
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.n
    Wait Until Screen Contain    ${TELA_FUNC_COMISSAO}    ${TEMPO_TELA}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.I
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     key.S
    Sleep    ${SLEEP_BAIXO}

Quando escolho a forma 30 dias na aba pagamentos
    Press Combination    KEY.ALT    key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEy.ALT    key.D
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_MEDIO}

Quando escolho a forma à vista na aba pagamentos
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.m
    Sleep    ${SLEEP_BAIXO}
    
    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEy.ALT    key.D
    Sleep    ${SLEEP_BAIXO}

E digito o valor do pagamento e confirmo
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    100
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.C
    Wait Until Screen Contain    ${TELA_OS}    ${TEMPO_TELA}

Quando escolho a forma personalizada na aba pagamentos
    Sleep    ${SLEEP_BAIXO}
     Press Combination    KEY.ALT    key.m
   
    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    DOWN
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
   
    FOR    ${I}    IN RANGE    2
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DELETE
    Input Text    ${EMPTY}    2
    Press Combination    KEY.ALT    key.G
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.D 
    Sleep    ${SLEEP_BAIXO}


E preencho a guia produtos
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.P 
    Input Text    ${EMPTY}    ${COD_PRODUTO_NORMAL}   
    
    FOR    ${I}    IN RANGE    2
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
    END
    
    Press Combination    KEY.ALT    key.I
    Sleep    ${SLEEP_BAIXO}

    ${verificacao}    Verifica Produto Incluiu Correto    OS    ${COD_PRODUTO_NORMAL}    ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

E digito o valor do pagamento de ambos
    Input Text    ${EMPTY}    200
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.C
    Wait Until Screen Contain    ${TELA_OS}    ${TEMPO_TELA}