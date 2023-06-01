*** Settings ***
Documentation    Testes básicos em orçamentos, inlcuindo produtos, excluindo, editando.

Resource    ../KeyWords/keyOrcamentos1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43

*** Test Cases ***
Teste 01 - Incluindo produto e fazendo o orçamento de maneira padrão - Á vista
    [Tags]    Teste01
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o orçamento como a vista

Teste 02 - Incluindo serviço e produto de maneira padrão - Á vista
    [Tags]    Teste02
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o orçamento como a vista

Teste 03 - Incluindo mais de um produto de maneira padrão - Á vista
    [Tags]    Teste03
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro mais de um produto normal
    Então finalizo o orçamento como a vista

Teste 04 - Incluindo mais de um serviço, e um produto de maneira padrão - Á vista
    [Tags]    Teste04
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo mais de um serviço
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o orçamento como a vista

Teste 05 - Incluindo um serviço de maneira padrão - Á vista
    [Tags]    Teste05
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Então finalizo o orçamento como a vista

Teste 06 - Inclusão de Produto do tipo Kit - Á vista
    [Tags]    Teste06
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Então finalizo o orçamento como a vista

Teste 07 - Incluindo um produto do tipo kit e um serviço - Á vista
    [Tags]    Teste07
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando informo um objeto
    E informo um serviço
    Então finalizo o orçamento como a vista

Teste 08 - Inclusão de Produto do tipo serial - Á vista
    [Tags]    Teste08
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Então finalizo o orçamento como a vista

Teste 09 - Incluindo um produto do tipo serial e um serviço - Á vista
    [Tags]    Teste09
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Quando informo um objeto
    E informo um serviço
    Então finalizo o orçamento como a vista

Teste 10 - Inclusão de Produto do tipo lote - Á vista
    [Tags]    Teste10
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo lote
    Então finalizo o orçamento como a vista

Teste 11 - Incluindo um produto do tipo lote e um serviço - Á vista
    [Tags]    Teste11
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo lote
    Quando informo um objeto
    E informo um serviço
    Então finalizo o orçamento como a vista

Teste 12 - Inclusão de Produto do tipo grade - Á vista
    [Tags]    Teste12
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo grade
    Então finalizo o orçamento como a vista

Teste 13 - Incluindo um produto do tipo grade e um serviço - Á vista
    [Tags]    Teste13
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo grade
    Quando informo um objeto
    E informo um serviço
    Então finalizo o orçamento como a vista

Teste 14 - Incluindo os produtos de todos os tipos - Á vista
    [Tags]    Teste14
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro todos os tipos de produtos
    Então finalizo o orçamento como a vista

Teste 15 - Editando último orçamento cadastrado
    [Tags]    Teste15
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho para editar
    E removo o último produto inserido
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então gravo o orçamento - 30 Dias
