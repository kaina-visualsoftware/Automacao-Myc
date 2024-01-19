*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Comercial/Vendas/keyVendas1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Venda com produto Normal
    [Tags]    Teste01
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda

Teste 02 - Visualizando uma venda 
    [Tags]    Teste02
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda
    Então visualizo a mesma

Teste 03 - Editando venda
    [Tags]    Teste03
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo
    Quando clico em editar
    E excluo os pagamentos lançados
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo

Teste 04 - Excluindo uma venda 
    [Tags]    Teste04
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo
    Então clico em excluir

Teste 05 - Realizando venda com mais de um produto 
    [Tags]    Teste05
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um produto normal(2)
    E acesso a aba pagamentos
    Então finalizo a venda