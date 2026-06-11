*** Settings ***
Resource    ../../KeyWords/Login/KeyLoginSistema1.robot
Resource    ../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce

*** Test Cases ***
Teste 01 - Login no MyCommerce
    [Tags]    Teste01
    
    Dado que eu abro o MyCommerce
    Então realizo o login no MyCommerce