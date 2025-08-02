*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary

Variables    ../../libs/leituraConfig.py

Resource    ../../utils/utils.robot
Resource    ../../utils/validacaoAviso.robot

*** Variables ***
# Executável
${EXECUTAVEL_MYCOMMERCE}    C://Visual Software//MyCommerce//myCommerce.exe

# Repositório de Imagens
${IMAGES}                   ./testes_bancoAleatorio/images

# Conexão MySQL
${DBHost}                   ${config.IpServidor}
${DBName}                   ${config.Database}
${DBPass}                   vssql
${DBPort}                   ${config.Porta}
${DBUser}                   root

# Sleep's
${SLEEP_BAIXO}              0.7
${SLEEP_MEDIO}              1.5
${SLEEP_ALTO}               3
${TEMPO_TELA}               20

# Telas
${TELA_LOGIN_SISTEMA}       tela_LoginSistema.png
${TELA_INICIAL_SISTEMA}     tela_TelaInicialSistema.png

# Outros
${ICONE_USUARIO_VISUAL}     icone_UsuarioVisual.png
${LABEL_CODIGO_EMPRESA}     lb_CodigoEmpresa.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que eu abro o MyCommerce

    Press Combination    KEY.WIN    KEY.r
    Input Text    ${EMPTY}    ${EXECUTAVEL_MYCOMMERCE}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_LOGIN_SISTEMA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    # SikuliLibrary.Click    ${TELA_LOGIN_SISTEMA}

Então realizo o login no MyCommerce

    ${qtdeEmpresa}    Valida quantidade de empresas

    IF    ${qtdeEmpresa} > 1

        SikuliLibrary.Click    ${LABEL_CODIGO_EMPRESA}
        Press Special Key    F1
        Press Special Key    ENTER 
        
    END

    Key Down    CTRL
    Press Special Key    F12
    Key Up      CTRL

    Wait Until Screen Contain    ${ICONE_USUARIO_VISUAL}    ${SLEEP_ALTO}
    Input Text    ${EMPTY}    FELIPE
    Press Special Key    ENTER

    Input Text    ${EMPTY}    zwBt4@24
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_INICIAL_SISTEMA}    ${TEMPO_TELA}

    Valida avisos de inicialização