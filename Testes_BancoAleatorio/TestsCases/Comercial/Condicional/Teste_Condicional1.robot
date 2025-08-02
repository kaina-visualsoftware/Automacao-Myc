*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Condicional/KeyCondicional1.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyCondicional1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando nova Condicional
    [Tags]    Teste01

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional

Teste 02 - Adicionando nova Condicional e visualizando
    [Tags]    Teste02

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional
    Então visualizo a condicional

Teste 03 - Adicionando nova Condicional e editando
    [Tags]    Teste03

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional
    KeyCondicional1.Quando clico em editar
    E insiro um produto normal
    Então finalizo a condicional

Teste 04 - Adicionando nova Condicional e Excluindo
    [Tags]    Teste04

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional
    Então excluo a condicional

Teste 05 - Gerando venda total de uma condicional
    [Tags]    Teste05

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional
    Quando clico em gerar venda
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    Validação de vendas após a geração do condicional

Teste 06 - Gerando venda Parcial de uma condicional
    [Tags]    Teste06

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(3)
    Então finalizo a condicional
    Quando cliclo em gerar venda parcial
    E gero a venda de parte dos produtos(2)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda

Teste 07 - Cancelando a venda total de uma condicional
    [Tags]    Teste07

    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro um produto normal
    Então finalizo a condicional
    Quando clico em gerar venda
    Então cancelo a geração da venda

Teste 08 - Cancelando venda Parcial de uma condicional
    [Tags]    Teste08
    
    Dado que acesso a tela de condicionais
    E adiciono uma nova Condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(3)
    Então finalizo a condicional
    Quando cliclo em gerar venda parcial
    E gero a venda de parte dos produtos(2)
    Então cancelo a geração da venda