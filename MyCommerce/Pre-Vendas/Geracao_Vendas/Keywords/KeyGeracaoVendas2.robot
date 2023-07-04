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
${TELA_AVISO_GERAR_VENDA}    aviso_DesejaVenda.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${AVISO_DESC_SUPERIOR}       aviso_DescontoExcede_GeracaoVenda.png
#Botões
${CHECK_PEDIDOSEPARADOS}     checkBox_PedidosSeparados.png
${COL_PEDIDO}                col_Pedido.png

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
    Press Combination    KEY.ALT     Key.L 
    Sleep    ${SLEEP_BAIXO}

    Ordena do último para o primeiro

E seleciono um pedido
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE 
    Sleep    ${SLEEP_BAIXO}

    Recupera código pedido

#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_#
Ordena do último para o primeiro
    SikuliLibrary.Click    ${COL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${COL_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

Recupera código pedido
    ${consulta}    Query    SELECT Codigo FROM pedidosvenda WHERE Separado = 1 AND VendaGerada IS NULL ORDER BY Codigo DESC LIMIT 1
    
    Set Test Variable    ${COD_PEDIDO}    ${consulta[0][0]}