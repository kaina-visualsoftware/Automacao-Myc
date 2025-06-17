*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary

Variables    leituraConfig

Resource    ../../utils/validacaoAviso.robot

*** Variables ***
# Repositório de Imagens
${IMAGES}                                ./Testes_BancoAleatório/images

# Conexão MySQL
${DBHost}                                ${config.IpServidor}
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root

# Sleep's
${SLEEP_BAIXO}                           0.7
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20

# Telas
${TELA_MY_MONITOR_FATURAMENTO}           tela_MyMonitorFaturamento.png
${TELA_GUIA_CONFIGURACOES}               tela_GuiaConfiguracoes.png
${TELA_GUIA_CONFIGURACOES_EXTRAS}        tela_GuiaConfiguracoesExtras.png

# Outros
${LABEL_GUIA_CONFIGURACOES}              lb_GuiaConfiguracoes.png
${LABEL_GUIA_CONTINGENCIA}               lb_GuiaContingencia.png
${LABEL_GUIA_CONFIGURACOES_EXTRAS}       lb_GuiaConfiguracoesExtras.png

# Mensagem de Erro
${ERRO_RUN_TIME_ERROR}                   run-timeerror.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso o MyMonitorFaturamento

    Press Combination    KEY.WIN    KEY.R

    Input Text    ${EMPTY}    C://Visual Software//MyCommerce//MyMonitorFaturamento.exe

    Press Special Key    ENTER

    Valida mensagens de erro

    Wait Until Screen Contain    ${TELA_MY_MONITOR_FATURAMENTO}    ${TEMPO_TELA}

E acesso a guia 'Configurações'

    SikuliLibrary.Click    ${LABEL_GUIA_CONFIGURACOES}
    Wait Until Screen Contain    ${TELA_GUIA_CONFIGURACOES}    ${TEMPO_TELA}

E acesso a guia 'Contigência'

    SikuliLibrary.Click    ${LABEL_GUIA_CONTINGENCIA}
    Sleep    ${SLEEP_BAIXO}

E acesso a guia 'Configurações extras'

    SikuliLibrary.Click    ${LABEL_GUIA_CONFIGURACOES_EXTRAS}
    Wait Until Screen Contain    ${TELA_GUIA_CONFIGURACOES_EXTRAS}    ${TEMPO_TELA}

Então salvo as configurações

    Press Combination    KEY.ALT    KEY.S
    ${selecao_coi}    Valida seleção de coi para faturamento

    IF    ${selecao_coi}

        Press Combination    KEY.ALT    KEY.S
        
    END

    Wait Until Screen Not Contain    ${TELA_GUIA_CONFIGURACOES}    ${TEMPO_TELA}

    Valida mensagens de erro

Valida mensagens de erro
    
    Sleep    ${SLEEP_BAIXO}
    ${run_time_error}    Exists    ${ERRO_RUN_TIME_ERROR}

    IF    ${run_time_error}
        
        Fail    Run-time error.
        
    END