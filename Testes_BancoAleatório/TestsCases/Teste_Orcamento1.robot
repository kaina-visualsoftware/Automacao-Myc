*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/keyOrcamento1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Orcamento com produto normal
    [Tags]    Teste01 
    Dado que acesso a tela de orçamento 
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então Gravo o Orcamento

Teste 02 - Visualizando o orcamento
    [Tags]    Teste02
    Dado que acesso a tela de orçamento 
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então Gravo o Orcamento
    Então visualizo o mesmo

Teste 03 - Editando um orcamento
    [Tags]    Teste03
    Dado que acesso a tela de orçamento 
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então Gravo o Orcamento
    Quando clico em editar
    Quando insiro um produto normal
    Então Gravo o Orcamento

Teste 04 - Excluindo um orcamento
    [Tags]    Teste04
    Dado que acesso a tela de orçamento 
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então Gravo o Orcamento
    Quando clico em excluir
    Então finalizo a exclusão