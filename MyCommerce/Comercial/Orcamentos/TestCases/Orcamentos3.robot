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
    Quando insiro todos os tipos de produtos
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

