*** Settings ***
Documentation    Teste de Regressão - Ordem de Serviço

Resource    ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeServicoRegressao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar


*** Test Cases ***
Teste 01 - Criar OS validando cliente por CPF
    [Tags]    Teste01

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de pagamentos
    KeyOrdemDeServicoRegressao.Então gravo a ordem de serviço
    Então a ordem de serviço deve estar salva no banco com os dados corretos


Teste 02 - Validar CPF não cadastrado na OS
    [Tags]    Teste02

    Dado que gravo o código da última OS existente
    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo cliente com CPF não existente
    Então nenhuma OS deve ter sido persistida no banco