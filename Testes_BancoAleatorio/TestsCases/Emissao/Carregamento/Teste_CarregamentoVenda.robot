*** Settings ***
Resource    ../../../KeyWords/Emissão/Carregamento/Venda/KeyCarregamentoVenda.robot
Resource    ../../../utils/parametros_pre_condicoes.robot
Resource    ../../../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar


*** Test Cases ***


Teste 01 - Lancamento de carregamento de venda
    [Tags]    Teste01
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 02 - Validar status inicial do carregamento
    [Tags]    Teste02
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento com status    Cadastrando
    Então o status deve ser "Cadastrando"
    Então fecho a tela de carregamento


Teste 03 - Editar carregamento adicionando venda
    [Tags]    Teste03
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso o lançamento de carregamento de vendas
    Quando edito o carregamento cadastrado
    E incluo vendas no carregamento    1
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 04 - Excluir carregamento com status cadastrando
    [Tags]    Teste04
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso o lançamento de carregamento de vendas
    Quando excluo o carregamento
    Então o carregamento deve ser excluído com sucesso
    Então fecho a tela de carregamento


Teste 05 - Nao permitir excluir carregamento fechado
    [Tags]    Teste05
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento com status    Fechada
    Quando excluo o carregamento
    Então o sistema deve impedir a exclusão
    Então fecho a tela de carregamento


Teste 06 - Incluir uma venda no carregamento
    [Tags]    Teste06
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    E incluo vendas no carregamento    1
    Então a venda deve ser incluída com sucesso no carregamento
    Então fecho a tela de carregamento


Teste 07 - Incluir multiplas vendas no carregamento
    [Tags]    Teste07
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(3)

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    E incluo vendas no carregamento    3
    Então a venda deve ser incluída com sucesso no carregamento
    Então fecho a tela de carregamento


Teste 08 - Incluir cobranca no carregamento
    [Tags]    Teste08
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    E incluo vendas no carregamento    1
    E incluo uma cobrança no carregamento
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 09 - Editar carregamento incluindo venda e cobranca
    [Tags]    Teste09
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso o lançamento de carregamento de vendas
    Quando edito o carregamento cadastrado
    E incluo vendas no carregamento    1
    E incluo uma cobrança no carregamento
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 10 - Realizar embarque do carregamento
    [Tags]    Teste10
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    E incluo vendas no carregamento    1
    E incluo uma cobrança no carregamento
    Quando acesso a tela de embarque
    E informo os dados do veículo    SP    ABC-1234    100    200    50
    E informo os dados do motorista
    E informo os dados do entregador
    E informo os dados do adiantamento
    E gravo o embarque
    Então o embarque deve ser salvo com sucesso
    Então o adiantamento deve estar cadastrado no banco
    Então fecho a tela de carregamento


Teste 11 - Validar status Montada apos incluir venda
    [Tags]    Teste11
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso o lançamento de carregamento de vendas
    Quando realizo um novo carregamento com descrição valida
    E incluo vendas no carregamento    1
    Então o status do carregamento deve ser    Montada
    Então fecho a tela de carregamento
