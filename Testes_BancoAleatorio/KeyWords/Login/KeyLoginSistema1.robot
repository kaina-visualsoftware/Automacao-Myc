*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../libs/verificacoesExtras.py
Library    ../../libs/configPorUsuarioWin.py

Variables    ../../libs/leituraConfig.py

Resource    ../../utils/utils.robot
Resource    ../../utils/validacaoAviso.robot

*** Variables ***
# Executável
${EXECUTAVEL_MYCOMMERCE}    C://Visual Software//MyCommerce//myCommerce.exe

# Telas
${TELA_LOGIN_SISTEMA}       tela_LoginSistema.png
${TELA_INICIAL_SISTEMA}     tela_TelaInicialSistema.png
${TELA_LIBERACAO_MENSAL}    tela_LiberacaoMensal.png

# Outros
${ICONE_USUARIO_VISUAL}     icone_UsuarioVisual.png
${LABEL_CODIGO_EMPRESA}     lb_CodigoEmpresa.png

*** Keywords ***
Dado que eu abro o MyCommerce

    Desativa avisos de inicialização nas permissões de usuário

    ${comando_mycommerce}    Get Comando Mycommerce

    Press Combination    KEY.WIN    KEY.r
    Type    ${EMPTY}    ${comando_mycommerce}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_LOGIN_SISTEMA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${TELA_LOGIN_SISTEMA}

Então realizo o login no MyCommerce

    ${qtdeEmpresa}    Valida quantidade de empresas

    IF    ${qtdeEmpresa} > 1

        Press Special Key    F1
        Press Special Key    ENTER

    END

    Key Down    CTRL
    Press Special Key    F12
    Key Up      CTRL

    Wait Until Screen Contain    ${ICONE_USUARIO_VISUAL}    ${SLEEP_ALTO}
    Type    ${EMPTY}    FELIPE
    Press Special Key    ENTER

    Garantir Caps Lock Desligado

    Type    ${EMPTY}    zwBt4@24
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Valida tela de liberação mensal

    Wait Until Screen Contain    ${TELA_INICIAL_SISTEMA}    ${TEMPO_TELA}

    Valida mensagem informativa não lida

    Valida envio de xml à contabilidade

Garantir Caps Lock Desligado

    ${caps_status}    Get Caps Lock Status
    
    IF    ${caps_status}

        Press Special Key    CAPS_LOCK
    
    END
    
Valida tela de liberação mensal

    Wait Until Screen Not Contain    ${ICONE_USUARIO_VISUAL}    ${TEMPO_TELA}

    ${tela}    Exists    ${TELA_LIBERACAO_MENSAL}

    IF    ${tela}

        Press Combination    KEY.ALT    KEY.L
        Sleep    ${SLEEP_BAIXO}

    END
