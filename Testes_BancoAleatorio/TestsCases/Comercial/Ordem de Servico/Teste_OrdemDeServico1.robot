*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyOrdemDeSevico1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 – Lançamento de ordem de serviço com produto e serviço
    [Tags]    Teste01

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 02 - Visualização de ordem de serviço
    [Tags]    Teste02

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    Então visualizo a ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 03 - Edição de ordem de serviço
    [Tags]    Teste03

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    Quando clico em editar
    E excluo os pagamentos lançados
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    E saio da tela(OrdemDeServico)

Teste 04 - Exclusão de ordem de serviço
    [Tags]    Teste04

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    Então clico em excluir
    E saio da tela(OrdemDeServico)

Teste 05 – Faturamento de NFSe da ordem de serviço - Somente serviço
    [Tags]    Teste05

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe
    E saio da tela(OrdemDeServico)

Teste 06 – Faturamento de NFSe da ordem de serviço – Com produto e serviço
    [Tags]    Teste06

    Dado que acesso a tela de ordens de serviços
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um serviço
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe
    E saio da tela(OrdemDeServico)