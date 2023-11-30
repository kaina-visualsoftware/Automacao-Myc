*** Settings ***
Documentation    Testes Ordem de Serviço

Resource    ../KeyWords/KeyOrdemServico2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        188

*** Test Cases ***
Teste 01 - Gerando OS com apenas 1 serviço - 5% de desconto
    [Tags]    Teste01   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços(5)
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS - Somente serviço

Teste 02 - Gerando OS com apenas 1 serviço - 10% de desconto - Ultrapassando do limite
    [Tags]    Teste02   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços - Ultrapassa o limite(10)
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS - Somente serviço

Teste 03 - Gerando OS com 1 serviço e 1 produto - 5% de desconto
    [Tags]    Teste03   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços(5)
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 5)
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - A vista

Teste 04 - Gerando OS com 1 produto - 10% de desconto
    [Tags]    Teste04   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 10)
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - A vista

Teste 05 - Gerando OS com 1 produto - 20% de desconto - Ultrapassando limite de desconto
    [Tags]    Teste05   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto - Ultrapassando Desconto Máximo(${COD_PRODUTO_NORMAL} 20)
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - A vista

Teste 06 - Gerando OS com 1 produto - 99% de desconto - Ultrapassando limite de desconto
    [Tags]    Teste06   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto - Ultrapassando Desconto Máximo(${COD_PRODUTO_NORMAL} 99)
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - A vista

Teste 07 - Gerando OS com mais de 1 produto - 5% de desconto 
    [Tags]    Teste07  
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro mais de um produto normal(5)
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - A vista
    
Teste 08 - Gerando OS com produto Grade - 5% de Desconto 
    [Tags]    Teste08
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto do tipo grade(5)
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS - Personalizada / 30 Dias

Teste 09 - Gerando OS com produto normal - 5% de Acrescimo
    [Tags]    Teste09
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 5)
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS - Personalizada / 30 Dias

Teste 10 - Gerando OS com produto normal - 20% de Acrescimo
    [Tags]    Teste10
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 20)
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS - Personalizada / 30 Dias

Teste 11 - Gerando OS com produto normal - 1000000% de Acrescimo
    [Tags]    Teste11
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 1000000)
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS - Personalizada / 30 Dias

Teste 12 - Gerando OS com apenas 1 serviço - 500 de valor unitário
    [Tags]    Teste12   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços - Acrescimo(500)
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS - Somente serviço   
