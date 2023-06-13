*** Settings ***
Documentation    Testes Geração de venda e OS oriunda de orçamentos com desconto e acrescimo

Resource    ../KeyWords/KeyOrcamentos3.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

*** Variables ***
${COD_PRODUTO_NORMAL}        3     #Desconto Máximo = 15%
${COD_PRODUTO_KIT}           9     #Desconto Máximo = 0%
${COD_PRODUTO_SERIAL}        43    #Desconto Máximo = 5%

*** Test Cases ***
Teste 01 - Gerando venda de Orcamento com um único produto - Desconto de 5%
    [Tags]    Teste01
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 5)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 02 - Gerando venda de Orcamento com um único produto - Desconto de 5% - Personalizada
    [Tags]    Teste02
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 5)
    Quando finalizo o orçamento como a Personalizada
    E clico em gerar venda
    Então finalizo a venda - 30 Dias / Personalizada

Teste 03 - Incluindo mais de um produto de maneira padrão - Desconto de 5% - Á vista
    [Tags]    Teste03
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro mais de um produto normal(5)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 04 - Incluindo os produtos de todos os tipos - Á vista
    [Tags]    Teste04
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro todos os tipos de produtos(5)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando seleciono o serial(1)
    E informo os lotes(1)
    Então finalizo a venda

Teste 05 - Gerando venda de Orcamento com um único produto - Desconto de 10%
    [Tags]    Teste05
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 10)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 06 - Gerando venda de Orcamento com um único produto - Desconto de 20%
    [Tags]    Teste06
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto - Ultrapassando Desconto Máximo(${COD_PRODUTO_NORMAL} 20)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 07 - Gerando venda de orcamento - Aplicando desconto no final do orcamento - 10%
    [Tags]    Teste07
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista - Desconto no final(10)
    E clico em gerar venda
    Então finalizo a venda

Teste 08 - Gerando venda de orcamento - Aplicando desconto no final do orcamento - 20%
    [Tags]    Teste08
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista - Desconto no final(20)
    E clico em gerar venda
    Então finalizo a venda

Teste 09 - Gerando venda de orçamento com todos os tipos de produto - Aplicando Desconto no final do orcamento - 50%
    [Tags]    Teste09
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro todos os tipos de produtos(0)
    Quando finalizo o orçamento como a vista - Desconto no final(50)
    E clico em gerar venda
    Quando seleciono o serial(1)
    E informo os lotes(1)
    Então finalizo a venda

Teste 10 - Gerando venda de orçamento com produto normal - Aplicando desconto na edição do orcamento - 20%
    [Tags]    Teste10
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista
    Quando pressiono o atalho para editar
    E edito o produto inserido(20)
    Então gravo o orçamento
    E clico em gerar venda
    Então finalizo a venda

Teste 11 - Gerando venda de orçamento com produto normal - Aplicando acrescimo no produto - 5%
    [Tags]    Teste11
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 5)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda - Acrescimo

Teste 12 - Gerando OS de orcamento com produto e serviço normal - Aplicando acrescimo no produto - 5%
    [Tags]    Teste12
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 5)
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 13 - Gerando venda de orçamento com produto normal - Aplicando acrescimo no final do orcamento - 5%
    [Tags]    Teste13
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista - Acrescimo no final(5)
    E clico em gerar venda
    Então finalizo a venda - Acrescimo

Teste 14 - Gerando OS de orçamento com produto normal - Aplicando acrescimo no final do orcamento - 5%
    [Tags]    Teste14
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista - Acrescimo no final(5)
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 15 - Gerando venda de orçamento com produto normal - Aplicando acrescimo na edição do orcamento - 20%
    [Tags]    Teste15
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
     Quando insiro um produto - acrescimo(${COD_PRODUTO_NORMAL} 0)
    Quando finalizo o orçamento como a vista
    Quando pressiono o atalho para editar
    E edito o produto inserido - Acrescimo(20)
    Então gravo o orçamento
    E clico em gerar venda
    Então finalizo a venda - Acrescimo