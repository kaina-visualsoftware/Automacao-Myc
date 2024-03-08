*** Settings ***
Documentation    Testes Pedidos pré-venda

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    C://Automacao//automacao-mycommerce//Automação_Antiga//MyCommerce//libs//verificaProduto.py 

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
${TELA_SELEÇÃO_LOTE}         tela_SelecaoLoteSeparacao.png
${TELA_SERIAL_SELECAO}       tela_controleSerialSelecao.png
${TELA_SERIAL_DIGITACAO}     tela_controleSerialDigitacao.png
${TELA_SELEÇÃO_GRADE}        tela_SelecaoGrade.png
${TELA_1PROD_CONFERIDO}      tela_SeparacaoConferencia-1ProdutoConferido.png
${TELA_AVISO_FECHAR}         aviso_DesejaFechar.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_GRADE}         6
${COD_PRODUTO_SERIAL}        188
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_NORMAL2}       7
# Botões
${BT_SELECIONA_ULTIMO}       bt_SeleUltimo.png
${MENU_PRÉVENDA}             menu_ClickPreVendas.png
${CHECKBOX_MARCADO}          checkBox_Marcado.png
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

Quando finalizo o pedido - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}



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

E informo o codigo dos produtos - Lote Seleção(${VALOR_VERIFICACAO})
    Verifica Campo Baixar Lote Mais Velho(${VALOR_VERIFICACAO})
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}
    Press Special Key    TAB

    IF    ${VALOR_VERIFICACAO} == 0
        
        Wait Until Screen Contain    ${TELA_SELEÇÃO_LOTE}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

    END

E informo o codigo dos produtos - Serial
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}
    Press Special Key    TAB
    Wait Until Screen Contain    ${TELA_SERIAL_SELECAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${TELA_SELECAO} =    Exists    ${TELA_SERIAL_SELECAO}
    ${TELA_DIGITACAO} =    Exists    ${TELA_SERIAL_DIGITACAO} 

    IF    ${TELA_SELECAO} == ${True}
        Press Special Key    SPACE
    ELSE
        @{SELECAO} =    Create List    838    302    11    11
        Click Region    ${SELECAO}
        Wait Until Screen Contain    ${TELA_SERIAL_DIGITACAO}    10
        Press Special Key    SPACE
    END

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    Key.F 
        Sleep    ${SLEEP_BAIXO}

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
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Então finalizo a separação - 1 Produto
    Wait Until Screen Contain    ${TELA_1PROD_CONFERIDO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_AVISO_FECHAR}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

Então finalizo a separação - Lote(${VALOR_VERIFICACAO})
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
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

    Verifica lote baixado(${VALOR_VERIFICACAO})

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

E informo o codigo dos produtos - Grade
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_GRADE}
    Press Special Key    TAB
    Wait Until Screen Contain    ${TELA_SELEÇÃO_GRADE}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.o

E informo o código dos produtos - Mais de um produto(${QTDE_PRODUTO})
    
    FOR    ${I}    IN RANGE    ${QTDE_PRODUTO}

        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END
        
        Input Text    ${EMPTY}    ${COD_PRODUTO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        
    END

#--------------------------------------------------------------------------------------------------------#
Verifica Campo Baixar Lote Mais Velho(${VALIDAÇÃO})
    Sleep    ${SLEEP_BAIXO}

    ${coor_BaixarLote}    Create List    1052    771    36    13
    
    IF    ${VALIDAÇÃO} == 0

        Sleep    ${SLEEP_BAIXO}
        ${campo}    Exists    ${CHECKBOX_MARCADO}

        IF    ${campo} == ${True}

            SikuliLibrary.Click On Region    ${coor_BaixarLote}
            Sleep    ${SLEEP_BAIXO}
            SikuliLibrary.Click    ${CAMPO_CODIGOSEPARACAO}

        END
        
    ELSE
    
        Sleep    ${SLEEP_BAIXO}
        ${campo}    Exists    ${CHECKBOX_MARCADO}

        IF    ${campo} == ${False}

            SikuliLibrary.Click On Region    ${coor_BaixarLote}
            Sleep    ${SLEEP_BAIXO}
            SikuliLibrary.Click    ${CAMPO_CODIGOSEPARACAO}

        END

    END

Verifica lote baixado(${TIPO_BAIXA})
    Sleep    ${SLEEP_BAIXO}

    IF    ${TIPO_BAIXA} == 0
        
        ${COD_LOTE}    Convert To Number    2

        ${CODIGO_LOTE}    Query    SELECT CodigoLote FROM pedidosvendaprodutoslotes WHERE IDPedido = ${COD_PEDIDO};
        Sleep    ${SLEEP_BAIXO}
        Should Be Equal    ${CODIGO_LOTE[0][0]}    ${COD_LOTE}

    ELSE
        
        ${CODIGO_LOTE}    Query    SELECT Sequencia FROM produtos_lotes WHERE DataFabricacao IS NOT NULL ORDER BY DataFabricacao ASC LIMIT 1;
        ${LOTE_SEPARADO}    Query    SELECT CodigoLote FROM pedidosvendaprodutoslotes WHERE IDPedido = ${COD_PEDIDO};
        Sleep    ${SLEEP_BAIXO}
        Should Be Equal    ${CODIGO_LOTE}    ${LOTE_SEPARADO}

    END

    Sleep    ${SLEEP_BAIXO}