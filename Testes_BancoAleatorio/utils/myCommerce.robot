*** Settings ***
Library    SikuliLibrary

Resource    ../KeyWords/Login/KeyLoginSistema1.robot

*** Variables ***
# Sleep's
${TEMPO_TELA}     20

*** Keywords ***
Abrir MyCommerce

    Dado que eu abro o MyCommerce
    Então realizo o login no MyCommerce

Fechar MyCommerce

    Press Combination    KEY.ALT    KEY.F4

    Wait Until Screen Not Contain    ${TELA_INICIAL_SISTEMA}    ${TEMPO_TELA}