*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot
Resource    ../../../utils/montadorDeCenarios.robot

*** Variables ***
#Imagens
${IMAGENS}    ./testes_bancoAleatorio/images

#Conexão com banco de dados
${DBHost}                                      ${config.IpServidor}
${DBName}                                      ${config.Database}
${DBPass}                                      vssql
${DBPort}                                      ${config.Porta}
${DBUser}                                      root

#Sleep's
${SLEEP_BAIXO}                                 0.7
${SLEEP_MEDIO}                                 1.7
${SLEEP_ALTO}                                  3
${TEMPO_TELA}                                  20

${MENU_COMERCIAL}       menu_Comercial.png
${SUBMENU_DOACOES}      subMenu_Doacoes.png
${TELA_DOACOES}         tela_Doacoes.png
${TELA_LANC_DOACOES}    tela_LancDoacoes.png
${ABA_DETALHES}         aba_Detalhes.png
${TELA_IMPRESSAO}       tela_Impressao.png
${BT_ADICIONAR}         bt_Adicionar.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu acesso a tela de doações

    SikuliLibrary.Click    ${MENU_COMERCIAL}
    Wait Until Screen Contain    ${SUBMENU_DOACOES}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${SUBMENU_DOACOES}
    Wait Until Screen Contain    ${TELA_DOACOES}    ${TEMPO_TELA}

Quando eu clico em adicionar

    Verifica parametros que interferem na venda
    
    Sleep    ${SLEEP_BAIXO}
    #Press Combination    KEY.ALT    KEY.A
    SikuliLibrary.Click    ${BT_ADICIONAR}
    Wait Until Screen Contain    ${TELA_LANC_DOACOES}    ${TEMPO_TELA}

    Última doação feita/em aberto

Última doação feita/em aberto
    
    Sleep    ${SLEEP_MEDIO}
    ${Consulta}    Query    SELECT d.Codigo FROM doacoes d ORDER BY d.Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_DOACAO}    ${Consulta[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Log To Console    \nCódigo doação: ${COD_DOACAO}

E adiciono vendedor e cliente

    utils.Adicionar Vendedor e Cliente(Doação)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando insiro um produto normal
    
    IF     ${Parametro_VendeSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE
        
        utils.Inserir Produto normal - Necessita de estoque

    END

    utils.Valida parametros após incluir produto

E acesso a aba detalhes

    Press Combination    KEY.ALT    KEY.D
    Wait Until Screen Contain    ${ABA_DETALHES}    ${TEMPO_TELA}

Então finalizo a doação
    
    Input Text    ${EMPTY}    Lancamento de Doacao - Teste Automacao
    Press Special Key    TAB
    Press Combination    KEY.ALT    KEY.F

    Valida impressão de doação
    
    Wait Until Screen Contain    ${TELA_DOACOES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

Valida impressão de doação

    ${impressaoDoacao}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${SLEEP_ALTO}

    IF    ${impressaoDoacao}

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_BAIXO}
        
    END