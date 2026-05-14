*** Settings ***
Documentation    Testes em Banco Aleatório


Resource  ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/Pre-venda/KeyCarregamentoPreVenda1.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeycarregamentoPreVenda1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Setup    Run Keywords    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2   AND    Inicializar Pré-Condições    AND    Reiniciar MyCommerce Se Necessário
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***

Teste 01 - Validar que não é possível excluir um carregamento com status Fechada
    [Documentation]    Este teste valida que não é possível excluir um carregamento com status Fechada
    [Tags]    Teste01

    Dado que eu crio uma pré-venda com rota
    Então acesso a tela de Carregamento
    E adiciono um carregamento com uma rota
    Então gravo o carregamento com o status    Fechada   
    Quando pesquiso o Carregamento gerado
    E valido que um carregamento com status não pode ser excluído    Fechada
    E fecho a tela de carregamento

Teste 02 - Validar que não é possível Excluir um carregamento com status Montando
    [Documentation]    Este teste valida que não é possível excluir um carregamento com status Montando
    [Tags]    Teste02

    Dado que eu crio uma pré-venda com rota
    Então acesso a tela de Carregamento
    E adiciono um carregamento com uma rota
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    E valido que um carregamento com status não pode ser excluído    Montando
    E fecho a tela de carregamento

Teste 03 - Carregamento vinculado a duas pré-vendas com rotas distintas
    [Documentation]    Este teste valida a criação de um carregamento vinculado a duas pré-vendas com rotas distintas
    [Tags]    Teste03

    Dado que eu crio duas pré-vendas com rotas distintas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com duas rotas
    Então gravo o carregamento com o status    Fechada
    E valido que o carregamento contém duas rotas diferentes
    E fecho a tela de carregamento

Teste 04 - Validar que um carregamento sem rota permanece com o status Cadastrando
    [Documentation]    Este teste valida a criação de um carregamento com status Cadastrando e sem uma rota vinculada
    [Tags]    Teste04

    Dado que acesso a tela de carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

Teste 05 - Validar exclusão de um carregamento com status Cadastrando
    [Documentation]    Este teste valida a exclusão de um carregamento com status Cadastrando
    [Tags]    Teste05

    Dado que acesso a tela de Carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    Quando pesquiso o Carregamento gerado
    E excluo o carregamento
    E fecho a tela de carregamento

Teste 06 - Validar que não é possível fechar uma carga sem montar e imprimir o mapa
    [Documentation]    Este teste valida que não é possível fechar uma carga sem montar e imprimir o mapa
    [Tags]    Teste06

    Dado que eu crio uma pré-venda com rota
    Então acesso a tela de Carregamento
    E adiciono um carregamento com uma rota
    Então tento fechar a carga sem montar e imprimir o mapa
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 07 - Editar um carregamento e em seguida fechar a carga
    [Documentation]    Este teste valida a edição de um carregamento e o posterior fechamento da carga
    [Tags]    Teste07

    Dado que eu crio duas pré-vendas com rotas distintas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com uma rota
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E incluo uma rota ao carregamento
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 08 - Editar um carregamento removendo a rota e revertendo para status Cadastrando
    [Documentation]    Este teste valida a edição de um carregamento removendo a rota e revertendo para status Cadastrando
    [Tags]    Teste08

    Dado que eu crio uma pré-venda com rota
    Então acesso a tela de Carregamento
    E adiciono um carregamento com uma rota
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E removo uma rota do carregamento
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

Teste 09 - Validar inclusão de rota em um carregamento com status Cadastrando
    [Documentation]    Este teste valida a inclusão de rota em um carregamento com status Cadastrando
    [Tags]    Teste09

    Dado que acesso a tela de carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

    Dado que eu crio uma pré-venda com rota
    Então acesso a tela de Carregamento
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E incluo uma rota ao carregamento
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 10 - Editar carregamento com duas rotas removendo uma e fechando com status Fechada
    [Documentation]    Este teste valida a edição de um carregamento com duas rotas, remoção de uma rota e fechamento com status Fechada
    [Tags]    Teste10

    Dado que eu crio duas pré-vendas com rotas distintas
    Então acesso a tela de Carregamento
    E adiciono um carregamento com duas rotas
    Então gravo o carregamento com o status    Montando
    E valido que o carregamento contém duas rotas diferentes
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E removo uma rota do carregamento
    Então gravo o carregamento com o status    Fechada
    E valido que o carregamento contém apenas uma rota
    E fecho a tela de carregamento