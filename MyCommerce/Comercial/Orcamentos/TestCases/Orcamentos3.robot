*** Settings ***
Documentation    Testes Geração de venda e OS oriunda de orçamentos com desconto e acrescimo

Resource    ../KeyWords/KeyOrcamentos3.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43

*** Test Cases ***