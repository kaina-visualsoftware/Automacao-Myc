*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    ../libs/verificacoesExtras.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot

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
#Imagens Telas
${TELA_PEDIDOS}                          tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}                tela_PedidosAdicionar.png
${TELA_PEDIDO_AUDITADO}                  tela_PedidoAuditado.png  
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de pedidos

    ${FORMA_PADRAO_PEDIDO}    Valida Forma Parcelamento    Pedido
    
    Verifica parametros que interferem na venda

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_PEDIDO}

E clico em adicionar
    
    Press Combination    KEY.ALT     Key.A
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${QUERY}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${Codigo_Pedido}     ${QUERY[0][0]}

Quando adiciono vendedor e cliente 
    
    utils.Adicionar Vendedor e Cliente(Pedido)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E adiciono um produto

    IF     ${Parametro_RealizaPreVendaSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE
        
        utils.Inserir Produto normal - Necessita de estoque

    END

    utils.Valida parametros após incluir produto

    ${QUERY}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigo_Pedido};

    Set Test Variable    ${TOTAL_PEDIDO}    ${QUERY[0][0]}

Quando vou para a aba de pagamentos 
    
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_MEDIO}

E audito o pedido 
    
    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_PEDIDO_AUDITADO}    ${TEMPO_TELA}

Então finalizo o pedido 
    
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    #Verifica se valor minimo da forma é maior que total do pedido
    IF    ${FORMA_PADRAO_PEDIDO[2]} > ${TOTAL_PEDIDO}

        Valida tela de liberação de desconto

    END

Então visualizo o pedido feito
    
    Press Combination    KEY.ALT     Key.V
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C

Quando finalizo o pedido sem auditar
    
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

E pressiono o atalho de editar
    
    Press Combination    KEY.ALT     Key.E
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então excluo o pedido
    
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.X
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Exclusao de Pedido - Teste Automacao
    Press Special Key    TAB
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    
    Check If Exists In Database    SELECT * FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido} AND `Status` LIKE 'x'
