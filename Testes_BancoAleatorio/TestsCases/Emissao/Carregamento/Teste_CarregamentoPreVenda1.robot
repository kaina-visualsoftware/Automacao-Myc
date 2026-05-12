*** Settings ***
Documentation    Testes em Banco Aleatório


Resource  ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/Pre-venda/KeyCarregamentoPreVenda1.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/parametros_pre_condicoes.robot

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

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E excluo o Carregamento parcialmente gerado
    E fecho a tela de carregamento

Teste 04 - Validar criação de carregamento com o status Montando
    [Tags]    Teste04

    Dado que eu crio uma nova pré-venda de um cliente com rota    
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento está com o status Montando
    E fecho a tela de carregamento

Teste 05 - Carregamento para duas rotas

    [Tags]    Teste05

    Dado que eu crio duas pré-vendas com rotas distintas
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com duas rotas
    Quando eu monto a carga
    Quando imprimo o mapa da rota
    E em seguida fecho a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento contém duas rotas diferentes
    E fecho a tela de carregamento