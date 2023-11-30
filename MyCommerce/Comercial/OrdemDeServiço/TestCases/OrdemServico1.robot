*** Settings ***
Documentation    Testes Ordem de Serviço

Resource    ../KeyWords/KeyOrdemServico1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        188

*** Test Cases ***
Teste 01 - gerando OS com serviço na forma 30 dias
    [Tags]    Teste01   
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS - Somente serviço

Teste 02 - gerando OS com serviço na forma à vista
    [Tags]    Teste02
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - Somente serviço
    E digito o valor do pagamento e confirmo
Teste 03 - gerando OS com serviço na forma personalizada
    [Tags]    Teste03
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS - Somente serviço
Teste 04 - gerando OS com produto na forma 30 dias
    [Tags]    Teste04
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS
Teste 05 - gerando OS com produto na forma à vista
    [Tags]    Teste05
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo
Teste 06 - gerando OS com produto na forma personalizada
    [Tags]    Teste06
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS
Teste 07 - gerando OS com serviço e produto na forma 30 dias
    [Tags]    Teste07
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma 30 dias na aba pagamentos
    Então finalizo a OS
Teste 08 - gerando OS com serviço e produto na forma à vista
    [Tags]    Teste08
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento de ambos
Teste 09 - gerando OS com serviço e produto na forma personalizada
    [Tags]    Teste09
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    E preencho a guia serviços
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS

Teste 10 - Gerando OS com mais de um produto - personalizada
    [Tags]    Teste10
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro mais de um produto normal
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS

Teste 11 - Gerando OS com produto do tipo kit - a vista 
    [Tags]    Teste11
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo

Teste 12 - Gerando OS com produto do tipo Grade - a vista 
    [Tags]    Teste12
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto do tipo grade
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo

Teste 13 - Gerando OS de produto lote - personalizada
    [Tags]    Teste13
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto do tipo lote
    Quando escolho a forma personalizada na aba pagamentos
    Então finalizo a OS

Teste 14 - Gerando OS de produto serial - a vista
    [Tags]    Teste14
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto do tipo serial
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    E digito o valor do pagamento e confirmo

Teste 15 - Gerando OS com todos os tipos de produtos - a vista
    [Tags]    Teste15
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro todos os tipos de produtos
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS - Gravando

Teste 16 - Editando OS com todos os tipos de produtos - a vista
    [Tags]    Teste16
    Dado que acesso a guia ordens de serviços
    Quando pressiono o atalho para editar
    E removo o último produto inserido
    Então finalizo a OS - Venda Rápida
    
Teste 17 - Excluindo a última OS feita 
    [Tags]    Teste17
    Dado que acesso a guia ordens de serviços
    Quando pressiono o atalho de excluir
    Então informo o motivo da exlusão

Teste 18 - Gerando ordem de serviço com adiantamento
    [Tags]    Teste18
    Dado que acesso a guia ordens de serviços
    Quando preencho código de vendedor e do cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    E preencho a guia adiantamentos
    Quando escolho a forma à vista na aba pagamentos
    Então finalizo a OS
    