*** Settings ***
Resource    ../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ../KeyWords/Comercial/Devolucao/KeyDevolucaoVenda1.robot
Resource    ../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource    ../utils/utils.robot
Library    SikuliLibrary
Library    Collections

*** Variables ***

*** Keywords ***
Dado que realizo uma venda completa, com produto normal 
    
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.Exclui ordem de entrega(${COD_VENDA})
    
Dado que realizo um pedido, com produto normal
    
    KeyPedidos1.Dado que acesso a tela de pedidos
    KeyPedidos1.E clico em adicionar
    KeyPedidos1.Quando adiciono vendedor e cliente
    KeyPedidos1.E adiciono um produto
    KeyPedidos1.Quando vou para a aba de pagamentos
    KeyPedidos1.E audito o pedido 
    KeyPedidos1.Então finalizo o pedido 

Dado que realizo um pedido e gero uma venda total sobre ele 
    Dado que realizo um pedido, com produto normal
    KeyPedidos1.Quando clico em gerar venda
    KeyPedidos1.Então gero a venda totalmente

Dado que realizo um pedido e gero uma venda total sobre ele totalmente recebida 

    Dado que realizo um pedido e gero uma venda total sobre ele 
    
    Set Suite Variable    ${FORMA_PADRAO}    ${FORMA_PADRAO_PEDIDO}
    Set Test Variable    ${VALOR_FINAL_VENDA}    ${TOTAL_PEDIDO}

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto 
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.Então faço o recebimento da conta

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que realizo mais de um pedido(${Quantidade_Pedidos})
    
    ${Codigos_Pedidos} =    Create List
    ${Codigos_Produtos} =    Create List

    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos}
        
        Dado que realizo um pedido, com produto normal
        
        Append To List    ${Codigos_Pedidos}    ${Codigo_Pedido}
        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Log To Console    Pedidos Gerados: ${Codigos_Pedidos}

    Set Test Variable    ${Codigos_Pedidos}

    Log To Console    Produtos em pedidos Gerados: ${Codigos_Produtos}

    Set Test Variable    ${Codigos_Produtos}

Dado que realizo uma devolução qualquer

    KeyDevolucaoVenda1.Dado que abro a tela de Devolução de vendas/os 
    KeyDevolucaoVenda1.Quando adiciono uma nova devolução 
    KeyDevolucaoVenda1.E insiro os dados do cabeçalho - vendedor, venda|cliente 
    KeyDevolucaoVenda1.Quando seleciono um produto para a devolução
    KeyDevolucaoVenda1.E vou para a aba de pagamentos
    KeyDevolucaoVenda1.Então finalizo a devolução

Dado que realizo uma devolução avulsa 
    
    Dado que realizo uma venda completa, com produto normal 
    Dado que realizo uma devolução qualquer

Dado que realizo uma venda com mais de um produto(${Quantidade_Inserir})
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro mais de um produto normal(${Quantidade_Inserir})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.Exclui ordem de entrega(${COD_VENDA})

Dado que realizo uma devolução com mais de um produto(${Quantidade_Inserir})
    Dado que realizo uma venda com mais de um produto(${Quantidade_Inserir})
    KeyDevolucaoVenda1.Dado que abro a tela de Devolução de vendas/os 
    KeyDevolucaoVenda1.Quando adiciono uma nova devolução 
    KeyDevolucaoVenda1.E insiro os dados do cabeçalho - vendedor, venda|cliente 
    KeyDevolucaoVenda1.Quando seleciono os produtos para a devolução(${Quantidade_Inserir})
    KeyDevolucaoVenda1.E vou para a aba de pagamentos
    KeyDevolucaoVenda1.Então finalizo a devolução

Dado que realizo uma venda totalmente recebida(${Quantidade_Inserir})
    Dado que realizo uma venda com mais de um produto(${Quantidade_Inserir})
    
    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto 
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.Então faço o recebimento da conta

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Realizando venda com desconto ao finalizar(${desconto})
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - Desconto(${desconto})

Realizando vendas com o mesmo produto porém com descontos diferentes
    
    ${Codigo_Vendas} =     Create List
    ${Valor_Final_Vendas} =     Create List

    ${DESCONTOS_COMISSOES}    Pesquisa comissões por escalonamento
    Realizando venda com desconto ao finalizar(${DESCONTOS_COMISSOES[0][0]})

    Append To List    ${Codigo_Vendas}    ${COD_VENDA}
    Append To List    ${Valor_Final_Vendas}    ${VALOR_FINAL_VENDA}

    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto já definido(${COD_PRODUTO})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - Desconto(${DESCONTOS_COMISSOES[1][0]})

    Append To List    ${Codigo_Vendas}    ${COD_VENDA}
    Append To List    ${Valor_Final_Vendas}    ${VALOR_FINAL_VENDA}

    Set Test Variable    ${DESCONTOS_COMISSOES}
    Set Test Variable    ${Codigo_Vendas} 
    Set Test Variable    ${Valor_Final_Vendas}
