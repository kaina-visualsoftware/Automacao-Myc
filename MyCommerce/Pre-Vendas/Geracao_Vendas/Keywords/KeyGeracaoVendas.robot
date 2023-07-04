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
#Botões
${CHECK_PEDIDOSEPARADOS}     checkBox_PedidosSeparados.png
${COL_PEDIDO}                col_Pedido.png

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

Quando clico em gerar - A vista
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então gero a venda - 30 Dias 
    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Verifica a venda finalizada - 30 dias

    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Então finalizo a venda - A vista
    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}

    Verifica venda finalizada

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Então finalizo a venda - A vista(${DESCONTO})
    Recupera valor do pedido
    
    #Solução momentanea até ajustar o foco
    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}

    ${ValorDuplicata}    Calcula valor com desconto(${DESCONTO})

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${ValorDuplicata}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}

    Verifica venda finalizada

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S  
    Ajusta foco do MyCommerce

Quando informo um desconto acima do previsto(${DESCONTO})
    #Solução momentanea até ajustar o foco
    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    
    #É um bug ser exibido 2 vezes, isso é por enquanto
    FOR    ${I}    IN RANGE    2
        
        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${AVISO_DESC_SUPERIOR}    ${SLEEP_ALTO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        
    END
    
    Press Special Key    UP
    
Então finalizo a venda - A vista - Valor Superior
    Recupera valor do pedido
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    200
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}

    Verifica venda finalizada

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

Recupera valor do pedido
    ${consulta}    Query    SELECT TotalPedido FROM pedidosvenda WHERE Codigo = ${COD_PEDIDO}

    Set Test Variable    ${VALOR_FINAL}    ${consulta[0][0]}

Verifica venda finalizada
    ${consulta}    Query    SELECT TotalPedido FROM vendas WHERE NPedido = ${COD_PEDIDO} AND `Status` LIKE 'f'
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${VALOR_FINAL}    ${consulta[0][0]}

Verifica a venda finalizada - 30 dias 
    ${Consulta}    Query    SELECT TotalPedido, formaparcelamento FROM vendas WHERE NPedido = ${COD_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    
    Should Be Equal    ${Consulta[0][0]}    ${VALOR_FINAL}
    Should Be Equal    ${Consulta[0][1]}    002 - 30 DIAS

Ajusta foco do MyCommerce
    #Por algum motivo que não sei, ao clicar no alt + s o sistema perde o foco, então aqui ele vai retornar o foco pro mycommerce
    @{LOCAL_TELA} =    Create List    838    302    11    11
    Click Region    ${LOCAL_TELA}

Calcula valor com desconto(${DESCONTO})
    ${desc}    Convert To Number    ${DESCONTO}
    ${VALOR_FINAL}    Convert To Number    ${VALOR_FINAL}

    ${valorFinal}    Evaluate    ${VALOR_FINAL} - (${VALOR_FINAL} * (${desc} / 100))
    
    ${valorFinal}    Evaluate    round(${valorFinal}, 2)

    Set Test Variable    ${VALOR_FINAL}    ${valorFinal}

    RETURN    ${valorFinal}