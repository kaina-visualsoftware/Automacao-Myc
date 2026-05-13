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
${TELA_CONTAS_A_RECEBER_CARREGAMENTO}   tela_ContasReceberCarregamento.png
${TELA_GERACAO_LOTE_COBRANCA_CARREGAMENTO}    tela_GeracaoLoteCobrancaCarregamento.png

# BOTÕES
${BT_ADICIONAR}                         bt_Adicionar.png
${BT_GRAVAR}                            bt_Gravar.png
${BT_EDITAR}                            bt_Editar.png
${BT_EXCLUIR}                           bt_Excluir.png
${BT_SALVAR}                            bt_Salvar.png
${BT_LISTAR}                            bt_Listar.png
${BT_INCLUIR_VENDA_CARREGAMENTO}        bt_IncluirCarregamentoVenda.png
${BT_INCLUIR_COBRANÇA_CARREGAMENTO}     bt_IncluirCarregamentoCobranca.png


# INPUT
${INPUT_CODCOBRADOR_CARREGAMENTO}       input_CodCobrador.png

# AVISOS
${AVISO_EXCLUIR_CARREGAMENTO}           aviso_ExcluirCarregamento.png
${AVISO_CANCELAR_CARREGAMENTO}          aviso_CancelarCarregamento.png
${AVISO_EXCLUIR_CARREGAMENTO_FECHADO}    aviso_ExcluirCarregamentoFechado.png

#CHECKBOX
${CHECKBOX_TODOS_ITENS}                 checkbox_SelecionadoTodosCarregamentoVenda.png
${CHECKBOX_COBRANCA_CARREGAMENTO}      checkbox_ContasaReceberCobrancaCarregamento.png


#LABEL
${LB_NVENDA_CARREGAMENTO}              lb_NVendaCarregamento.png
${LB_NDOCUMENTO}                      lb_NDocumento.png

# VARIÁVEIS
${COD_CARREGAMENTO}                     NONE
${QTD_VENDAS_INCLUIDAS}                 NONE
@{ULTIMAS_VENDAS}


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

    Setar codigo carregamento


E informo uma descrição valida
    ${RANDOM}=    Evaluate    random.randint(1000,9999)    modules=random

    SikuliLibrary.Input Text    ${EMPTY}    AUTOMACAO - ${RANDOM}
    Sleep    ${SLEEP_BAIXO}


E gravo o carregamento da venda
    ${TELA_CARREGAMENTO_BOOL}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    15
    IF    ${TELA_CARREGAMENTO_BOOL}
        SikuliLibrary.Click    ${TELA_CARREGAMENTO_ADICIONAR}
        Sleep    ${SLEEP_BAIXO}
    END

    ${BT_GRAVAR_CARREGAMENTO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_GRAVAR}    15
    IF    ${BT_GRAVAR_CARREGAMENTO}
        SikuliLibrary.Click    ${BT_GRAVAR}
        Sleep    ${SLEEP_BAIXO}
    END


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

Setar codigo carregamento
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL ORDER BY c.Sequencia DESC LIMIT 1;
    
    IF    not ${resultado}
        RETURN    0
    END

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}

E incluo uma cobrança para a venda incluída
    @{ULTIMAS_VENDAS}=   Pegar ultimas vendas do carregamento
    
    ${BT_INCLUIR_COBRANCA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}    5
    IF    ${BT_INCLUIR_COBRANCA}
        SikuliLibrary.Click    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

    ${TELA_GERACAO_LOTE_COBRANCA_CARREGAMENTO_BOOL}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_GERACAO_LOTE_COBRANCA_CARREGAMENTO}    15
    IF    ${TELA_GERACAO_LOTE_COBRANCA_CARREGAMENTO_BOOL}
        
        ${INPUT_CODCOBRADOR_CARREGAMENTO_BOOL}=    Run Keyword And Return Status    Wait Until Screen Contain    ${INPUT_CODCOBRADOR_CARREGAMENTO}    15
        IF    ${INPUT_CODCOBRADOR_CARREGAMENTO_BOOL}
            SikuliLibrary.Click    ${INPUT_CODCOBRADOR_CARREGAMENTO}
            Sleep    ${SLEEP_BAIXO}
        END

        Input Text    ${EMPTY}    2
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
    END

    FOR    ${COD_VENDA}    IN    @{ULTIMAS_VENDAS}
        ${DOCUMENTO}=    Pegar documento da venda sem cobrança    ${COD_VENDA}

        ${BT_LISTAR_COBRANCAS}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_LISTAR}    15
        IF    ${BT_LISTAR_COBRANCAS}
            SikuliLibrary.Click    ${BT_LISTAR}
            Sleep    ${SLEEP_BAIXO}
        END
        
        Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    ${TEMPO_TELA}

        Selecionar cobrança pelo documento    ${DOCUMENTO}
    END
    
    ${BT_GRAVAR_COBRANCAS}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_GRAVAR}    15
    IF    ${BT_GRAVAR_COBRANCAS}
        SikuliLibrary.Click    ${BT_GRAVAR}
        Sleep    ${SLEEP_MEDIO}
    END


Pegar ultimas vendas do carregamento
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.CodigoCarregamento = ${COD_CARREGAMENTO} ORDER BY v.Codigo DESC;
    IF    not${resultado}
        RETURN    ${EMPTY}
    END

    ${VENDAS}=    Evaluate    [item[0] for item in $resultado]

    RETURN    ${VENDAS}

Quando pesquiso o carregamento
    [Arguments]    ${codigo}

    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${codigo}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}


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

E e edito o carregamento cadastrado
    Quando pesquiso o carregamento    ${COD_CARREGAMENTO}

    SikuliLibrary.Click    ${BT_EDITAR}
    Sleep    ${SLEEP_BAIXO}

Quando incluo uma venda no carregamento (${QTD_VENDAS})
    ${QTD_VENDAS_INCLUIDAS}=    Pegar quantidade de vendas incluídas no carregamento
    Log    Quantidade atual: ${QTD_VENDAS_INCLUIDAS}
    ${QTD_VENDAS_INCLUIDAS}=    Evaluate    ${QTD_VENDAS_INCLUIDAS} + ${QTD_VENDAS}
    Set Suite Variable    ${QTD_VENDAS_INCLUIDAS}    ${QTD_VENDAS_INCLUIDAS}
    Log    Quantidade esperada após inclusão: ${QTD_VENDAS_INCLUIDAS}

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

    FOR    ${INDEX}    IN RANGE    ${QTD_VENDAS}
        Seleciono a próxima venda disponível
    END

    SikuliLibrary.Click    ${BT_SALVAR}
    Sleep    ${SLEEP_BAIXO} 


Pegar quantidade de vendas incluídas no carregamento
     log    message="Consultando quantidade de vendas incluídas no carregamento ${COD_CARREGAMENTO}"
     ${resultado}=    Query    SELECT COUNT(*) FROM vendas v WHERE v.CodigoCarregamento = ${COD_CARREGAMENTO} AND v.Cancelada IS NULL;
     ${tamanho}=    Get Length    ${resultado}
     IF    ${tamanho} == 0
         RETURN    0
     END
     RETURN    ${resultado[0][0]}

Pegar próxima venda disponível
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Cancelada IS NULL AND v.CodigoCarregamento IS NULL ORDER BY v.Codigo DESC LIMIT 1;

    RETURN    ${resultado[0][0]}


Pegar documento da venda sem cobrança
    [Arguments]    ${COD_VENDA}

    ${resultado}=    Query    SELECT cr.NDocumento FROM contasareceber cr LEFT JOIN cobrancas_detalhes cbd ON cr.Sequencia = cbd.SequenciaCR WHERE cr.CodigoVenda = ${COD_VENDA} AND cbd.SequenciaCR IS NULL;

    IF    not ${resultado}
        Log To Console    Nenhum documento sem cobrança para venda ${COD_VENDA}
        RETURN    ${EMPTY}
    END

    RETURN    ${resultado[0][0]}
    

Seleciono a próxima venda disponível
    ${COD_VENDA}=    Pegar próxima venda disponível
    
    ${CHECKBOX_TODOS_ITENS_BOOL}=    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_TODOS_ITENS}    15
    IF    ${CHECKBOX_TODOS_ITENS_BOOL}
        SikuliLibrary.Click    ${CHECKBOX_TODOS_ITENS}    2
        
        Sleep    ${SLEEP_BAIXO}
    END

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}
    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}
    
    Input Text    ${EMPTY}    ${COD_VENDA}
    Press Special Key    LEFT
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${BT_ADICIONAR}
    Sleep    ${SLEEP_MEDIO}


Selecionar cobrança pelo documento
    [Arguments]    ${DOCUMENTO}

    SikuliLibrary.Click    ${CHECKBOX_TODOS_ITENS}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    SikuliLibrary.Click    ${LB_NDOCUMENTO}
    SikuliLibrary.Click    ${LB_NDOCUMENTO}
    
    Input Text    ${EMPTY}    ${DOCUMENTO}
    Press Special Key    LEFT
    Sleep    ${SLEEP_BAIXO}

    ${CHECKBOX_COBRANCA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_COBRANCA_CARREGAMENTO}    5
    IF    ${CHECKBOX_COBRANCA}
        SikuliLibrary.Click    ${CHECKBOX_COBRANCA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

    Press Combination    Key.ALT    KEY.O
    Sleep    ${SLEEP_MEDIO}


Então a venda deve ser incluída com sucesso no carregamento
    ${QTD_ATUAL}=    Pegar quantidade de vendas incluídas no carregamento
    Log    Quantidade esperada: ${QTD_VENDAS_INCLUIDAS} | Quantidade atual: ${QTD_ATUAL}
    IF    ${QTD_ATUAL} != ${QTD_VENDAS_INCLUIDAS}
        Fail    A venda não foi incluída com sucesso no carregamento. Esperado: ${QTD_VENDAS_INCLUIDAS}, Obtido: ${QTD_ATUAL}
    END

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