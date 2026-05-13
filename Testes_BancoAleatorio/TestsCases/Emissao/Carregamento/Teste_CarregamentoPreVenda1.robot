*** Settings ***
Documentation    Testes em Banco Aleatório


Resource  ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/Pre-venda/KeyCarregamentoPreVenda1.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeycarregamentoPreVenda1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***

Teste 01 - Validar criação de carregamento com o status Fechada de uma pré-venda
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
    E valido que o carregamento está com o status    Fechada
    E fecho a tela de carregamento

Teste 02 - Validar que não é possível excluir um carregamento com status Fechada
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

Teste 03 - Excluir um carregamento com status Montando
    [Tags]    Teste03

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu Monto a Carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E excluo o Carregamento parcialmente gerado
    E fecho a tela de carregamento

Teste 04 - Validar criação de carregamento com o status Montando de uma pré-venda
    [Tags]    Teste04

    Dado que eu crio uma nova pré-venda de um cliente com rota    
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento está com o status    Montando
    E fecho a tela de carregamento

Teste 05 - Carregamento vinculado a duas pré-vendas com rotas distintas
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

Teste 06 - Validar Carregamento com Status Cadastrando e sem uma rota vinculada
    [Tags]    Teste06

    Dado que acesso a tela de carregamento
    E adiciono um carregamento sem rota
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento está com o status    Cadastrando
    E fecho a tela de carregamento

Teste 07 - Validar exclusão de um carregamento com status Cadastrando
    [Tags]    Teste07

    Dado que acesso a tela de Carregamento
    E adiciono um carregamento sem rota
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento está com o status    Cadastrando
    E excluo o carregamento
    E fecho a tela de carregamento

Teste 08 - Validar que não é possível fechar uma carga sem montar e imprimir o mapa
    [Tags]    Teste08

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando tento fechar a carga sem montar e imprimir o mapa
    Então fecho a validação de fechar sem montar e imprimir o mapa
    Quando eu monto a carga
    Quando imprimo o mapa da rota
    E em seguida fecho a carga
    Então Gravo o carregamento
    E valido que o carregamento está com o status    Fechada
    E fecho a tela de carregamento

Teste 09 - Editar um carregamento e em seguida fechar a carga
    [Tags]    Teste09

    Dado que eu crio duas pré-vendas com rotas distintas
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Então Gravo o carregamento
    Quando pesquiso o Carregamento gerado
    E valido que o carregamento está com o status    Montando
    Então edito o carregamento
    E incluo mais uma rota ao carregamento
    Quando eu Monto a Carga
    Quando imprimo o mapa da rota
    E em seguida fecho a carga
    Então Gravo o carregamento
    E valido que o carregamento está com o status    Fechada
    E fecho a tela de carregamento

Teste 10 - Editar um carregamento removendo a rota e revertendo para status Cadastrando
    [Tags]    Teste10

    Dado que eu crio uma nova pré-venda de um cliente com rota
    E listo pela tela de Geração de vendas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com rota
    Quando eu monto a carga
    Então Gravo o carregamento
    E valido que o carregamento está com o status    Montando
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E removo a rota do carregamento
    Então Gravo o carregamento
    E valido que o carregamento está com o status    Cadastrando
    E fecho a tela de carregamento