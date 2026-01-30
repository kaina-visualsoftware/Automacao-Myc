*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyPedidos1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Lançamento de pedido
    [Tags]    Teste01

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

Teste 02 - Lançamento e visualização de pedido
    [Tags]    Teste02

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Então visualizo o pedido
    E saio da tela(Pedido)

Teste 03 - Lançamento e edição de pedido
    [Tags]    Teste03

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    Quando finalizo o pedido sem auditar
    E pressiono o atalho de editar
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

Teste 04 - Lançamento e exclusão de pedido
    [Tags]    Teste04

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Então excluo o pedido
    E saio da tela(Pedido)

Teste 05 - Geração de venda total de pedido
    [Tags]    Teste05

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Quando clico em gerar venda
    Então gero a venda totalmente
    E saio da tela(Pedido)

Teste 06 - Geração de venda parcial de pedido
    [Tags]    Teste06

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Quando clico em gerar venda
    Quando seleciono um produto para a geração da venda
    Então gero a venda parcialmente do produto selecionado
    E saio da tela(Pedido)

Teste 07 – Exclusão de venda gerada a partir de pedido
    [Tags]    Teste07

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Quando clico em gerar venda
    Então gero a venda totalmente
    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Então clico em excluir
    E saio da tela(Venda)
    Então verifico se o pedido retornou corretamente

Teste 08 – Cancelamento da geração de venda a partir do pedido
    [Tags]    Teste08

    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    Quando clico em gerar venda
    Quando seleciono um produto para a geração da venda
    E clico em salvar
    Então cancelo a geração da venda
    E saio da tela(Pedido)