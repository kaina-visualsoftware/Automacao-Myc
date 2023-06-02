*** Settings ***
Documentation    Testes Geração de venda e OS oriunda de orçamentos

Resource    ../KeyWords/keyOrcamentos2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43

*** Test Cases ***
Teste 01 - Gerando OS agrupada de todos os orcamentos anteriores
    [Tags]    Teste01
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de vendas agrupada
    E clico em gerar venda agrupada
    Quando seleciono o serial(2)
    E informo os lotes(2)
    Quando incluo os funcionarios comissionados(8)
    Então finalizo a OS

Teste 02 - Gerando venda de Orcamento com um único produto
    [Tags]    Teste02
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda