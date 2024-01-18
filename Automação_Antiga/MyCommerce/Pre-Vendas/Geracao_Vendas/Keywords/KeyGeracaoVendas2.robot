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
${TELA_GERACAO_VENDA}        tela_GeracaoVenda.png
${TELA_AVISO_GERAR_VENDA}    aviso_DesejaVenda.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${AVISO_DESC_SUPERIOR}       aviso_DescontoExcede_GeracaoVenda.png
${TELA_AGRUPAMENTO_VENDA}    tela_AgrupamentoVenda.png
${TELA_FORMA_PAGAMENTOS}     tela_FormaPagamento.png
${TELA_IMPRESSAO}            tela_Impressao.png
${TELA_VENDA_IMPRESSA}       tela_VendaImpressa.png
${TELA_FATURAMENTO_NOTA}     tela_FaturamentoNota.png
${TELA_NOTA_FATURADA}        tela_NotaFaturada.png
#Botões
${CHECK_PEDIDOSEPARADOS}     checkBox_PedidosSeparados.png
${COL_PEDIDO}                col_Pedido.png
${CHECK_GERAR_ENTREGUE}      checkBox_GerarComoEntregue.png
${CHECK_GERAR_AGRUPADO}      checkBox_GerarAgrupadoCliente.png
${CHECK_IMPRIMIR_VENDA}      checkBox_ImprimirVendas.png
${CAMPO_FORMA_PAGAMENTO}     campo_FormaPag.png
${BT_MAIS_OPCOES}            bt_MaisOpcoes.png
${BT_GERAR_VENDA_AGRUP}      bt_GerarVenda.png
${CHECK_IMPRIMIR_BOLETOS}    checkBox_ImprimirBoletos.png
${COMBOX_FATURAR_VENDAS}     combo_FaturarVendas.png
${BT_FECHAR_FATURAMENTO}     bt_Fechar.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de geração de vendas 
    Sleep    ${SLEEP_BAIXO}
    Type With Modifiers    G     CTRL
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_GERACAO_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.L 
    Sleep    ${SLEEP_BAIXO}

    Ordena do último para o primeiro

E seleciono um pedido
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE 
    Sleep    ${SLEEP_BAIXO}

    Recupera código pedido

E seleciono um pedido - Imprimir boletos
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE 
    Sleep    ${SLEEP_BAIXO}

    Recupera código pedido

    SikuliLibrary.Click    ${CHECK_GERAR_ENTREGUE}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_IMPRIMIR_VENDA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_IMPRIMIR_BOLETOS}
    Sleep    ${SLEEP_BAIXO}

E seleciono mais de um pedido
    
    FOR    ${I}    IN RANGE    2
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE 
        Sleep    ${SLEEP_BAIXO}
        
    END

Quando clico em gerar - A vista - Venda como Entregue
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_GERAR_ENTREGUE}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando clico em gerar - A vista
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então finalizo a venda - A vista - Venda como Entregue
    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}

    Verifica gerou ordem de entrega 

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Então finalizo a venda - A vista
    Recupera valor do pedido
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${VALOR_FINAL}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Então finalizo as vendas

    FOR    ${I}    IN RANGE    2
        
        Recupera valores dos pedidos
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${VALOR_FINAL}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.C 
        Sleep    ${SLEEP_MEDIO}

        
    END

    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Quando clico em gerar - A vista - Venda agrupada
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_GERAR_AGRUPADO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_AGRUPAMENTO_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CAMPO_FORMA_PAGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_MAIS_OPCOES}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_FORMA_PAGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_GERAR_VENDA_AGRUP}

Quando clico em gerar - A vista - Imprimindo venda
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${CHECK_IMPRIMIR_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então finalizo a venda - A vista - Imprimindo Venda
    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_VENDA_IMPRESSA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Então finalizo as vendas - Faturando Venda
    Sleep    ${SLEEP_MEDIO}
    ${NOTA_DESATIVADA} =       Exists    ${COMBOX_FATURAR_VENDAS}

    IF    ${NOTA_DESATIVADA} == ${True}

        SikuliLibrary.Click    ${COMBOX_FATURAR_VENDAS}
        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}

    END

    Quando clico em gerar - A vista
    
    Sleep    ${SLEEP_MEDIO}

    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_FATURAMENTO_NOTA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_NOTA_FATURADA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_FECHAR_FATURAMENTO}
    Wait Until Screen Contain    ${TELA_GERACAO_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_#
Ordena do último para o primeiro
    SikuliLibrary.Click    ${COL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${COL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

Recupera código pedido
    ${consulta}    Query    SELECT Codigo FROM pedidosvenda WHERE Separado = 1 AND VendaGerada IS NULL ORDER BY Codigo DESC LIMIT 1
    
    Set Test Variable    ${COD_PEDIDO}    ${consulta[0][0]}

Verifica gerou ordem de entrega 
    ${consulta}    Query    SELECT ID FROM entregas WHERE CodigoVenda = (SELECT Codigo FROM vendas AS v ORDER BY Codigo DESC LIMIT 1);

    Should Not Be Equal    ${consulta[0][0]}    ${null}

Recupera valor do pedido
    ${consulta}    Query    SELECT TotalPedido FROM pedidosvenda WHERE Codigo = ${COD_PEDIDO}

    Set Test Variable    ${VALOR_FINAL}    ${consulta[0][0]}

Ajusta foco do MyCommerce
    #Por algum motivo que não sei, ao clicar no alt + s o sistema perde o foco, então aqui ele vai retornar o foco pro mycommerce
    @{LOCAL_TELA} =    Create List    838    302    11    11
    Click Region    ${LOCAL_TELA}

Recupera valores dos pedidos 
    ${consulta}    Query    SELECT TotalPedido FROM vendas AS v ORDER BY Codigo DESC LIMIT 1

    Set Test Variable    ${VALOR_FINAL}    ${consulta[0][0]}