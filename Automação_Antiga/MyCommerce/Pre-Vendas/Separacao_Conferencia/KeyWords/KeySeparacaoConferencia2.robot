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
${MENU_PRE_VENDAS}           menu_PreVendas.png
${TELA_SEPARACAO_CONFERE}    tela_SeparacaoConferencia.png
${TELA_PESQUISA_PREVENDA}    tela_PesquisaPreVenda.png
${TELA_INFO_ADICIONAIS}      tela_InfoAdicionais.png
${TELA_1PROD_CONFERIDO}      tela_SeparacaoConferencia-1ProdutoConferido.png
${TELA_AVISO_FECHAR}         aviso_DesejaFechar.png
${AVISO_RECOMEÇAR_SEP}       aviso_RecomeçarSeparacao.png
${TELA_LIBERACAO_SUPERV}     tela_LiberacaoSeparacao.png
${PROD_SEPARACAO_TUBAINA}    prod_TubainaCod7.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_NORMAL2}       7
# Botões
${BT_SELECIONA_ULTIMO}       bt_SeleUltimo.png
${MENU_PRÉVENDA}             menu_ClickPreVendas.png
${CAMPO_CODIGOSEPARACAO}     campo_CodigoSeparacao.png

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
    Sleep    ${SLEEP_MEDIO}
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

Quando insiro mais de um produto do tipo normal 
    FOR    ${I}    IN RANGE    2
        
        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END

        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.I 
        Sleep    ${SLEEP_BAIXO}

        Set Suite Variable    ${COD_PRODUTO}
        
    END

Quando finalizo o pedido - A vista
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
    Press Combination     KEY.ALT     Key.S

    ${Consulta}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_PEDIDO}    ${Consulta[0][0]}

E abro a separação e conferência
    SikuliLibrary.Click    ${MENU_PRÉVENDA}
    Wait Until Screen Contain    ${MENU_PRE_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    8

        Press Special Key    DOWN
        
    END

    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_SEPARACAO_CONFERE}    ${TEMPO_TELA}

Quando seleciono o último pedido
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    F1
    Wait Until Screen Contain    ${TELA_PESQUISA_PREVENDA}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${BT_SELECIONA_ULTIMO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_SEPARACAO_CONFERE}    ${TEMPO_TELA}

E informo o codigo dos produtos
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}
    Press Special Key    TAB

Então finalizo a separação
    Wait Until Screen Contain    ${TELA_INFO_ADICIONAIS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    
    FOR    ${I}    IN RANGE    3
        
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        
    END

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_SEPARACAO_CONFERE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S 

Quando finalizo a separação
    Wait Until Screen Contain    ${TELA_INFO_ADICIONAIS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    
    FOR    ${I}    IN RANGE    3
        
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        
    END

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_SEPARACAO_CONFERE}    ${TEMPO_TELA}

E recomeço a separação
    Quando seleciono o último pedido
    Wait Until Screen Contain    ${TELA_INFO_ADICIONAIS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r 
    Wait Until Screen Contain    ${AVISO_RECOMEÇAR_SEP}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_LIBERACAO_SUPERV}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER

E recomeço a separação - Item 
    Quando seleciono o último pedido
    Wait Until Screen Contain    ${TELA_INFO_ADICIONAIS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.e 
    Wait Until Screen Contain    ${AVISO_RECOMEÇAR_SEP}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_LIBERACAO_SUPERV}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER

Então finalizo a separação - 1 Produto
    Wait Until Screen Contain    ${TELA_1PROD_CONFERIDO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_AVISO_FECHAR}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

E informo o código dos produtos - Mais de um produto(${QTDE_PRODUTO})
    
    FOR    ${I}    IN RANGE    ${QTDE_PRODUTO}

        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END
        
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        
    END

Quando seleciono o produto e corto ele
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${PROD_SEPARACAO_TUBAINA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.t 
    Wait Until Screen Contain    ${TELA_LIBERACAO_SUPERV}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Quando corto os produtos restantes
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${TELA_LIBERACAO_SUPERV}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    
Quando pressiono o botão excluir
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.x 
    Wait Until Screen Contain    ${TELA_LIBERACAO_SUPERV}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Quando finalizo o pedido - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}