*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ../../../KeyWords/Emissão/Carregamento/Pre-venda/KeycarregamentoPreVenda1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeycarregamentoPreVenda1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***

Teste 01 - Criar um carregamento de pré-venda para uma rota
    [Tags]    Teste01
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2   AND
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Quando imprimo o mapa da rota
    E em seguida fecho a carga
    Então Gravo o carregamento
    E fecho a tela de carregamento

Teste 02 - Validar se está sendo possível excluir um carregamento fechado
    [Tags]    Teste02
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2   AND
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Quando imprimo o mapa da rota
    E em seguida fecho a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E excluo o Carregamento totalmente gerado
    E fecho a tela de carregamento   

Teste 03 - Excluir um carregamento em andamento
    [Tags]    Teste03
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2   AND
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E excluo o Carregamento parcialmente gerado
    E fecho a tela de carregamento

Teste 04 - Validar pesquisa de carregamento com status Montando
    [Tags]    Teste04
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2   AND
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento pesquisado existe no banco
    E fecho a tela de carregamento