*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Comercial/Devolucao/KeyDevolucaoVenda1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyDevolucaoVenda1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

*** Test Cases ***
Teste 01 - Adicionando uma nova Devolução de venda
    [Tags]    Teste01

    Dado que abro a tela de Devolução de vendas/os
    Quando adiciono uma nova devolução
    E insiro os dados do cabeçalho - vendedor, venda|cliente(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução

Teste 02 - Adicionando uma nova Devolução de venda - Visualizar
    [Tags]    Teste02

    Dado que abro a tela de Devolução de vendas/os
    Quando adiciono uma nova devolução
    E insiro os dados do cabeçalho - vendedor, venda|cliente(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução
    Então visualizo a devolução

#O teste de edição só funciona se os parametros de Dev. Avulsa e permite aberta estiverem habilitados!
Teste 03 - Adicionando uma nova Devolução de venda - Editando
    [Tags]    Teste03

    Dado que abro a tela de Devolução de vendas/os
    Quando adiciono uma nova devolução
    E insiro os dados do cabeçalho - vendedor, venda|cliente(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Quando finalizo a devolução como aberta
    E edito a devolução
    Quando insiro um produto para a troca
    Então finalizo a devolução após a edição

Teste 04 - Adicionando uma nova Devolução de venda - Excluindo 
    [Tags]    Teste04

    Dado que abro a tela de Devolução de vendas/os
    Quando adiciono uma nova devolução
    E insiro os dados do cabeçalho - vendedor, venda|cliente(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução
    Então excluo a devolução

Teste 05 - Adicionando uma devolução de venda com mais de um produto
    [Tags]    Teste05
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com mais de um produto(2)
    
    Dado que abro a tela de Devolução de vendas/os
    Quando adiciono uma nova devolução
    E insiro os dados do cabeçalho - vendedor, venda|cliente(Devolução)
    Quando seleciono os produtos para a devolução(2)
    E vou para a aba de pagamentos
    Então finalizo a devolução