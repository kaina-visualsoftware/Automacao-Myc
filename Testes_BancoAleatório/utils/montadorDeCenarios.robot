*** Settings ***
Resource    ../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ../utils/utils.robot
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

Dado que realizo mais de um pedido(${Quantidade_Pedidos})
    
    ${Codigos_Pedidos} =    Create List

    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos}
        
        Dado que realizo um pedido, com produto normal
        
        Append To List    ${Codigos_Pedidos}    ${Codigo_Pedido}

    END

    Log To Console    Pedidos Gerados: ${Codigos_Pedidos}

    Set Test Variable    ${Codigos_Pedidos}