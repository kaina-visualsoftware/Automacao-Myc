*** Settings ***
Library    SikuliLibrary    mode=NEW

Resource    ../KeyWords/Login/KeyLoginSistema1.robot

*** Variables ***
# Sleep's
${TEMPO_TELA}     20

*** Keywords ***
Abrir MyCommerce

    Dado que eu abro o MyCommerce
    Então realizo o login no MyCommerce

Fechar MyCommerce

    Run Process    cmd.exe    /c    taskkill /IM myCommerce.exe /F    shell=True