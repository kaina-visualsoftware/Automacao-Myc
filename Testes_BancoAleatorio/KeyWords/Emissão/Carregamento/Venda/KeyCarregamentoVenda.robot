*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    Process

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot


*** Variables ***

# TELAS
${MENU_EMISSÃO}                         menu_Emissão.png
${SUBMENU_CARREGAMENTO}                 subMenu_Carregamento.png
${TELA_CARREGAMENTO}                    tela_Carregamentos.png
${TELA_CARREGAMENTO_ADICIONAR}          tela_CarregamentoAdicionar.png

# BOTÕES
${BT_ADICIONAR}                         bt_Adicionar.png
${BT_GRAVAR}                            bt_Gravar.png
${BT_EDITAR}                            bt_Editar.png
${BT_EXCLUIR}                           bt_Excluir.png
${BT_SALVAR}                            bt_Salvar.png
${BT_LISTAR}                            bt_Listar.png
${BT_INCLUIR_VENDA_CARREGAMENTO}         bt_IncluirVendaCarregamento.png

# AVISOS
${AVISO_EXCLUIR_CARREGAMENTO}           aviso_ExcluirCarregamento.png
${AVISO_CANCELAR_CARREGAMENTO}          aviso_CancelarCarregamento.png
${AVISO_EXCLUIR_CARREGAMENTO_FECHADO}    aviso_ExcluirCarregamentoFechado.png

#CHECKBOX
${CHECKBOX_TODOS_ITENS}                 checkbox_SelecionadoTodosCarregamentoVenda.png


#LABEL
${LB_NVENDA_CARREGAMENTO}              lb_NVendaCarregamento.png

# VARIÁVEIS
${COD_CARREGAMENTO}                     NONE


*** Keywords ***

Dado que acesso o lançamento de carregamento de vendas
    Wait Until Screen Contain    ${MENU_EMISSÃO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${MENU_EMISSÃO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${SUBMENU_CARREGAMENTO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${SUBMENU_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}


Quando inicio um novo carregamento
    SikuliLibrary.Click    ${BT_ADICIONAR}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}


E informo uma descrição valida
    ${RANDOM}=    Evaluate    random.randint(1000,9999)    modules=random

    SikuliLibrary.Input Text    ${EMPTY}    AUTOMACAO - ${RANDOM}
    Sleep    ${SLEEP_BAIXO}


E gravo o carregamento da venda
    SikuliLibrary.Click    ${BT_GRAVAR}
    Sleep    ${SLEEP_BAIXO}


Então o carregamento da venda deve ser salvo com sucesso
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}

Então o status deve ser "Cadastrando"
    ${status}=    Query    SELECT c.Status FROM cargas c ORDER BY c.Sequencia DESC LIMIT 1;

    Should Be Equal As Strings    ${status[0][0]}    Cadastrando


E que existe um carregamento cadastrado
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL ORDER BY c.Sequencia DESC LIMIT 1;

    Should Not Be Empty    ${resultado}

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}


E que existe um carregamento com status
    [Arguments]    ${status}

    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL AND c.Status = '${status}' ORDER BY c.Sequencia DESC LIMIT 1;

    Should Not Be Empty    ${resultado}

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}


Quando pesquiso o carregamento
    [Arguments]    ${codigo}

    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${codigo}

    Press Special Key    ENTER


Quando limpo o filtro da pesquisa
    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${EMPTY}

    Press Special Key    ENTER


Quando edito o carregamento cadastrado
    Quando pesquiso o carregamento    ${COD_CARREGAMENTO}

    SikuliLibrary.Click    ${BT_EDITAR}
    Sleep    ${SLEEP_BAIXO}


Quando excluo o carregamento
    Quando pesquiso o carregamento    ${COD_CARREGAMENTO}

    SikuliLibrary.Click    ${BT_EXCLUIR}
    Sleep    ${SLEEP_BAIXO}

    ${aviso_excluir}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    3

    IF    ${aviso_excluir}
        Press Combination    KEY.ALT    KEY.S
    END

    ${aviso_cancelar}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CANCELAR_CARREGAMENTO}    3

    IF    ${aviso_cancelar}
        Press Combination    KEY.ALT    KEY.S
    END

Quando incluo uma venda no carregamento
    Quando pesquiso o carregamento    ${COD_CARREGAMENTO}

    SikuliLibrary.Click    ${BT_EDITAR}
    Sleep    ${SLEEP_BAIXO}
    
    ${BT_INCLUIR_VENDA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_VENDA_CARREGAMENTO}    5
    IF    ${BT_INCLUIR_VENDA}
        SikuliLibrary.Click    ${BT_INCLUIR_VENDA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

    ${BT_LISTAR_VENDAS}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_LISTAR}    5
    IF    ${BT_LISTAR_VENDAS}
        SikuliLibrary.Click    ${BT_LISTAR}
        Sleep    ${SLEEP_BAIXO}
    END

    Seleciono a última venda disponível

    SikuliLibrary.Click    ${BT_SALVAR}
    Sleep    ${SLEEP_BAIXO} 


Seleciono a última venda disponível
    SikuliLibrary.Click    ${CHECKBOX_TODOS_ITENS}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3 
        Press Special Key    TAB 
    END

    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}
    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}

    Press Combination    KEY.CTRL    KEY.HOME

    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${BT_ADICIONAR}
    Sleep    ${SLEEP_BAIXO}


Então o carregamento deve ser excluído com sucesso
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL;

    Should Be Empty    ${resultado}


Então o sistema deve impedir a exclusão
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL;

    Should Not Be Empty    ${resultado}
    
    ${aviso_excluir_carregamento_fechado}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO_FECHADO}    3

    IF    ${aviso_excluir_carregamento_fechado}
        SikuliLibrary.Click    ${BT_OK}
        Sleep    ${SLEEP_BAIXO}
    END

Então fecho a tela de carregamento
    Run Keyword And Ignore Error    Press Special Key    ESC