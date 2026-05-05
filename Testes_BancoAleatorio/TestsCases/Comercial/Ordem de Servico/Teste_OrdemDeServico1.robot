*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot
Resource    ../../../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 – Lançamento de ordem de serviço com produto e serviço
    [Tags]    Teste01

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 02 - Visualização de ordem de serviço
    [Tags]    Teste02

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    Então visualizo a ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 03 - Edição de ordem de serviço
    [Tags]    Teste03

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    E pesquiso pela ordem de serviço gerada
    KeyOrdemDeSevico1.Quando clico em editar
    KeyOrdemDeSevico1.E excluo os pagamentos lançados
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    E saio da tela(OrdemDeServico)

Teste 04 - Exclusão de ordem de serviço
    [Tags]    Teste04

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço - A Prazo
    E pesquiso pela ordem de serviço gerada
    KeyOrdemDeSevico1.Então clico em excluir
    E saio da tela(OrdemDeServico)

Teste 05 – Faturamento de NFSe da ordem de serviço - Somente serviço
    [Tags]    Teste05

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe
    E saio da tela(OrdemDeServico)

Teste 06 – Faturamento de NFSe da ordem de serviço – Com produto e serviço
    [Tags]    Teste06

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    Quando pressiono o atalho de faturar
    Então realizo o faturamento da NFSe
    E saio da tela(OrdemDeServico)

Teste 07 - Alteração de status da ordem de serviço finalizada
    [Tags]    Teste07

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    E pressiono o atalho de status
    Então altero o status da ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 08 - Inclusão de insumos na OS finalizada
    [Tags]    Teste08

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    Quando insiro mais de um serviço(2)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    E pressiono o atalho de insumos
    E insiro insumos para cada serviço da OS
    E saio da tela(OrdemDeServico)

Teste 09 – Lançamento de ordem de serviço com adiantamento
    [Tags]    Teste09

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    E acesso a aba adiantamentos
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E saio da tela(OrdemDeServico)
    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.Quando insiro o código do cliente(aReceber)
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.E preparo recebimento com adiantamento
    keyCaixa1.Então faço o recebimento da conta
    E saio da tela(CaixaPrincipal)
    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.Quando insiro o código do cliente(aReceber)
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.E preparo recebimento com adiantamento
    keyCaixa1.Então faço o recebimento da conta
    E saio da tela(CaixaPrincipal)

Teste 10 - Lançamento de ordem de serviço e gravando ao final
    [Tags]    Teste10

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então gravo a ordem de serviço
    E saio da tela(OrdemDeServico)

Teste 11 - Fechamento e reabertura de ordem de serviço
    [Tags]    Teste11

    Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então fecho a ordem de serviço
    E pesquiso pela ordem de serviço gerada
    KeyOrdemDeSevico1.Quando clico em editar
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    E clico em reabrir OS
    E insiro um serviço informando a quantidade(1)
    E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    Então finalizo a ordem de serviço
    E saio da tela(OrdemDeServico)