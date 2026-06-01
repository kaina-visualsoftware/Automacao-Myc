*** Settings ***
Documentation    Testes em Banco Aleatório


Resource  ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/KeyCarregamento1.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/parametros_pre_condicoes.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar




*** Test Cases ***

Teste 01 - Validar que não é possível excluir um carregamento com status Fechada
    [Documentation]    Este teste valida que não é possível excluir um carregamento com status Fechada
    [Tags]    Teste01
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio uma pré-venda com rota

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então gravo o carregamento com o status    Fechada   
    Quando pesquiso o Carregamento gerado
    E valido que um carregamento com status não pode ser excluído    Fechada
    E fecho a tela de carregamento

Teste 02 - Validar que não é possível Excluir um carregamento com status Montando
    [Documentation]    Este teste valida que não é possível excluir um carregamento com status Montando
    [Tags]    Teste02
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio uma pré-venda com rota

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    E valido que um carregamento com status não pode ser excluído    Montando
    E fecho a tela de carregamento

Teste 03 - Carregamento vinculado a duas pré-vendas com rotas distintas
    [Documentation]    Este teste valida a criação de um carregamento vinculado a duas pré-vendas com rotas distintas
    [Tags]    Teste03
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio pré-vendas com rotas distintas    3

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    3
    Então gravo o carregamento com o status    Fechada
    E valido que o carregamento contém as rotas esperadas
    E fecho a tela de carregamento

Teste 04 - Validar que um carregamento sem rota permanece com o status Cadastrando
    [Documentation]    Este teste valida a criação de um carregamento com status Cadastrando e sem uma rota vinculada
    [Tags]    Teste04
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

Teste 05 - Validar exclusão de um carregamento com status Cadastrando
    [Documentation]    Este teste valida a exclusão de um carregamento com status Cadastrando
    [Tags]    Teste05
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de Carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    Quando pesquiso o Carregamento gerado
    E excluo o carregamento
    E fecho a tela de carregamento

Teste 06 - Validar que não é possível fechar uma carga sem montar e imprimir o mapa
    [Documentation]    Este teste valida que não é possível fechar uma carga sem montar e imprimir o mapa
    [Tags]    Teste06
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio uma pré-venda com rota

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então tento fechar a carga sem montar e imprimir o mapa
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 07 - Editar um carregamento e em seguida fechar a carga
    [Documentation]    Este teste valida a edição de um carregamento e o posterior fechamento da carga
    [Tags]    Teste07
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio pré-vendas com rotas distintas    2

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E incluo uma rota ao carregamento
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 08 - Editar um carregamento removendo a rota e revertendo para status Cadastrando
    [Documentation]    Este teste valida a edição de um carregamento removendo a rota e revertendo para status Cadastrando
    [Tags]    Teste08
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio uma pré-venda com rota

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então gravo o carregamento com o status    Montando
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E removo uma rota do carregamento
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

Teste 09 - Validar inclusão de rota em um carregamento com status Cadastrando
    [Documentation]    Este teste valida a inclusão de rota em um carregamento com status Cadastrando
    [Tags]    Teste09
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de carregamento
    E adiciono um carregamento sem rota
    Então gravo o carregamento com o status    Cadastrando
    E fecho a tela de carregamento

    Dado que eu crio uma pré-venda com rota
    Dado que acesso a tela de Carregamento
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E incluo uma rota ao carregamento
    Então gravo o carregamento com o status    Fechada
    E fecho a tela de carregamento

Teste 10 - Editar carregamento com duas rotas removendo uma e fechando com status Fechada
    [Documentation]    Este teste valida a edição de um carregamento com duas rotas, remoção de uma rota e fechamento com status Fechada
    [Tags]    Teste10
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio pré-vendas com rotas distintas    2

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    2
    Então gravo o carregamento com o status    Montando
    E valido que o carregamento contém as rotas esperadas
    Quando pesquiso o Carregamento gerado
    Então edito o carregamento
    E removo uma rota do carregamento
    Então gravo o carregamento com o status    Fechada
    E valido que o carregamento contém as rotas esperadas
    E fecho a tela de carregamento

Teste 11 - Validar obrigatoriedade da descrição ao montar carga
    [Documentation]    Este teste valida o bloqueio ao tentar montar uma carga sem informar descrição
    [Tags]    Teste11
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio uma pré-venda com rota

    Dado que eu crio uma pré-venda com rota
    Dado que acesso a tela de Carregamento
    E adiciono um carregamento com rota sem informar descrição
    Quando eu tento montar a carga sem descrição
    Então valido a mensagem de descrição obrigatória
    E informo uma descrição
    Então gravo o carregamento com o status    Montando
    E fecho a tela de carregamento

Teste 12 - Validar volume de pré-vendas após remoção em um carregamento
    [Documentation]    Este teste valida que o campo volume do carregamento é atualizado corretamente quando uma pré-venda é removida
    [Tags]    Teste12
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   2
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    MontadordeCenarios.Dado que eu crio pré-vendas com a mesma rota    2  

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    1
    Então gravo o carregamento com o status    Cadastrando
    Quando pesquiso o Carregamento gerado
    E valido o volume inicial do carregamento como cadastrando
    Então edito o carregamento
    E removo um dos pedidos da rota
    Então gravo o carregamento com o status    Montando
    E valido o volume após remover uma pré-venda
    E fecho a tela de carregamento


Teste 13 - Lancamento de carregamento de venda
    [Tags]    Teste13
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    E fecho a tela de carregamento


Teste 14 - Validar status inicial do carregamento
    [Tags]    Teste14
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
    E gravo o carregamento da venda
    Então o status deve ser    Cadastrando
    E fecho a tela de carregamento


Teste 15 - Editar carregamento adicionando venda
    [Tags]    Teste15
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso a tela de Carregamento
    Quando edito o carregamento cadastrado
    E incluo vendas no carregamento    1
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    E fecho a tela de carregamento


Teste 16 - Excluir carregamento com status cadastrando
    [Tags]    Teste16
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda

    Dado que acesso a tela de Carregamento
    Quando excluo o carregamento
    Então o carregamento deve ser excluído com sucesso
    E fecho a tela de carregamento


Teste 17 - Nao permitir excluir carregamento fechado
    [Tags]    Teste17
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda
 
    Dado que acesso a tela de Carregamento
    E que existe um carregamento com status    Fechada
    Quando excluo o carregamento
    Então o sistema deve impedir a exclusão
    E fecho a tela de carregamento


Teste 18 - Incluir uma venda no carregamento
    [Tags]    Teste18
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
    E incluo vendas no carregamento    1
    Então a venda deve ser incluída com sucesso no carregamento
    E fecho a tela de carregamento


Teste 19 - Incluir multiplas vendas no carregamento
    [Tags]    Teste19
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(3)

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
    E incluo vendas no carregamento    3
    Então a venda deve ser incluída com sucesso no carregamento
    E fecho a tela de carregamento


Teste 20 - Incluir cobranca no carregamento
    [Tags]    Teste20
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
    E incluo vendas no carregamento    1
    E incluo uma cobrança no carregamento
    Então o carregamento da venda deve ser salvo com sucesso
    E fecho a tela de carregamento


Teste 21 - Editar carregamento incluindo venda e cobranca
    [Tags]    Teste21
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)
    ...    AND    montadorDeCenarios.Dado que realizo um carregamento de venda
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso a tela de Carregamento
    Quando edito o carregamento cadastrado
    E incluo vendas no carregamento    1
    E incluo uma cobrança no carregamento
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    E fecho a tela de carregamento


Teste 22 - Realizar embarque do carregamento
    [Tags]    Teste22
    [Setup]    Run Keywords
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    CARGA_VENDAS   1
    ...    AND    Inicializar Pré-Condições
    ...    AND    Reiniciar MyCommerce Se Necessário
    ...    AND    montadorDeCenarios.Dado que realizo mais de uma venda(1)

    Dado que acesso a tela de Carregamento
    E clico para adicionar um carregamento
    E informo uma descrição valida
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
    E fecho a tela de carregamento
