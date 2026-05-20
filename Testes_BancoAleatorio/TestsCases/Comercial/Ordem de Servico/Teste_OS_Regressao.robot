*** Settings ***
Documentation    Teste de Regressão - Ordem de Serviço

Resource    ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeServicoRegressao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Teardown Restaurar Parametros Alterados E Reiniciar MyCommerce Se Necessário


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


Teste 03 - Selecionar cliente na OS pelo CNPJ existente
    [Tags]    Teste03

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CNPJ
    E acesso a aba de pagamentos
    KeyOrdemDeServicoRegressao.Então gravo a ordem de serviço
    Então a ordem de serviço deve estar salva no banco com o CNPJ correto


Teste 04 - Validar CNPJ não cadastrado na OS
    [Tags]    Teste04

    Dado que gravo o código da última OS existente
    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo cliente com CNPJ não existente
    Então nenhuma OS deve ter sido persistida no banco


Teste 05 - Validar bloqueio ao gravar OS sem serviço
    [Tags]    Teste05
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_SERVICO_OBRIGATORIO    -1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de pagamentos
    E tento gravar a OS sem serviço
    E o foco deve estar na guia de serviços


Teste 06 - Criar OS com produto da modalidade Normal
    [Tags]    Teste06

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E insiro um produto normal
    E acesso a aba de pagamentos
    Então fecho a ordem de serviço sem pagamentos
    Então a OS com produto normal deve estar salva no banco


Teste 07 - Validar exclusão de OS com produto da modalidade Normal
    [Tags]    Teste07

    Dado que acesso a tela de ordens de serviços para regressão
    E que existe uma OS com produto normal salva
    Quando seleciono a OS e clico em excluir
    E informo a descrição de exclusão
    Então a OS deve ser excluída do banco


Teste 08 - Validar sequência de foco ao setar vendedor que inseriu produto
    [Tags]    Teste08
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_FUNCIONARIO_PRODUTO    1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de produtos
    E informo um produto
    E informo o vendedor que inseriu o produto
    Então o foco deve estar no campo de código do produto