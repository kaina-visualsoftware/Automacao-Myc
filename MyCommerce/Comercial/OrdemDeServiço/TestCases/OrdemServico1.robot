*** Settings ***
Documentation    Testes Separação e Conferencia - Extras

Resource    ../KeyWords/KeyOrdemServico1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - gerando OS com serviço na forma 30 dias
    [Tags]    Teste01   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS
Teste 02 - gerando OS com serviço na forma à vista
    [Tags]    Teste02
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo
Teste 03 - gerando OS com serviço na forma personalizada
    [Tags]    Teste03
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS
Teste 04 - gerando OS com produto na forma 30 dias
    [Tags]    Teste04
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia produtos
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS
Teste 05 - gerando OS com produto na forma à vista
    [Tags]    Teste05
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia produtos
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo
Teste 06 - gerando OS com produto na forma personalizada
    [Tags]    Teste06
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia produtos
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS
Teste 07 - gerando OS com serviço e produto na forma 30 dias
    [Tags]    Teste07
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    E preencho a guia produtos
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS
Teste 08 - gerando OS com serviço e produto na forma à vista
    [Tags]    Teste08
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    E preencho a guia produtos
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento de ambos
Teste 09 - gerando OS com serviço e produto na forma personalizada
    [Tags]    Teste09
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    E preencho a guia produtos
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS
