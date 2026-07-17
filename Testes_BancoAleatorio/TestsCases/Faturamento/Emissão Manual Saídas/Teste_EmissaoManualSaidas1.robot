*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Faturamento/Emissão Manual Saídas/KeyEmissaoManualSaidas1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***

Teste 01 – Lançamento de nota fiscal de saída com preenchimento manual
    [Tags]    Teste01

    Dado que eu acesso a tela de lançamento de nota fiscal preenchimento manual
    E adiciono vendedor e cliente
    Quando informo um produto normal
    E acesso a aba pagamentos
    Então finalizo a nota fiscal de saída manual
    E saio da tela(NFeSaidasManual)