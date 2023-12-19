*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Variables    ../libs/leituraConfig.py

Resource    ../utils/utils.robot
Resource    ../utils/validacaoAviso.robot
Resource     ../utils/montadorDeCenarios.robot

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.220
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens
${TELA_GERACAO_VENDAS}                   tela_GeracaoVenda.png
${LABEL_PEDIDO}                          lb_Pedido.png
${GRID_LISTAGEM_PEDIDOS}                 grid_PedidosGeracaoVenda.png
${AVISO_DESEJA_GERAR_VENDA}              aviso_DesejaGerarVenda.png
${TELA_CARREGANDO_PEDIDOS}               tela_CarregandoPedidos.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de geração de vendas

    Type With Modifiers    G    CTRL
    Wait Until Screen Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando seleciono o ultimo pedido feito
    
    Press Combination    KEY.ALT     Key.L 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${TELA_CARREGANDO_PEDIDOS}     ${TEMPO_TELA}
    #Wait Until Screen Contain    ${GRID_LISTAGEM_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LABEL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LABEL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Pedido}

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

E clico em gerar
    
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}

Então confirmo a geração da venda 
    
    Wait Until Screen Contain    ${AVISO_DESEJA_GERAR_VENDA}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Finalização com recebimento de duplicatas(${TOTAL_PEDIDO}) 

            END

        END

    Sleep    ${SLEEP_BAIXO}

    Validação de geração de venda

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

Então confirmo a geração dos pedidos 
    
    Wait Until Screen Contain    ${AVISO_DESEJA_GERAR_VENDA}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    IF    ${EntradaIgualA_Outros}

        IF     ${Parametro_BaixaAutomatico}
                
            FOR    ${I}    IN RANGE    ${Quantidade_Pedidos_Feitos}
                    
                Recupera total do pedido(${I})

                Finalização com recebimento de duplicatas(${TOTAL_PEDIDO}) 

                Sleep    ${SLEEP_MEDIO}

            END

        END

    END

    Sleep    ${SLEEP_BAIXO}

    Validação da geração de venda de mais de um pedido 

Validação de geração de venda
    
    ${Codigo_Venda_Gerada}    Query    SELECT VendaGerada FROM pedidosvenda WHERE codigo = ${Codigo_Pedido};

    ${Produtos_Pedidos}    Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM pedidosvendaprodutos WHERE codigoPedido = ${Codigo_Pedido};

    ${Produtos_Vendas}     Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM vendasprodutos WHERE CodigoVenda = ${Codigo_Venda_Gerada[0][0]}

    ${Comparacao_Produtos} =     Run Keyword And Return Status     Should Be Equal    ${Produtos_Pedidos}    ${Produtos_Vendas}

    IF     ${Comparacao_Produtos}

        Log To Console    \nProdutos foram incluidos corretamenta na venda - Código do Pedido: ${Codigo_Pedido}

    ELSE

        Log To Console    \nProdutos *NÃO* foram incluidos corretamenta na venda, verifique! - Código do Pedido: ${Codigo_Pedido}

    END

    Set Test Variable    ${COD_VENDA}    ${Codigo_Venda_Gerada[0][0]}

E clico em visualizar 
    
    Press Special Key    UP

    @{RegiaoLeitura_CodigoPedido} =    Create List    540    311    49    22

    Press Combination    KEY.ALT     Key.V
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${CodigoPedido_Leitura} =     Read Text From Region    ${RegiaoLeitura_CodigoPedido}

    ${CodigoPedido_Visualizado} =     Convert To Integer    ${CodigoPedido_Leitura}

    Should Be Equal    ${CodigoPedido_Visualizado}    ${Codigo_Pedido}

Quando volto para a tela de geração de venda

    Press Special Key    ESC
    Wait Until Screen Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então verifico se o pedido retornou como aberto
    
    ${VendaGerada} =     Query    SELECT Gerado FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido}

    Should Be Equal    ${VendaGerada[0][0]}    ${0}

Quando seleciono os ultimos pedidos feitos 
    
    ${Quantidade_Pedidos_Feitos} =     Get Length    ${Codigos_Pedidos}
    Set Test Variable    ${Quantidade_Pedidos_Feitos}

    Press Combination    KEY.ALT     Key.L 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${TELA_CARREGANDO_PEDIDOS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LABEL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos_Feitos}

        Input Text    ${EMPTY}    ${Codigos_Pedidos[${I}]}

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE
        Sleep    ${SLEEP_BAIXO}
        
    END

Recupera total do pedido(${Contador})
    
    ${QUERY}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigos_Pedidos[${Contador}]};

    Set Test Variable    ${TOTAL_PEDIDO}    ${QUERY[0][0]}

    Sleep    ${SLEEP_BAIXO}

Validação da geração de venda de mais de um pedido 
    
    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos_Feitos}

        Set Test Variable    ${Codigo_Pedido}    ${Codigos_Pedidos[${I}]}

        Validação de geração de venda
        
    END