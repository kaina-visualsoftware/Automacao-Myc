*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/KeyCondicional1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

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
    Quando clico em editar
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