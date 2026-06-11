*** Settings ***

Documentation    Testes em Banco Aleatório

Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/parametros_pre_condicoes.robot
Resource   ${EXECDIR}/Testes_BancoAleatorio/utils/montadorDeCenarios.robot
Resource  ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Locacao/Keylocacao1.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***

Validar keywords novas
    [Tags]    Teste01

    Dado que acesso a tela lançamento de locação
    