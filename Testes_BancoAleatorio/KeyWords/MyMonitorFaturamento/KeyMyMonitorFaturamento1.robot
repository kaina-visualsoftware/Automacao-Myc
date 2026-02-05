*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary

Variables    ../../libs/leituraConfig.py

Resource    ../../utils/validacaoAviso.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                            ./testes_bancoAleatorio/images

# Conexão MySQL
${DBHost}                             ${config.IpServidor}
${DBName}                             ${config.Database}
${DBPass}                             vssql
${DBPort}                             ${config.Porta}
${DBUser}                             root

# Sleep's
${SLEEP_BAIXO}                        0.7
${SLEEP_MEDIO}                        1.5
${SLEEP_ALTO}                         3
${TEMPO_TELA}                         20

# Telas
${TELA_MY_MONITOR_FATURAMENTO}        tela_MyMonitorFaturamento.png
${TELA_GUIA_CONFIGURACOES}            tela_GuiaConfiguracoes.png
${TELA_GUIA_CONFIGURACOES_EXTRAS}     tela_GuiaConfiguracoesExtras.png

# Telas avisos
${AVISO_ENCERRAR_MYMONITOR}           aviso_EncerrarMyMonitorFat.png

# Outros
${LABEL_GUIA_CONFIGURACOES}           lb_GuiaConfiguracoes.png
${LABEL_GUIA_CONTINGENCIA}            lb_GuiaContingencia.png
${LABEL_GUIA_CONFIGURACOES_EXTRAS}    lb_GuiaConfiguracoesExtras.png
${ICONE_MYMONITOR_INATIVO}            icone_MyMonitorInativo.png

# Mensagem de Erro
${ERRO_RUN_TIME_ERROR}                run-timeerror.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso o MyMonitorFaturamento

    Configurar myMonitorFaturamento inativo

    Press Combination    KEY.WIN    KEY.R

    Type    ${EMPTY}    C://Visual Software//MyCommerce//MyMonitorFaturamento.exe

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

E encerro o myMonitorFaturamento
    
    Sleep    ${SLEEP_BAIXO}
    ${iconeMyMonitor}    Exists    ${ICONE_MYMONITOR_INATIVO}

    IF    ${iconeMyMonitor}

        SikuliLibrary.Right Click    ${ICONE_MYMONITOR_INATIVO}
        Sleep    ${SLEEP_BAIXO}
        
        Press Special Key    DOWN
        Press Special Key    DOWN

        Press Special Key    ENTER

        Wait Until Screen Contain    ${AVISO_ENCERRAR_MYMONITOR}    ${TEMPO_TELA}

        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

        #Wait Until Screen Not Contain    ${ICONE_MYMONITOR_INATIVO}    ${TEMPO_TELA}
        
    END

Configurar myMonitorFaturamento inativo

    ${monitor_ativo}    Query    SELECT MonitorAtivo FROM faturamento_monitor_config;

    ${qtd_registros}    Get Length    ${monitor_ativo}

    IF    ${qtd_registros} == 0
        RETURN
    END

    IF    '${monitor_ativo[0][0]}' == '1'
        Execute Sql String    UPDATE faturamento_monitor_config SET MonitorAtivo = 0;
    END