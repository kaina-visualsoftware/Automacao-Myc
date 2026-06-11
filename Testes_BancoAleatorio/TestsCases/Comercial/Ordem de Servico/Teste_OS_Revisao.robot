*** Settings ***
Documentation    Teste de Regressão - Ordem de Serviço

Resource    ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeServicoRevisao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Teardown Restaurar Parametros Alterados E Reiniciar MyCommerce Se Necessário


*** Test Cases ***
CT 1-579 - Selecionar cliente na OS com CPF existente
    [Tags]    CT 1-579

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de pagamentos
    KeyOrdemDeServicoRevisao.Então gravo a ordem de serviço
    Então a ordem de serviço deve estar salva no banco com os dados corretos
    E saio da tela(OrdemDeServico)


CT 1-580 - Selecionar cliente na OS com CPF inexistente
    [Tags]    CT 1-580

    Dado que gravo o código da última OS existente
    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo cliente com CPF não existente
    Então nenhuma OS deve ter sido persistida no banco
    E saio da tela(OrdemDeServico)


CT 1-581 - Selecionar cliente na OS com CNPJ existente
    [Tags]    CT 1-581

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CNPJ
    E acesso a aba de pagamentos
    KeyOrdemDeServicoRevisao.Então gravo a ordem de serviço
    Então a ordem de serviço deve estar salva no banco com o CNPJ correto
    E saio da tela(OrdemDeServico)

CT 1-582 - Selecionar cliente na OS com CNPJ inexistente
        [Tags]    CT 1-582

    Dado que gravo o código da última OS existente
    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo cliente com CNPJ não existente
    Então nenhuma OS deve ter sido persistida no banco
    E saio da tela(OrdemDeServico)


CT 1-141 - Bloquear Gravar a O.S sem incluir um serviço
    [Tags]    CT 1-141
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_SERVICO_OBRIGATORIO    -1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de pagamentos
    E tento gravar a OS sem serviço
    E o foco deve estar na guia de serviços
    E saio da tela(OrdemDeServico)


CT 1-318 - Criar Ordem de Serviço - Produtos Modalidade Normal
    [Tags]    CT 1-318

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E insiro um produto normal
    E acesso a aba de pagamentos
    Então fecho a ordem de serviço sem pagamentos
    Então a OS com produto normal deve estar salva no banco
    E saio da tela(OrdemDeServico)


CT 1-319 - Excluir Ordem de Serviço - Produtos Modalidade Normal
    [Tags]    CT 1-319
    [Setup]    Run Keywords    Pré Condição Os_exclui_Super Ativado    AND    Reiniciar MyCommerce Se Necessário
    [Teardown]    Run Keywords    Restaurar Os_exclui_Super    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    E que existe uma OS com produto normal salva
    Quando seleciono a OS e clico em excluir
    E informo a descrição de exclusão
    Então a OS deve ser excluída do banco
    E saio da tela(OrdemDeServico)

CT 1-393 - Lançamento de Vendedor na inclusão do produto
    [Tags]    CT 1-393
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_FUNCIONARIO_PRODUTO    1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de produtos
    E insiro um produto normal
    E informo o vendedor que inseriu o produto
    E acesso a aba de pagamentos
    KeyOrdemDeServicoRevisao.Então gravo a ordem de serviço
    Então o vendedor do produto deve estar salvo no banco com o código correto
    E saio da tela(OrdemDeServico)

CT 1-103 - Realizar O.S incluindo descrição em serviços
    [Tags]    CT 1-103
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_COMFUNCIONARIO    1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço para detalhamento
    E informo o vendedor para OS detalhamento
    E informo a tabela de preço para OS detalhamento
    E informo o cliente pelo CPF para OS detalhamento
    Quando insiro um serviço com descrição detalhada    2
    E acesso a aba de pagamentos
    Então gravo a ordem de serviço com serviços detalhados
    Então as descrições dos serviços devem estar salvas corretamente
    Então a OS com serviços detalhados deve estar salva no banco
    E saio da tela(OrdemDeServico)


CT 1-105 - Bloquear Finalizar O.S sem serviço
    [Tags]    CT 1-105
    [Setup]    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_SERVICO_OBRIGATORIO_FINALIZAR    -1    AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E insiro um produto normal
    E acesso a aba de pagamentos
    E tento finalizar a OS sem serviço
    E o foco deve estar na guia de serviços
    E saio da tela(OrdemDeServico)