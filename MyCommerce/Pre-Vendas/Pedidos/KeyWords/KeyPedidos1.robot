*** Settings ***
Documentation    Testes Pedidos pré-venda

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
${TELA_PEDIDOS}              tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}    tela_PedidoAdicionar.png
${TELA_FORMA_PERSONAL}       tela_PersonalizacaoPagamentos.png
${TELA_SELEÇÃO_GRADE}        tela_SelecaoGrade.png
#Botões
${BT_SIM}                    bt_Sim.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_GRADE}         6
${COD_PRODUTO_SERIAL}        188
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_LOTE}          5
${COD_TRANSPORTADORA}        66

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}
    
Dado que acesso da tela de pedidos
    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando clico em adicionar um pedido
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E insiro vendedor e cliente 
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

Quando insiro um produto(${COD_PRODUTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    Set Suite Variable    ${COD_PRODUTO}

Quando insiro um produto do tipo Grade
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_GRADE}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Wait Until Screen Contain    ${TELA_SELEÇÃO_GRADE}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.o 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 

Quando insiro todos os tipos de produtos
    
    FOR    ${I}    IN RANGE    4
        
        IF    ${I} == 0
            Quando insiro um produto(${COD_PRODUTO_NORMAL})
        END
        IF    ${I} == 1
            Quando insiro um produto(${COD_PRODUTO_KIT})
        END
        IF    ${I} == 2
            Quando insiro um produto(${COD_PRODUTO_SERIAL})
        END
        IF    ${I} == 3
            Quando insiro um produto(${COD_PRODUTO_LOTE})
        END

    END

    Quando insiro um produto do tipo grade

Então finalizo o pedido - A vista
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então finalizo o pedido - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então finalizo o pedido - Personalizado
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_FORMA_PERSONAL}    ${TEMPO_TELA}

    FOR    ${I}    IN RANGE    2
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

    Press Special Key    DELETE
    Input Text    ${EMPTY}    2
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Quando preencho a aba de transportadora
    Press Combination    KEY.ALT     Key.T 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_TRANSPORTADORA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB 
    Sleep    ${SLEEP_BAIXO}

Então pressiono o atalho de excluir 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.X 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    Exclusao Pedido Automacao 
    SikuliLibrary.Click    ${BT_SIM}
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Quando pressiono o botão de editar
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E 
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}

E estorno a auditoria
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}

E edito o último produto 
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E 
    Input Text    ${EMPTY}    2
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    10
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Press Combination    KEY.ALT     Key.A
