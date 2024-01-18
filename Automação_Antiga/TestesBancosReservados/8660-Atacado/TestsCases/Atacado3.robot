*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado3.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando condicional com produto normal
    [Tags]    Teste01
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então finalizo a condicional

Teste 02 - Adicionando condicional com produto com desconto
    [Tags]    Teste02
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(1 5)
    Então finalizo a condicional

Teste 03 - Adicionando condicional com mais de um produto normal
    [Tags]    Teste03
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional

Teste 04 - Adicionando condicional e gerando Venda Total
    [Tags]    Teste04
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então finalizo a condicional
    Quando clico em Gerar Venda
    Então finalizo a venda
    
Teste 05 - Adicionando condicional com mais de um produto e gerando venda total
    [Tags]    Teste05
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em Gerar Venda
    Então finalizo a venda

Teste 06 - Adicionando condicional com produto com desconto e gerando venda total
    [Tags]    Teste06
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(1 5)
    Então finalizo a condicional
    Quando clico em Gerar Venda
    Então finalizo a venda

Teste 07 - Adicionando condicional com mais de um produto e gerando venda Parcial
    [Tags]    Teste07
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em Gerar Venda Parcial
    E seleciono os produtos para gerar a venda(3)
    Então finalizo a venda

Teste 08 - Adicionando condicional com produto com desconto
    [Tags]    Teste08
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(1 5)
    Então finalizo a condicional
    Quando clico em Gerar Venda Parcial
    E seleciono os produtos para gerar a venda(3)
    Então finalizo a venda

Teste 09 - Adicionando condicional com produto com desconto
    [Tags]    Teste09
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(4 10)
    Então finalizo a condicional
    Quando clico em Gerar Venda Parcial
    E seleciono os produtos para gerar a venda(3)
    Então finalizo a venda

Teste 10 - Adicionando condicional e gerando devolução da mesma
    [Tags]    Teste10
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em gerar devolução
    E seleciono os itens a serem devolvidos(2)
    Então finalizo a finalizo a devolução gravando

Teste 11 - Adicionando condicional e gerando Venda da mesma
    [Tags]    Teste11
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em gerar devolução
    E seleciono os itens a serem devolvidos(2)
    Quando finalizo a devolução gerando venda
    Então finalizo a venda

Teste 12 - Editando a condicional e alterando a quantidade de produto
    [Tags]    Teste12
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em editar
    E seleciono um produto para a edição
    E altero a quantidade inserida nele
    Então finalizo a condicional

Teste 13 - Editando a condicional e alterando o desconto de um produto 
    [Tags]    Teste13
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(3)
    Então finalizo a condicional
    Quando clico em editar
    E seleciono um produto para a edição
    Quando aplico desconto no item(15)
    Então finalizo a condicional

Teste 14 - Editando a condicional e removendo um produto
    [Tags]    Teste14
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
    Quando clico em editar
    E removo um item da condicional
    Então finalizo a condicional

Teste 15 - Adicionando condicional e excluindo a mesma
    [Tags]    Teste15
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(2)
    Então finalizo a condicional
    Quando pressiono o botão de excluir
    E informo o motivo da exclusao
    Então confirmo a exclusão 

Teste 16 - Adicionando condicional e cancelando a exclusão
    [Tags]    Teste16
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(2)
    Então finalizo a condicional
    Quando pressiono o botão de excluir
    E informo o motivo da exclusao
    Então cancelo a exclusão