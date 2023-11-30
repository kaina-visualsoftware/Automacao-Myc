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
${DBHost}                                10.1.1.220   
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens Telas
${TELA_CONDICIONAIS}                     tela_Condicionais.png 
${TELA_ADICIONAR_CONDICIONAL}            tela_CondicionaisAdicionar.png
${TELA_DETALHES_CONDICIONAL}             tela_DetalhesCondicional.png
${TELA_VISUALIZA_CONDICIONAL}            tela_VisualizaVenda.png 
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${AVISO_DESEJA_EXCLUIR}                  aviso_DesejaExcluir.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de condicionais
    
    Press Special Key    F11
    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}
    Verifica parametros que interferem na venda

E adiciono uma nova Condicional

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADICIONAR_CONDICIONAL}    ${TEMPO_TELA}

    ${Consulta}    Query    SELECT Codigo FROM condicionais ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_CONDICIONAL}    ${Consulta[0][0]}
    Log To Console    ${COD_CONDICIONAL}

Quando insiro vendedor e cliente

    utils.Adicionar Vendedor e Cliente(Condicional)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E insiro um produto normal

    IF     ${Parametro_VendeSemEstoqueCondicional}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE
        
        utils.Inserir Produto normal - Necessita de estoque

    END

    utils.Valida parametros após incluir produto

Então finalizo a condicional 
    
    Press Combination    KEY.ALT     Key.D
    Wait Until Screen Contain    ${TELA_DETALHES_CONDICIONAL}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Automacao Condicional
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    Valida impressao direta de venda(${Parametro_ImprimeCondicional})

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

Então visualizo a condicional

    Press Combination    KEY.ALT     Key.U
    Wait Until Screen Contain    ${TELA_VISUALIZA_CONDICIONAL}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.r

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

Quando clico em editar 
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E
    Wait Until Screen Contain    ${TELA_ADICIONAR_CONDICIONAL}    ${TEMPO_TELA}

Então excluo a condicional

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.x

    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Exclusao de Condicional - Teste Automacao
    Press Special Key    TAB
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitacao de senha do usuário

    Check If Exists In Database    SELECT * FROM condicionais WHERE Codigo = ${COD_CONDICIONAL} AND `Status` LIKE 'x'
