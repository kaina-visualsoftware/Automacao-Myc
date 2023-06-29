*** Settings ***
Documentation    Testes Pedidos pré-venda

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    C:\\Automacao\\MyCommerce-Automacao\\MyCommerce\\libs\\verificaProduto.py 

*** Variables ***
${IMAGES}                    ./MyCommerce/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    bdvinicius
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${TELA_GERACAO_VENDA}        tela_GeracaoVenda.png
#Botões
${CHECK_PEDIDOSEPARADOS}     checkBox_PedidosSeparados.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de geração de vendas 
    Sleep    ${SLEEP_BAIXO}
    Type With Modifiers    G     CTRL
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_GERACAO_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Verifica pedidos separados 

    Press Combination    KEY.ALT     Key.L 
    Sleep    ${SLEEP_BAIXO}

#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_#
Verifica pedidos separados 
    Sleep    ${SLEEP_BAIXO}

    ${coor_PedSeparado}    Create List    402    439    16    15

    Sleep    ${SLEEP_BAIXO}
    ${campo}    Exists    ${CHECK_PEDIDOSEPARADOS}

    IF    ${campo} == ${True}

        SikuliLibrary.Click On Region    ${coor_PedSeparado}
        Sleep    ${SLEEP_BAIXO}

    END


