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
${TELA_SOLICI_SENHA_USER}    tela_SolicitacaoSenhaUsuario.png    
${TELA_GERACAO_PEDIDO}       tela_GeracaoPedido.png
${TELA_RECEB_DUPLICATAS}     tela_RecebimentoDuplicatas.png
${TELA_FROMA_PAGAMANTO}      tela_FormaPagamento.png
${TELA_IMPRESSAO}            tela_Impressao.png
${TELA_DESCONTO_EXCEDE}      aviso_DescontoExcede.png
${TELA_AVISOSEP_PRODLOTE}    aviso_ProdutoLoteSeparar.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_GRADE}         6
${COD_PRODUTO_SERIAL}        187
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_LOTE}          5
${COD_TRANSPORTADORA}        66
${COD_PRODUTO_NORMAL2}       7

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

E pressiono o botão de gerar venda
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_SOLICI_SENHA_USER}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_GERACAO_PEDIDO}    ${TEMPO_TELA}

Então finalizo o pedido - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então pressiono gerar total - A vista
    Press Combination    KEY.ALT     Key.T 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    4,08
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então pressiono gerar total
    Press Combination    KEY.ALT     Key.T 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    Recupera valor final dos pedidos - Venda Total

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

    ${Comparacao}    Verifica Valor Parcelas    Vendas    ${COD_VENDA}    ${VALOR_FINAL_PEDIDOS}

    Should Be Equal    ${Comparacao}    ${True}

Quando finalizo o pedido - Personalizado
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

Quando seleciono uma quantidade a gerar
    Wait Until Screen Contain    ${TELA_GERACAO_PEDIDO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

Então pressiono o botão parcialmete
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

    Recupera valor final dos pedidos

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

    ${Comparacao}    Verifica Valor Parcelas    Vendas    ${COD_VENDA}    ${VALOR_FINAL_PEDIDOS}

    Should Be Equal    ${Comparacao}    ${True}

Então pressiono o botão parcialmete - A vista
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    4,08
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Então pressiono o botão parcialmete - A vista(${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    4,08
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Então pressiono o botão parcialmete - Desconto Excedido(${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_DESCONTO_EXCEDE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    ESC
        Sleep    ${SLEEP_BAIXO}
    END

Quando seleciono uma quantidade a gerar - Grade
    Wait Until Screen Contain    ${TELA_GERACAO_PEDIDO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_SELEÇÃO_GRADE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.o 
    Sleep    ${SLEEP_BAIXO}

Quando finalizo o pedido - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então pressiono o botão parcialmete - Alterando valor final(${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

    ${ValorFinal}    Calcula valor final - com desconto(${DESCONTO})

    Input Text    ${EMPTY}    ${ValorFinal}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então pressiono o botão parcialmete - Alterando valor final - Desconto Excedido(${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO} 
    Wait Until Screen Contain    ${TELA_FROMA_PAGAMANTO}    ${TEMPO_TELA} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

    ${ValorFinal}    Calcula valor final - com desconto(${DESCONTO})

    Input Text    ${EMPTY}    ${ValorFinal}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_DESCONTO_EXCEDE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    ESC
        Sleep    ${SLEEP_BAIXO}
    END

Então pressiono o botão de gerar venda - Produto lote
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISOSEP_PRODLOTE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

# ---------------------------------------------------------------------------------------------------------------------------- #
Calcula valor final - com desconto(${DESCONTO})
    ${desc}    Convert To Number    ${DESCONTO}
    ${valorFinal}    Evaluate    4.08 - (4.08 * (${desc} / 100))

    RETURN    ${valorFinal}

#***---Função para calcular total dos orçamentos na venda agrupada---***#
Recupera valor final dos pedidos - Venda Total
    ${VALOR_FINAL_PEDIDOS}    Query    SELECT ValorFinalPagamentos FROM pedidosvenda WHERE `Data` = CURDATE() ORDER BY Codigo DESC LIMIT 1
    
    Set Suite Variable    ${VALOR_FINAL_PEDIDOS}    ${VALOR_FINAL_PEDIDOS[0][0]}

Recupera valor final dos pedidos
    ${VALOR_FINAL_PEDIDOS}    Query    SELECT pvp.ValorTotal FROM pedidosvendaprodutos AS pvp INNER JOIN pedidosvenda AS pv ON (SELECT Codigo FROM pedidosvenda WHERE `Data` = CURDATE() ORDER BY Codigo DESC LIMIT 1) = pvp.CodigoPedido ORDER BY pvp.CodigoProduto ASC LIMIT 1

    Set Suite Variable    ${VALOR_FINAL_PEDIDOS}    ${VALOR_FINAL_PEDIDOS[0][0]}