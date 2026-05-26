*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# ── Telas ──────────────────────────────────────────────────────────────────
${MENU_COMPRAS}                         menu_Compras.png
${SUBMENU_COMPRAS_CONSIGNADAS}          subMenu_ComprasConsignadas.png
${TELA_COMPRAS_CONSIGNADAS}             tela_Compra_consignada.png
${TELA_VISUALIZAR_COMPRAS_CONSIG}       tela_VisualizacaoCompraConsig.png
${TELA_LANC_COMPRA_CONSIG}              tela_LanCompraConsignada.png

# ── Avisos ─────────────────────────────────────────────────────────────────
${AVISO_CONFIRMAR_EXCLUSAO}             aviso_ConfirmarExclusaoCompraConsig.png

# ── Componentes ────────────────────────────────────────────────────────────
${ABA_DETALHES}                         aba_Detalhes.png
${ABA_DEVOLUCAO}                        aba_Devolucao.png
${BT_ADICIONAR}                         bt_Adicionar.png
${BT_FINALIZAR}                         bt_finalizaCompraConsig.png
${BT_INCLUIR}                           bt_IncluirProdutoComprasConsig.png
${BT_VISUALIZAR}                        bt_visualizarComprasConsignadas.png
${INPUT_QUANTIDADE_PRODUTO}             input_QuantidadeProdutoComprasConsig.png
${BT_QUANTIDADE_PRODUTO}                input_QuantidadeProdutoComprasConsig.png
${LABEL_CRITERIO_CODIGO_COMPRA_CONSIG}  combo_criterioCodComprasConsig.png
${OPCAO_COMBO_CODIGO}                   combo_opcaoCodigoCriterioComprasConsig.png
${COMBO_SEM_CODIGO}                     combo_criterioCodComprasConsigSemCod.png
${CHECK_BOX_GRID}                       checkBox_GridCompraConsig.png
${GRID_REGISTRO_ENCONTRADO}             checkBox_CompraConsig_selecionada.png
${CHECK_BOX_MARCADO}                    checkBox_MarcadoComprasConsig.png
${CHECK_BOX_TODOS}                      checkBox_SelecionarTudoComprasConsig.png
${CHECK_BOX_TODOS_MARCADO}              checkBox_SelecionarTudoComprasConsigMarcado.png
${GRID_CODIGO_LANC_COMPRA_CONSIG}       grid_CodigoLancCompraConsig.png
${AVISO_CONFIRMAR_EXCLUSAO_BLOQUEADA}   aviso_ConfirmarExclusaoBloqueadaCompraConsig.png
${AVISO_DEVOLVIDO_SUPERIOR_A_COMPRADO}  alertaCliente.png
${OPERACAO_EM_ABERTO}                   aviso_QuedaEnergiaOperacaoEmAberto.png
${LABEL_DESCONTO_FINAL_COMPRA}          lb_DescontoFinalVenda.png

# ── Variáveis de Runtime ───────────────────────────────────────────────────
${COD_COMPRA}                           None
${QTDE_BAIXA_PRODUTO}                   None
${Quantidade_Produto}                   None
${CompraConsig_PossuiProduto}           None
${SELECIONAR_TODOS}                     False
${TIPO_COMPRA}                          CS
${COD_COMPRA_ANTIGA}                    None
${VALOR_COMPRA}                         None
${VALOR_APAGAR}                         None
${CHECK_BOX_MARCADO_true}               None
${QUANTIDADE_PRODUTOS_COMPRADOS}        None
${QUANTIDADE_DEVOLVIDA}                 None
${prosseguir_apos_aviso}                False

*** Keywords ***

# ══════════════════════════════════════════════════════════════════════════════
# NAVEGAÇÃO
# ══════════════════════════════════════════════════════════════════════════════

Dado que eu acesso a tela de Compras Consignadas
    [Documentation]    Acessa o menu Compras > Compras Consignadas e valida a tela

    Set Test Variable    ${TELA}    ComprasConsignadas
    Sleep    ${SLEEP_MEDIO}

    SikuliLibrary.Click    ${MENU_COMPRAS}
    Wait Until Screen Contain    ${SUBMENU_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${SUBMENU_COMPRAS_CONSIGNADAS}
    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

# ══════════════════════════════════════════════════════════════════════════════
# LANÇAMENTO
# ══════════════════════════════════════════════════════════════════════════════

Adicionar Fornecedor(${TELA})
    ${codCliente}    Seleciona cliente
    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    IF    '${TELA}' == 'tela_Compra_consignada'

        SikuliLibrary.Double Click    ${INPUT_COD_FORNECEDOR}

    END

    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

Quando eu pressionar em adicionar
    [Documentation]    Clica em Adicionar, aguarda a tela de lançamento e captura o código gerado

    Valida aviso de queda do sistema(${prosseguir_apos_aviso})

    SikuliLibrary.Click    ${BT_ADICIONAR}
    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Capturar Código Da Última Compra Consignada

Capturar Código Da Última Compra Consignada
    [Documentation]    Consulta o banco e armazena o código da última compra consignada aberta

    Sleep    ${SLEEP_MEDIO}

    ${consulta}    Query    SELECT c.codigo FROM compraconsignada c ORDER BY c.codigo DESC LIMIT 1;
    Set Test Variable    ${COD_COMPRA}    ${consulta[0][0]}

Quando adiciono Fornecedor
    [Documentation]    Adiciona fornecedor na tela de lançamento de compra consignada

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Adicionar Fornecedor(TELA)
    Sleep    ${SLEEP_BAIXO}

# ═════════════════════════════════════════════════════════════════════════════
# Manipulação do produto normal
# ═════════════════════════════════════════════════════════════════════════════

E insiro um produto normal informando a quantidade(${Quantidade_Produto})
    [Documentation]    Insere um produto com estoque e informa a quantidade fornecida

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_MEDIO}

    utils.Inserir Produto normal - Necessita de estoque

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

    ${GUIA_DEVOLUCAO}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${SLEEP_BAIXO}

    Atualizar Tipo Compra Conforme Aba Ativa
    Set Test Variable    ${CompraConsig_PossuiProduto}    ${True}

    IF    ${GUIA_DEVOLUCAO}

        Validar aviso de devolução maior que comprado

    END

E insiro o mesmo produto normal informando a quantidade(${Quantidade_Produto})
    [Documentation]    Insere um produto com estoque e informa a quantidade fornecida

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_MEDIO}

    utils.Inserir Mesmo Produto normal - Necessita de estoque

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

    Atualizar Tipo Compra Conforme Aba Ativa

    Set Test Variable    ${CompraConsig_PossuiProduto}    ${True}

Informa a quantidade do produto devolução(${Quantidade_Produto})
    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_MEDIO}

    ${query_compra}=    Query    SELECT Codigo FROM compraconsignada WHERE Cancelada = 0 ORDER BY RAND() LIMIT 1;
    ${COD_COMPRA_ANTIGA}=    Set Variable    ${query_compra[0][0]}

    ${query}=    Query    SELECT Quantidade FROM compraconsignada_produtos WHERE CodigoCompra = ${COD_COMPRA_ANTIGA} AND Tipo = '${TIPO_COMPRA}' AND Cancelado = 0 AND CodigoProduto = '${COD_PRODUTO}'
    ${Quantidade_Produto}=    Set Variable    ${query[0][0]}

    Set Test Variable    ${Quantidade_Produto}

Informa a quantidade do produto(${Quantidade_Produto})
    [Documentation]    Preenche o campo de quantidade e avança com TAB

    SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Quantidade_Produto}

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}
    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

Então excluo o produto da compra consignada
    [Documentation]    Exclui o produto lançado na compra consignada

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.R
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

# ══════════════════════════════════════════════════════════════════════════════
# FINALIZAÇÃO
# ══════════════════════════════════════════════════════════════════════════════

Então finalizo a compra consignada
    [Documentation]    Finaliza o lançamento via ALT+F, trata impressão e retorna à listagem

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.F

    Tratar Impressão De Compra Consignada
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${VALOR_COMPRA}    Query    SELECT ValorTotal FROM compraconsignada WHERE Codigo = ${COD_COMPRA} AND Cancelada = 0 LIMIT 1;
    Set Test Variable    ${VALOR_COMPRA}    ${VALOR_COMPRA[0][0]}

Tratar Impressão De Compra Consignada
    [Documentation]    Verifica se a tela de impressão apareceu e a descarta com ALT+S

    ${impressao_aberta}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${SLEEP_ALTO}

    IF    ${impressao_aberta}

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

    END

    RETURN    ${impressao_aberta}

# ══════════════════════════════════════════════════════════════════════════════
# SELEÇÃO NA GRID
# ══════════════════════════════════════════════════════════════════════════════

E seleciono compra consignada gerada
    [Documentation]    Localiza e seleciona na grid a compra consignada pelo código gerado

    Sleep    ${SLEEP_BAIXO}

    ${nao_esta_na_tela_pagamento}    Run Keyword And Return Status
    ...    Wait Until Screen NOT Contain    ${BT_INCLUIR}    ${SLEEP_BAIXO}

    IF    ${nao_esta_na_tela_pagamento}

        Garantir Critério Código Selecionado

    END

    Pesquisar Compra Por Código

    Selecionar Registro Na Grid

    Set Test Variable    ${SELECIONAR_TODOS}    ${False}

E seleciono todas as compras consignadas geradas
    [Documentation]    Localiza e seleciona na grid todas as compras consignadas geradas pelo código

    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${SLEEP_MEDIO}

    SikuliLibrary.Click    ${CHECK_BOX_TODOS}

    Wait Until Screen Contain    ${CHECK_BOX_TODOS_MARCADO}    ${SLEEP_MEDIO}

    Set Test Variable    ${SELECIONAR_TODOS}    ${True}

Garantir Critério Código Selecionado
    [Documentation]    Verifica se o critério de pesquisa já é por Código; se não, altera

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    ${criterio_ativo}    Exists    ${LABEL_CRITERIO_CODIGO_COMPRA_CONSIG}

    IF    not ${criterio_ativo}

        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${COMBO_SEM_CODIGO}
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${OPCAO_COMBO_CODIGO}
        Sleep    ${SLEEP_BAIXO}

    END

Pesquisar Compra Por Código
    [Documentation]    Navega até o campo de busca, digita o código e confirma com ENTER

    SikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}

    FOR    ${_}    IN RANGE    3

        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

    END

    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${COD_COMPRA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER

Selecionar Registro Na Grid
    [Documentation]    Marca o checkbox do registro encontrado e valida a seleção

    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Double Click    ${CHECK_BOX_GRID}

    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${GRID_REGISTRO_ENCONTRADO}    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${GRID_REGISTRO_ENCONTRADO}
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${CHECK_BOX_MARCADO}    ${TEMPO_TELA}

# ══════════════════════════════════════════════════════════════════════════════
# GERENCIAMENTO DE ABAS
# ══════════════════════════════════════════════════════════════════════════════

Abrir Aba de Compra
    [Documentation]    Abre/Navega para a aba de Compra e atualiza o tipo de compra

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C

    Wait Until Screen Contain    ${ABA_DETALHES}    ${TEMPO_TELA}

    Set Test Variable    ${TIPO_COMPRA}    CS

Abrir Aba de Devolução
    [Documentation]    Abre/Navega para a aba de Devolução e atualiza o tipo de compra

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.D
    Sleep    ${TEMPO_TELA}

    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${TEMPO_TELA}

    Set Test Variable    ${TIPO_COMPRA}    DV

Atualizar Tipo Compra Conforme Aba Ativa
    [Documentation]    Detecta qual aba está ativa e atualiza TIPO_COMPRA automaticamente

    ${aba_devolucao_ativa}    Run Keyword And Return Status
    ...    Exists    ${ABA_DEVOLUCAO}

    IF    ${aba_devolucao_ativa}

        Set Test Variable    ${TIPO_COMPRA}    DV

    ELSE

        Set Test Variable    ${TIPO_COMPRA}    CS

    END

# ══════════════════════════════════════════════════════════════════════════════
# AÇÕES NA LISTAGEM
# ══════════════════════════════════════════════════════════════════════════════

Então troco de guia
    [Documentation]    Navega para a aba de Devolução

    Abrir Aba de Devolução

Então visualizo compra consignada
    [Documentation]    Abre a visualização via ALT+V e navega até a aba Devolução

    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.V
    Sleep    ${TEMPO_TELA}

    Wait Until Screen Contain    ${TELA_VISUALIZAR_COMPRAS_CONSIG}    ${TEMPO_TELA}

E acesso a aba Devolução
    [Documentation]    Navega para a aba de Devolução

    Abrir Aba de Devolução

Então pressiono Excluir
    [Documentation]    Exclui a compra selecionada e valida a exclusão no banco de dados

    IF    ${SELECIONAR_TODOS}

        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${CHECK_BOX_TODOS_MARCADO}    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.X
        Wait Until Screen Contain    ${AVISO_CONFIRMAR_EXCLUSAO_BLOQUEADA}    ${SLEEP_BAIXO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        RETURN

    END

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.X
    Wait Until Screen Contain    ${AVISO_CONFIRMAR_EXCLUSAO}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_MEDIO}
    Validar Exclusão No Banco    ${COD_COMPRA}

Validar Exclusão No Banco
    [Documentation]    Consulta o banco e confirma que o registro foi marcado como cancelado
    [Arguments]    ${codigo}

    ${excluida}    Run Keyword And Return Status
    ...    Check If Exists In Database
    ...    SELECT * FROM compraconsignada WHERE Codigo = ${codigo} AND Status = 'x' AND Cancelada = 1

    Should Be True    ${excluida}
    ...    Compra Consignada ${codigo} não foi excluída corretamente no banco de dados.

# ══════════════════════════════════════════════════════════════════════════════
# EDIÇÃO
# ══════════════════════════════════════════════════════════════════════════════

Então pressiono Editar
    [Documentation]    Abre a tela de edição da compra consignada selecionada via ALT+E

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

Então edito a quantidade do produto para(${nova_quantidade})
    [Documentation]    Seleciona o produto na grid de edição, altera a quantidade e valida no banco

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}
    Selecionar Produto Na Grid De Edição
    Alterar Quantidade Do Produto    ${nova_quantidade}
    Validar Edição De Produto No Banco    ${COD_COMPRA}

Selecionar Produto Na Grid De Edição
    [Documentation]    Clica no registro da grid e aguarda o campo ficar disponível para edição

    Wait Until Screen Not Contain    ${GRID_CODIGO_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.E

Alterar Quantidade Do Produto
    [Documentation]    Digita a nova quantidade e confirma com TABs e ENTER
    [Arguments]    ${nova_quantidade}

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${nova_quantidade}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.I
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

Validar Edição De Produto No Banco
    [Documentation]    Confirma no banco que o produto foi atualizado e não está cancelado
    [Arguments]    ${codigo_compra}

    ${SPACE}=    Set Variable    ${SPACE}

    ${query}=    Catenate    SEPARATOR=${SPACE}
    ...    SELECT * FROM compraconsignada_produtos
    ...    WHERE CodigoCompra = ${codigo_compra}
    ...    AND Cancelado = 0
    ...    AND CodigoProduto = '${COD_PRODUTO}'

    Log    ${query}

    ${editado}=    Run Keyword And Return Status
    ...    Check If Exists In Database
    ...    ${query}

    Should Be True
    ...    ${editado}
    ...    Produto da Compra Consignada ${codigo_compra} não foi editado corretamente.

# ══════════════════════════════════════════════════════════════════════════════
# PAGAMENTO
# ══════════════════════════════════════════════════════════════════════════════

Então pressiono pagar
    [Documentation]    Pressiona o botão de pagar na compra consignada selecionada

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.P
    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

Então desdobro forma de pagamento
    [Documentation]    Desdobra a forma de pagamento para selecionar a opção de compra consignada

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    Selecionar Registro Na Grid

    ${CHECK_BOX_MARCADO_true}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${CHECK_BOX_MARCADO}    ${SLEEP_BAIXO}

    IF    ${CHECK_BOX_MARCADO_true}

        FOR    ${_}    IN RANGE    4

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    TAB

        END

        Press Special Key    DOWN

        FOR    ${_}    IN RANGE    4

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ENTER

        END

    ELSE

        Fail

    END

Então finalizo pagamento
    [Documentation]    Finaliza o pagamento e valida a geração do contas a receber no banco de dados

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.F

    ${VALOR_COMPRA}    Query    SELECT ValorTotal FROM compraconsignada WHERE Codigo = ${COD_COMPRA};
    Set Test Variable    ${VALOR_COMPRA}    ${VALOR_COMPRA[0][0]}

# ══════════════════════════════════════════════════════════════════════════════
# VALIDAÇÕES
# ══════════════════════════════════════════════════════════════════════════════

# -----------------------------------------
# A receber
# -----------------------------------------

E valido contas a receber em caixa
    [Documentation]    Valida no banco de dados que o contas a receber foi gerado com o código da compra

    ${contas_geradas}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM contasapagar WHERE codigo = ${Codigo_Cliente} AND descricao = 'Compra Consginada' AND compraconsignada = ${COD_COMPRA} ORDER BY id DESC LIMIT 1;

    Should Be True
    ...    ${contas_geradas}
    ...    Contas a receber da Compra Consignada ${COD_COMPRA} não foram geradas corretamente.

    ${VALOR_APAGAR}    Query    SELECT valor FROM contasapagar WHERE codigo = ${Codigo_Cliente} AND descricao = 'Compra Consginada' AND compraconsignada = ${COD_COMPRA} ORDER BY id DESC LIMIT 1;

    ${VALOR_APAGAR}    Set Variable    ${VALOR_APAGAR[0][0]}

    Log    VALOR_APAGAR: ${VALOR_APAGAR} | tipo: ${VALOR_APAGAR.__class__.__name__}
    Log    VALOR_COMPRA: ${VALOR_COMPRA} | tipo: ${VALOR_COMPRA.__class__.__name__}

    ${VALOR_APAGAR}    Convert To Number    ${VALOR_APAGAR}    2
    ${VALOR_COMPRA}    Convert To Number    ${VALOR_COMPRA}    2

    Should Be Equal As Numbers
    ...    ${VALOR_APAGAR}
    ...    ${VALOR_COMPRA}
    ...    precision=2

    Log    Valor da conta a pagar está correto: ${VALOR_APAGAR}

# -----------------------------------------
# Devolução
# -----------------------------------------

E valido se a devolução foi lançada com sucesso
    [Documentation]    Verifica se a devolução foi lançada validando a existência do registro no banco de dados

    ${devolucao_lancada}    Run Keyword And Return Status
    ...    Check If Exists In Database
    ...    SELECT * FROM compraconsignada_produtos WHERE codigocompra = ${COD_COMPRA} AND Tipo = '${TIPO_COMPRA}' AND Cancelado = 0 AND CodigoProduto = '${COD_PRODUTO}';

    Should Be True    ${devolucao_lancada}    Devolução da Compra Consignada ${COD_COMPRA} não foi lançada corretamente.

Validar aviso de devolução maior que comprado
    [Documentation]    Verifica se o aviso de devolução maior que comprado é exibido ao tentar finalizar a compra consignada

    IF    '${QUANTIDADE_PRODUTOS_COMPRADOS}' == 'None' or '${QUANTIDADE_DEVOLVIDA}' == 'None'

        RETURN

    END

    IF    $QUANTIDADE_PRODUTOS_COMPRADOS > $QUANTIDADE_DEVOLVIDA or $QUANTIDADE_PRODUTOS_COMPRADOS == $QUANTIDADE_DEVOLVIDA

        RETURN

    END

    Wait Until Screen Contain    ${AVISO_DEVOLVIDO_SUPERIOR_A_COMPRADO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

# -----------------------------------------
# Valor da compra
# -----------------------------------------

E valido valor da compra
    [Documentation]    Verifica se o valor da compra está correto no banco de dados

    ${valor_compra}    Query    SELECT valorTotal FROM compraconsignada WHERE codigo = ${COD_COMPRA} AND Cancelada = 0 LIMIT 1;

    ${valor_compra}    Set Variable    ${valor_compra[0][0]}

    ${VALOR_PRODUTO_TOTAL}    Query    SELECT ValorTotal FROM compraconsignada_produtos WHERE codigoProduto = '${COD_PRODUTO}' AND cancelado = 0 ORDER BY Sequencia DESC LIMIT 1;

    ${VALOR_PRODUTO_TOTAL}    Set Variable    ${VALOR_PRODUTO_TOTAL[0][0]}

    Log    valor_compra: ${valor_compra} | tipo: ${valor_compra.__class__.__name__}
    Log    VALOR_PRODUTO_TOTAL: ${VALOR_PRODUTO_TOTAL} | tipo: ${VALOR_PRODUTO_TOTAL.__class__.__name__}

    ${valor_compra}    Evaluate    round(float(${valor_compra}), 2)
    ${VALOR_PRODUTO_TOTAL}    Evaluate    round(float(${VALOR_PRODUTO_TOTAL}), 2)

    Should Be Equal As Numbers
    ...    ${valor_compra}
    ...    ${VALOR_PRODUTO_TOTAL}
    ...    precision=2

    Log    Valor da compra está correto: ${valor_compra}
# -----------------------------------------
# VALIDA ABA ABERTA
# -----------------------------------------

Então visualizo aba atual
    [Documentation]    Define as variaveis de acordo com a aba que está aberta

    ${aba_devolucao_ativa}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${SLEEP_BAIXO}

    ${aba_compras_ativa}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${ABA_DETALHES}    ${SLEEP_BAIXO}

    IF    ${aba_devolucao_ativa}

        Log    Aba de devolução está ativa
        Set Test Variable    ${TIPO_COMPRA}    DV

    ELSE IF    ${aba_compras_ativa}

        Log    Aba de compra está ativa
        Set Test Variable    ${TIPO_COMPRA}    CS

    END

# ──────────────────────────────────────────────────────────────────────────────
# VALIDAÇÃO DE AVISOS
# ──────────────────────────────────────────────────────────────────────────────

Valida aviso de queda do sistema(${prosseguir_apos_aviso})
    [Documentation]    Verifica se o aviso de queda do sistema apareceu e o descarta

    ${aviso_apareceu}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${OPERACAO_EM_ABERTO}    ${SLEEP_ALTO}

    IF    ${aviso_apareceu} == ${True} and ${prosseguir_apos_aviso} == ${False}

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Not Contain    ${OPERACAO_EM_ABERTO}    ${SLEEP_BAIXO}

        Log    Aviso de queda do sistema apareceu e foi descartado.

    ELSE IF    ${aviso_apareceu} == ${True} and ${prosseguir_apos_aviso} == ${True}

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        Wait Until Screen Not Contain
        ...    ${OPERACAO_EM_ABERTO}
        ...    ${SLEEP_BAIXO}

        Log    Aviso de queda do sistema apareceu e foi descartado. Prosseguindo com o teste.

        Wait Until Screen Contain
        ...    ${TELA_LANC_COMPRA_CONSIG}
        ...    ${SLEEP_MEDIO}

    END
