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

Teste 03 - Gerando venda de um Orcamento de um único produto - 30 Dias
    [Tags]    Teste03
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Então finalizo a venda - 30 Dias / Personalizada

Teste 04 - Gerando uma OS com serviço e produto
    [Tags]    Teste04
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 05 - Gerando uma OS com mais de um serviço
    [Tags]    Teste05
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo mais de um serviço
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(2)
    Então finalizo a OS

Teste 06 - Gerando venda de Produto do tipo Kit - Á vista
    [Tags]    Teste06
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 07 - Gerando OS de um produto do tipo kit e um serviço - Á vista
    [Tags]    Teste07
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 08 - Gerando venda de Produto do tipo Kit - 30 Dias
    [Tags]    Teste08
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Então finalizo a venda - 30 Dias / Personalizada

Teste 09 - Gerando OS de um produto do tipo kit e um serviço - 30 Dias
    [Tags]    Teste09
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 10 - Gerando venda de Produto do tipo serial - Á vista
    [Tags]    Teste10
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando seleciono o serial(1)
    Então finalizo a venda

Teste 11 - Gerando OS de um produto do tipo serial e um serviço - Á vista
    [Tags]    Teste11
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_SERIAL})  
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando seleciono o serial(1)
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 12 - Gerando venda de Produto do tipo serial - 30 Dias
    [Tags]    Teste12
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Quando seleciono o serial(1)
    Então finalizo a venda - 30 Dias / Personalizada

Teste 13 - Gerando OS de um produto do tipo serial e um serviço - 30 Dias
    [Tags]    Teste13
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto(${COD_PRODUTO_SERIAL})  
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Quando seleciono o serial(1)
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 14 - Gerando venda de Produto do tipo lote - Á vista
    [Tags]    Teste14
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo lote
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    E informo os lotes(1)
    Então finalizo a venda

Teste 15 - Gerando OS de um produto do tipo lote e um serviço - Á vista
    [Tags]    Teste15
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo lote 
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    E informo os lotes(1)
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 16 - Gerando venda de Produto do tipo lote - 30 Dias
    [Tags]    Teste16
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo lote
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    E informo os lotes(1)
    Então finalizo a venda - 30 Dias / Personalizada

Teste 17 - Gerando OS de um produto do tipo lote e um serviço - 30 Dias
    [Tags]    Teste17
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo lote 
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    E informo os lotes(1)
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 18 - Gerando venda de Produto do tipo grade - Á vista
    [Tags]    Teste18
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo grade
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Então finalizo a venda

Teste 19 - Gerando os de um produto do tipo grade e um serviço - Á vista
    [Tags]    Teste19
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo grade
    Quando finalizo o orçamento como a vista
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS

Teste 20 - Gerando venda de Produto do tipo grade - 30 Dias
    [Tags]    Teste20
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo grade
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Então finalizo a venda - 30 Dias / Personalizada

Teste 21 - Gerando OS de um produto do tipo grade e um serviço - 30 Dias
    [Tags]    Teste21
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo grade
    Quando finalizo o orçamento como 30 Dias
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 22 - Gerando OS de um produto do tipo grade e um serviço - Personalizada
    [Tags]    Teste22
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo grade
    Quando finalizo o orçamento como a Personalizada
    E clico em gerar venda
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 23 - Gerando venda de Orcamento com um único produto
    [Tags]    Teste23
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o orçamento como a Personalizada
    E clico em gerar venda
    Então finalizo a venda - 30 Dias / Personalizada

Teste 24 - Gerando OS de um produto do tipo lote e um serviço - Personalizada
    [Tags]    Teste24
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando informo um objeto
    E informo um serviço
    Quando insiro um produto do tipo lote 
    Quando finalizo o orçamento como a Personalizada
    E clico em gerar venda
    E informo os lotes(1)
    Quando incluo os funcionarios comissionados(1)
    Então finalizo a OS - 30 Dias / Personalizada

Teste 25 - Gerando venda de Produto do tipo lote - Personalizada
    [Tags]    Teste25
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro um produto do tipo lote
    Quando finalizo o orçamento como a Personalizada
    E clico em gerar venda
    E informo os lotes(1)
    Então finalizo a venda - 30 Dias / Personalizada