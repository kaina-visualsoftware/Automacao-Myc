*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Library    ../libs/verificacoesExtras.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.247
${DBName}                                ${config.Database}
${DBPass}                                vssql@1234
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens Telas
${TELA_DEVOLUÇÕES}                       tela_Devolucoes.png
${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}      tela_DevolucaoAvulsaAdicionar.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que abro a tela de Devolução de vendas/os 

    Verifica parametros que interferem na venda

    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando adiciono uma nova devolução 

    Press Combination    KEY.ALT     Key.A

    IF     ${Parametro_DevolucaoAvulsa}

        Adicionando Devolução avulsa 

    END   

Adicionando Devolução avulsa 
    
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E insiro os dados do cabeçalho - vendedor, venda|cliente 
    
    IF     ${Parametro_DevolucaoAvulsa}

        utils.Adicionar Vendedor e Cliente(Devolução)

        Verifica se condicional existe(${Codigo_Cliente})

    END
