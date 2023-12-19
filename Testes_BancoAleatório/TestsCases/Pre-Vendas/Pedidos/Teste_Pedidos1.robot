*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource     ../KeyWords/Comercial/Vendas/keyVendas1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyPedidos1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Pedido
    [Tags]    Teste01
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 

Teste 02 - Adicionando Pedido e visualizando
    [Tags]    Teste02
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 
    Então visualizo o pedido feito

Teste 03 - Adicionando Pedido e editando
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

Teste 04 - Adicionando Pedido e excluindo
    [Tags]    Teste04
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 
    Então excluo o pedido

Teste 05 - Gerando venda total de um pedido
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

Teste 06 - Gerando venda Parcial de um pedido
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

Teste 07 - Excluindo venda gerada através do pedidos
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
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Então clico em excluir
    Então verifico se o pedido retornou corretamente

Teste 08 - Cancelando a geração de venda
    [Tags]    Teste07
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