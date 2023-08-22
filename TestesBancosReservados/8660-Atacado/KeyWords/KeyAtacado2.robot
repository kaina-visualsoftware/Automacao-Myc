*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary

*** Variables ***
${IMAGES}                    ./TestesBancosReservados/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    8660
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${TELA_PEDIDOS_PREVENDA}     tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}    tela_PedidosAdicionar.png
${AVISO_CLIENTE_OUTRO_VE}    aviso_AlterarVendedor_Pedidos.png  
${ROW_PROD_INCLUSO}          row_ProdIncluso.png
${AVISO_SEM_ESTOQUE}         aviso_QuantidadeSemEstoque.png
${TELA_INFO_CRÉDITOS}        tela_InfoCreditos.png  
${ALERTA_CLIENTE}            alertaCliente.png
${INPUT_COD_CLIENTE}         lb_CodClientePedido.png
${BT_EXCLUIR_DESCONTO}       bt_ExcluirDesconto.png
${AVISO_EXCLUIR_DESCONTO}    aviso_ExcluirDesconto.png
${TELA_IMPORTAR_PEDIDOS}     tela_importarPedidos.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de pedidos

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}

E adiciono um novo pedido

    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_PEDIDO}    ${Consulta[0][0]}

E adiciono vendedor e cliente

    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE Tipo LIKE 'D' OR Tipo LIKE 'V' AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${INPUT_COD_CLIENTE}
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codCliente[0][0]}
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    
    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_BAIXO}

    Valida informações de crédito
    Sleep    ${SLEEP_BAIXO}

Quando insiro um produto normal

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Recupera valor dos produtos 

Quando insiro um produto com desconto(${DESCONTO})

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE (ModalidadeControle = 'Normal' AND Cancelado IS NULL) AND (Ativo = -1 AND DescontoMaximo > ${DESCONTO}) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END
    
    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END
    
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.A 

    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${DESCONTO}    ${DESCONTO}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Recupera valor dos produtos 

E edito o último pedido
    Press Combination    KEY.ALT     Key.E 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

Quando removo o desconto pelo botão X
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_EXCLUIR_DESCONTO}
    Wait Until Screen Contain    ${AVISO_EXCLUIR_DESCONTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Verifica valor final ao remover desconto

Então finalizo o pedido
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}

Quando pressiono CRTL + I para importar um pedido
    
    Press Combination    KEY.CTRL     Key.I 
    Wait Until Screen Contain    ${TELA_IMPORTAR_PEDIDOS}    ${TEMPO_TELA}

E importo o pedido "${Cod_Pedido_Importar}"
    
    Input Text    ${EMPTY}    ${Cod_Pedido_Importar}
    Press Special Key    TAB
    Press Combination    KEY.ALT     KEY.I 
    Sleep    ${SLEEP_MEDIO}
    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_ALTO}
    Valida quantidade de estoque inexistente

Então cancelo o pedido
    
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

#-----------------------------------------------------------------------------------------------------------------#
Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida quantidade de estoque inexistente

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida alerta após inserir cliente 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${ALERTA_CLIENTE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.O
        Sleep    ${SLEEP_MEDIO}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Recupera valor dos produtos 

    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} AND Cancelada IS NULL
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

Verifica valor final ao remover desconto 
    
    Sleep    ${SLEEP_BAIXO}
    ${ValorValidacao}    Query    SELECT VendaT1 FROM produtos WHERE Codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Recupera valor dos produtos 

    Should Be Equal    ${ValorValidacao[0][0]}    ${ValorProduto}