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
${TELA_EMBARQUE}                        tela_EmbarqueDesembarqueCargas.png
${AVISO_CLIENTE_NAO_CADASTRADO}         aviso_ClienteNaoCadastrado.png

# BOTÕES
${BT_INCLUIR_VENDA_CARREGAMENTO}        bt_IncluirCarregamentoVenda.png
${BT_INCLUIR_COBRANÇA_CARREGAMENTO}     bt_IncluirCarregamentoCobranca.png
${BT_EMBARCAR}                          bt_Embarcar.png


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
${COD_MOTORISTA}                        NONE
${COD_ENTREGADOR}                       NONE
${DOC_ADIANTAMENTO}                     NONE
${TOTAL_ADIANTAMENTO}                   NONE


*** Keywords ***

Acessar menu Emissão
    Wait Until Screen Contain    ${MENU_EMISSÃO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${MENU_EMISSÃO}
    Sleep    ${SLEEP_BAIXO}

Acessar submenu Carregamento
    Wait Until Screen Contain    ${SUBMENU_CARREGAMENTO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${SUBMENU_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

Abrir módulo de carregamento
    Acessar menu Emissão
    Acessar submenu Carregamento
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}

Navegar para próximo campo
    [Arguments]    ${QTD_TABS}
    FOR    ${I}    IN RANGE    ${QTD_TABS}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

Acessar tela de embarque
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_EMBARCAR}    5
    IF    ${existe}
        SikuliLibrary.Click    ${BT_EMBARCAR}
        Sleep    ${SLEEP_BAIXO}
    END
    Wait Until Screen Contain    ${TELA_EMBARQUE}    ${TEMPO_TELA}

Clicar no botão Incluir Venda no carregamento
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_VENDA_CARREGAMENTO}    5
    IF    ${existe}
        SikuliLibrary.Click    ${BT_INCLUIR_VENDA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

Clicar no botão Incluir Cobrança no carregamento
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}    5
    IF    ${existe}
        SikuliLibrary.Click    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

Preencher descrição com texto aleatório
    ${random}=    Evaluate    random.randint(1000,9999)    modules=random
    SikuliLibrary.Input Text    ${EMPTY}    AUTOMACAO - ${random}
    Sleep    ${SLEEP_BAIXO}

Fechar tela de carregamento
    Run Keyword And Ignore Error    Press Special Key    ESC

Preencher dados do veículo no embarque
    [Arguments]    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}
    Press Special Key    HOME
    ${POSICAO}=    Obter posição do estado no combobox    ${UF}
    FOR    ${I}    IN RANGE    ${POSICAO}
        Press Special Key    DOWN
    END
    Navegar para próximo campo    1
    Input Text    ${EMPTY}    ${PLACA}
    Navegar para próximo campo    1
    Input Text    ${EMPTY}    ${KM_SAIDA}
    Navegar para próximo campo    1
    Input Text    ${EMPTY}    ${KM_CHEGADA}
    Navegar para próximo campo    1
    Input Text    ${EMPTY}    ${LITROS}
    Navegar para próximo campo    1

Obter posição do estado no combobox
    [Arguments]    ${UF}
    ${ESTADOS}=    Create List    ${EMPTY}    AC    AL    AP    AM    BA    CE    DF    ES    GO    MA    MG    MS    MT    PA    PB    PE    PI    PR    RJ    RN    RO    RR    RS    SC    SE    SP    TO    EX
    ${POSICAO}=    Get Index From List    ${ESTADOS}    ${UF}
    RETURN    ${POSICAO}

Preencher código do motorista
    [Arguments]    ${COD_MOTORISTA}
    Input Text    ${EMPTY}    ${COD_MOTORISTA}
    Navegar para próximo campo    1
    Sleep    ${SLEEP_MEDIO}
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO}    2
    IF    ${AVISO}
        Clicar no botão Ok
        ${NOVO_COD}=    Obter código do cliente diferente    D    ${COD_MOTORISTA}
        Preencher código do motorista    ${NOVO_COD}
    END

Preencher código do entregador
    [Arguments]    ${COD_ENTREGADOR}
    Input Text    ${EMPTY}    ${COD_ENTREGADOR}
    Navegar para próximo campo    1
    Sleep    ${SLEEP_MEDIO}
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO}    2
    IF    ${AVISO}
        Clicar no botão Ok
        ${NOVO_COD}=    Obter código do cliente diferente    V    ${COD_ENTREGADOR}
        Preencher código do entregador    ${NOVO_COD}
    END

Obter código do cliente diferente
    [Arguments]    ${TIPO}    ${COD_ATUAL}
    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 AND c.Codigo != ${COD_ATUAL} LIMIT 1;
    IF    not ${resultado}
        ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 LIMIT 1;
    END
    Should Not Be Empty    ${resultado}
    RETURN    ${resultado[0][0]}

Preencher dados do adiantamento
    [Arguments]    ${DOC}    ${TOTAL}
    Navegar para próximo campo    2
    Input Text    ${EMPTY}    ${DOC}
    Navegar para próximo campo    1
    Input Text    ${EMPTY}    ${TOTAL}
    Sleep    ${SLEEP_BAIXO}

Salvar embarque
    Clicar no botão Gravar
    Sleep    ${SLEEP_MEDIO}

Iniciar novo carregamento
    Clicar no botão Adicionar
    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}
    Setar codigo carregamento

Gravar carregamento da venda
    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}
    Clicar no botão Gravar
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}

Pesquisar carregamento por código
    [Arguments]    ${codigo}
    Press Combination    KEY.ALT    KEY.P
    Input Text    ${EMPTY}    ${codigo}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

Limpar filtro de pesquisa
    Press Combination    KEY.ALT    KEY.P
    Input Text    ${EMPTY}    ${EMPTY}
    Press Special Key    ENTER

Editar carregamento existente
    Clicar no botão Editar
    Sleep    ${SLEEP_BAIXO}

Excluir carregamento existente
    ${aviso_excluir}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    3
    IF    ${aviso_excluir}
        Press Combination    KEY.ALT    KEY.S
    END

    ${aviso_cancelar}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CANCELAR_CARREGAMENTO}    3
    IF    ${aviso_cancelar}
        Press Combination    KEY.ALT    KEY.S
    END

Abrir tela de listagem de vendas
    Clicar no botão Incluir Venda no carregamento
    Clicar no botão Listar

Abrir tela de listagem de cobranças
    Clicar no botão Incluir Cobrança no carregamento
    ${input_cobrador}=    Run Keyword And Return Status    Wait Until Screen Contain    ${INPUT_CODCOBRADOR_CARREGAMENTO}    15
    IF    ${input_cobrador}
        SikuliLibrary.Click    ${INPUT_CODCOBRADOR_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    2
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
    END
    Clicar no botão Listar
    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    ${TEMPO_TELA}

Dado que acesso o lançamento de carregamento de vendas
    Abrir módulo de carregamento

Quando inicio um novo carregamento
    Iniciar novo carregamento

Quando pesquiso o carregamento
    [Arguments]    ${codigo}
    Pesquisar carregamento por código    ${codigo}

Quando limpo o filtro da pesquisa
    Limpar filtro de pesquisa

Quando edito o carregamento cadastrado
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Clicar no botão Editar

Quando excluo o carregamento
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Clicar no botão Excluir
    Excluir carregamento existente

E informo uma descrição valida
    Preencher descrição com texto aleatório

E gravo o carregamento da venda
    Gravar carregamento da venda

Então o carregamento da venda deve ser salvo com sucesso
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}

Então o status deve ser "Cadastrando"
    ${status}=    Query    SELECT c.Status FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL;

    Should Not Be Empty    ${status}
    Should Be Equal As Strings    ${status[0][0]}    Cadastrando
    Log    message="Status do carregamento: ${status[0][0]}"

Então o status do carregamento deve ser
    [Arguments]    ${STATUS_ESPERADO}
    ${status}=    Query    SELECT c.Status FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL;

    Should Not Be Empty    ${status}
    Should Be Equal As Strings    ${status[0][0]}    ${STATUS_ESPERADO}
    Log    message="Status do carregamento: ${status[0][0]}"

E que existe um carregamento cadastrado
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL ORDER BY c.Sequencia DESC LIMIT 1;

    Should Not Be Empty    ${resultado}

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}

E que existe um carregamento com status
    [Arguments]    ${status}

    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL AND c.Status = '${status}' ORDER BY c.Sequencia DESC LIMIT 1;

    Should Not Be Empty    ${resultado}

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}

E incluo uma cobrança no carregamento
    ${EXISTE_COBRANCA}=    Verificar se existe cobrança a incluir
    IF    ${EXISTE_COBRANCA}
        Incluir cobrança no carregamento
    ELSE
        Log    Nenhuma cobrança encontrada para incluir. Cancelando operação.
        Cancelar operação e fechar tela
    END

Verificar se existe cobrança a incluir
    @{ULTIMAS_VENDAS}=    Pegar ultimas vendas do carregamento
    ${EXISTE}=    Set Variable    ${FALSE}
    FOR    ${COD_VENDA}    IN    @{ULTIMAS_VENDAS}
        ${DOCUMENTO}=    Pegar documento da venda sem cobrança    ${COD_VENDA}
        IF    "${DOCUMENTO}" != "${EMPTY}"
            ${EXISTE}=    Set Variable    ${TRUE}
            BREAK
        END
    END
    RETURN    ${EXISTE}

Cancelar operação e fechar tela
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Fechar tela de carregamento

E incluo vendas no carregamento
    [Arguments]    ${QTD_VENDAS}
    ${QTD_VENDAS_INCLUIDAS}=    Pegar quantidade de vendas incluídas no carregamento
    Log    Quantidade atual: ${QTD_VENDAS_INCLUIDAS}
    ${QTD_VENDAS_INCLUIDAS}=    Evaluate    ${QTD_VENDAS_INCLUIDAS} + ${QTD_VENDAS}
    Set Suite Variable    ${QTD_VENDAS_INCLUIDAS}    ${QTD_VENDAS_INCLUIDAS}
    Log    Quantidade esperada após inclusão: ${QTD_VENDAS_INCLUIDAS}

    Abrir tela de listagem de vendas

    FOR    ${INDEX}    IN RANGE    ${QTD_VENDAS}
        Selecionar a próxima venda disponível
    END

    Clicar no botão Salvar

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
        Clicar no botão Ok
        Sleep    ${SLEEP_BAIXO}
    END

Então fecho a tela de carregamento
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}
    Run Keyword And Ignore Error    Press Special Key    ESC

Setar codigo carregamento
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL ORDER BY c.Sequencia DESC LIMIT 1;

    IF    not ${resultado}
        RETURN    0
    END

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}

Selecionar cobrança pelo documento
    [Arguments]    ${DOCUMENTO}

    SikuliLibrary.Click    ${CHECKBOX_TODOS_ITENS}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    SikuliLibrary.Click    ${LB_NDOCUMENTO}
    SikuliLibrary.Click    ${LB_NDOCUMENTO}
    
    Input Text    ${EMPTY}    ${DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    LEFT
    Sleep    ${SLEEP_BAIXO}

    ${CHECKBOX_COBRANCA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_COBRANCA_CARREGAMENTO}    5
    IF    ${CHECKBOX_COBRANCA}
        SikuliLibrary.Click    ${CHECKBOX_COBRANCA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}
    END

    Press Combination    Key.ALT    KEY.O
    Sleep    ${SLEEP_MEDIO}


Selecionar a próxima venda disponível
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

    Clicar no botão Adicionar

Incluir cobrança no carregamento
    @{ULTIMAS_VENDAS}=    Pegar ultimas vendas do carregamento

    Abrir tela de listagem de cobranças

    FOR    ${COD_VENDA}    IN    @{ULTIMAS_VENDAS}
        ${DOCUMENTO}=    Pegar documento da venda sem cobrança    ${COD_VENDA}
        Selecionar cobrança pelo documento    ${DOCUMENTO}
    END

    Aguardar tela de cobrança fechar
    Clicar no botão Gravar

Aguardar tela de cobrança fechar
    ${TELA_ABERTA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    1
    FOR    ${I}    IN RANGE    15
        ${TELA_ABERTA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    0.1
        IF    not ${TELA_ABERTA}
            BREAK
        END
        Sleep    ${SLEEP_MEDIO}
    END
    
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

Pegar ultimas vendas do carregamento
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.CodigoCarregamento = ${COD_CARREGAMENTO} ORDER BY v.Codigo DESC;
    IF    not${resultado}
        RETURN    ${EMPTY}
    END

    ${VENDAS}=    Evaluate    [item[0] for item in $resultado]

    RETURN    ${VENDAS}

Obter código do cliente
    [Arguments]    ${TIPO}
    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 LIMIT 1;
    Should Not Be Empty    ${resultado}
    RETURN    ${resultado[0][0]}

Gerar dados do adiantamento
    ${DOC}=    Evaluate    random.randint(100000,999999)
    ${TOTAL}=    Evaluate    random.randint(100,1000)
    Set Test Variable    ${DOC_ADIANTAMENTO}    ${DOC}
    Set Test Variable    ${TOTAL_ADIANTAMENTO}    ${TOTAL}

Validar adiantamento no banco
    ${resultado}=    Query    SELECT ca.Documento, ca.Valor FROM cargas_adiantamento ca WHERE ca.CodigoCarga = ${COD_CARREGAMENTO} AND ca.Cancelado IS NULL
    Should Not Be Empty    ${resultado}
    Should Be Equal As Strings    ${resultado[0][0]}    ${DOC_ADIANTAMENTO}
    Should Be Equal As Numbers    ${resultado[0][1]}    ${TOTAL_ADIANTAMENTO}

Validar dados do adiantamento na tabela cargas
    ${resultado}=    Query    SELECT c.CodMotorista, c.CodEntregador, c.UFPlaca, c.Placa, c.KMSaida, c.KMChegada, c.QtdeLitros_Comb, c.ValorAdiantamento FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO};
    Should Not Be Empty    ${resultado}
    Set Test Variable    ${COD_MOTORISTA}    ${resultado[0][0]}
    Set Test Variable    ${COD_ENTREGADOR}    ${resultado[0][1]}
    Log    Motorista: ${resultado[0][0]} | Entregador: ${resultado[0][1]} | UF: ${resultado[0][2]} | Placa: ${resultado[0][3]}
    Log    KM Saída: ${resultado[0][4]} | KM Chegada: ${resultado[0][5]} | Litros: ${resultado[0][6]} | Valor Adiantamento: ${resultado[0][7]}

Quando acesso a tela de embarque
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Acessar tela de embarque

E informo os dados do veículo
    [Arguments]    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}
    Preencher dados do veículo no embarque    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}

E informo os dados do motorista
    ${COD}=    Obter código do cliente    D
    Preencher código do motorista    ${COD}

E informo os dados do entregador
    ${COD}=    Obter código do cliente    V
    Preencher código do entregador    ${COD}

E informo os dados do adiantamento
    Gerar dados do adiantamento
    Preencher dados do adiantamento    ${DOC_ADIANTAMENTO}    ${TOTAL_ADIANTAMENTO}
    Clicar no botão Incluir

E gravo o embarque
    Salvar embarque

Então o embarque deve ser salvo com sucesso
    Wait Until Screen Contain    ${TELA_CARREGAMENTO}    ${TEMPO_TELA}

Então o adiantamento deve estar cadastrado no banco
    Validar adiantamento no banco
    Validar dados do adiantamento na tabela cargas
