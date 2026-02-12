*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/montadorDeCenarios.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                          ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                           ${config.IpServidor}
${DBName}                           ${config.Database}
${DBPass}                           vssql
${DBPort}                           ${config.Porta}
${DBUser}                           root

# Sleep's
${SLEEP_BAIXO}                      0.7
${SLEEP_MEDIO}                      1.5
${SLEEP_ALTO}                       3
${TEMPO_TELA}                       20

# Telas
${TELA_GERACAO_VENDAS}              tela_GeracaoVenda.png
${TELA_CARREGANDO_PEDIDOS}          tela_CarregandoPedidos.png

# Telas Avisos
${AVISO_DESEJA_GERAR_VENDA}         aviso_DesejaGerarVenda.png

# Botões
${BT_SAIR_CTRLG}                    bt_SairCTRLG.png

# Labels
${LABEL_PEDIDO}                     lb_Pedido.png
${LABEL_GERANDO_CONTA_A_RECEBER}    lb_GerandoContasAReceber.png

# Outros
${GRID_LISTAGEM_PEDIDOS}            grid_PedidosGeracaoVenda.png
# ${QTDE_BAIXA_PRODUTO}               ${1}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de geração de vendas
    
    Sleep    ${SLEEP_BAIXO}
    Type With Modifiers    G    CTRL
    Wait Until Screen Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Quando seleciono o último pedido feito
    
    Press Combination    KEY.ALT    KEY.L
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_ALTO}
    SikuliLibrary.Click    ${LABEL_PEDIDO}

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LABEL_PEDIDO}

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Pedido}

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

E clico em gerar
    
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

Então confirmo a geração da venda
    
    Wait Until Screen Contain    ${AVISO_DESEJA_GERAR_VENDA}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    IF    ${EntradaIgualA_Outros}

        IF     ${Parametro_BaixaAutomatico}
            
            Finalização com recebimento de duplicatas(${TOTAL_PEDIDO}) 

        END

    END

    Wait Until Screen Not Contain    ${LABEL_GERANDO_CONTA_A_RECEBER}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento em fins de semana e feriados(1)

    KeyGeracaoDeVenda1.Validação de geração de venda

    utils.Valida tela de transportadora/faturamento nota fiscal

    SikuliLibrary.Click    ${BT_SAIR_CTRLG}
    Sleep    ${SLEEP_BAIXO}

Então confirmo a geração dos pedidos
    
    Wait Until Screen Contain    ${AVISO_DESEJA_GERAR_VENDA}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT    KEY.S
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
    
    Valida vencimento em fins de semana e feriados(${Quantidade_Pedidos_Feitos})
    
    KeyGeracaoDeVenda1.Validação da geração de venda de mais de um pedido

    utils.Valida tela de transportadora/faturamento nota fiscal

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

Validação de geração de venda
    
    Sleep    ${SLEEP_ALTO}

    ${Codigo_Venda_Gerada}    Query    SELECT VendaGerada FROM pedidosvenda WHERE codigo = ${Codigo_Pedido};

    ${Produtos_Pedidos}    Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM pedidosvendaprodutos WHERE codigoPedido = ${Codigo_Pedido};

    ${Produtos_Vendas}    Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM vendasprodutos WHERE CodigoVenda = ${Codigo_Venda_Gerada[0][0]}

    ${Comparacao_Produtos}    Should Be Equal    ${Produtos_Pedidos}    ${Produtos_Vendas}

    Set Test Variable    ${COD_VENDA}    ${Codigo_Venda_Gerada[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    KeyGeracaoDeVenda1.Valida baixa de estoque

Valida baixa de estoque

    IF    ${Parametro_BaixaEstoquePreVenda}

        ${COD_OPERACAO}    Set Variable    ${Codigo_Pedido}

    ELSE

        ${COD_OPERACAO}    	Set Variable    ${COD_VENDA}

    END

    Sleep    ${SLEEP_MEDIO}

    ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_OPERACAO}    ${QTDE_BAIXA_PRODUTO}

    Should Be Equal    ${Baixa_De_Estoque}    ${True}

    IF    ${Baixa_De_Estoque}
        
        Log To Console    Baixou estoque corretamente na geração da venda do pedido!

    ELSE

        Log To Console    Falha na baixa do estoque! Verifique!

    END

E clico em visualizar

    Press Combination    KEY.ALT    KEY.V
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Quando volto para a tela de geração de venda

    Press Special Key    ESC
    Wait Until Screen Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então verifico se o pedido retornou como aberto
    
    ${VendaGerada}    Query    SELECT Gerado FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido}

    Should Be Equal    ${VendaGerada[0][0]}    ${0}

Quando seleciono os ultimos pedidos feitos
    
    ${Quantidade_Pedidos_Feitos}    Get Length    ${Codigos_Pedidos}

    Set Test Variable    ${Quantidade_Pedidos_Feitos}

    Press Combination    KEY.ALT    KEY.L
    Wait Until Screen Not Contain    ${TELA_CARREGANDO_PEDIDOS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LABEL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos_Feitos}

        Input Text    ${EMPTY}    ${Codigos_Pedidos[${I}]}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    SPACE
        Sleep    ${SLEEP_MEDIO}
        
    END

Recupera total do pedido(${Contador})
    
    ${QUERY}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigos_Pedidos[${Contador}]};

    Set Test Variable    ${TOTAL_PEDIDO}    ${QUERY[0][0]}

    Sleep    ${SLEEP_BAIXO}

Validação da geração de venda de mais de um pedido
    
    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos_Feitos}
        
        Sleep    ${SLEEP_BAIXO}

        Set Test Variable    ${Codigo_Pedido}    ${Codigos_Pedidos[${I}]}

        Set Test Variable    ${COD_PRODUTO}    ${Codigos_Produtos[${I}]}

        Sleep    ${SLEEP_BAIXO}

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Pedido}
        
        Sleep    ${SLEEP_BAIXO}

        KeyGeracaoDeVenda1.Validação de geração de venda
        
    END