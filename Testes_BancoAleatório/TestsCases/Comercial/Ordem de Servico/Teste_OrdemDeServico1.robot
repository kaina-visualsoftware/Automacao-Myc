*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyOrdemDeSevico1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando nova Ordem de Serviço
    [Tags]    Teste01 
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a Ordem de Servico

Teste 02 - Visualizando nova Ordem de Serviço
    [Tags]    Teste02
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a Ordem de Servico
    Então visualizado a OS recém criada

Teste 03 - Editando nova Ordem de Serviço
    [Tags]    Teste03
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a OS - A prazo
    Quando clico em editar
    E excluo os pagamentos lançados
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a OS - A prazo

Teste 04 - Excluindo nova Ordem de Serviço
    [Tags]    Teste04
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a OS - A prazo
    Então clico em excluir

Teste 05 - Faturando NFSe da Ordem de Serviço - Somente serviço
    [Tags]    Teste05
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E acesso a aba pagamentos
    Então finalizo a Ordem de Servico
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe

Teste 06 - Faturando NFSe da Ordem de Serviço - Com produto e serviço
    [Tags]    Teste05
    Dado que acesso a tela de Ordem de Servico
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando Insiro um servico
    E insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a Ordem de Servico
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe