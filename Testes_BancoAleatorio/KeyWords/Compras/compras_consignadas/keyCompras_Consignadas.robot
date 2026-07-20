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
${CHECK_BOX_TODOS_MARCADO_PAGAMENTO}    checkBox_SelecionarTudoComprasConsigMarcado_pagamento.png
${GRID_CODIGO_LANC_COMPRA_CONSIG}       grid_CodigoLancCompraConsig.png
${AVISO_CONFIRMAR_EXCLUSAO_BLOQUEADA}   aviso_ConfirmarExclusaoBloqueadaCompraConsig.png
${AVISO_DEVOLVIDO_SUPERIOR_A_COMPRADO}  alertaCliente.png
${OPERACAO_EM_ABERTO}                   aviso_QuedaEnergiaOperacaoEmAberto.png
${LABEL_DESCONTO_FINAL_COMPRA}          lb_DescontoFinalVenda.png
${INPUT_COD_FORNECEDOR}                 lb_CodFornecedor.png

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
${TOTAL_VALOR_APAGAR}                   0
${CHECK_BOX_MARCADO_true}               None
${QUANTIDADE_PRODUTOS_COMPRADOS}        None
${QUANTIDADE_DEVOLVIDA}                 None
${prosseguir_apos_aviso}                False
${CODIGO_FORNECEDOR}                    ${EMPTY}
@{BUFF_COD_COMPRAS_LOTE}
@{BUFF_FORNECEDORES_LOTE}
@{BUFF_VALORES_COMPRAS}
${INDEX_FORNECEDOR}                     0
${CODIGO}                                ${EMPTY}
*** Keywords ***

# ══════════════════════════════════════════════════════════════════════════════
# NAVEGAÇÃO
# ══════════════════════════════════════════════════════════════════════════════

Dado que eu acesso a tela de Compras Consignadas
    [Documentation]    Acessa o menu Compras > Compras Consignadas e valida a tela

    # Reset das listas para evitar acúmulo de valores entre testes
    Set Test Variable    @{BUFF_COD_COMPRAS_LOTE}    @{EMPTY}
    Set Test Variable    @{BUFF_FORNECEDORES_LOTE}    @{EMPTY}
    Set Test Variable    @{BUFF_VALORES_COMPRAS}    @{EMPTY}
    Set Test Variable    ${INDEX_FORNECEDOR}    0
    Set Test Variable    ${CODIGO_FORNECEDOR}    ${EMPTY}
    Set Test Variable    ${CODIGO}    ${EMPTY}

    Set Test Variable    ${TELA}    ComprasConsignadas
    Sleep    ${SLEEP_MEDIO}

    SikuliLibrary.Click    ${MENU_COMPRAS}
    Wait Until Screen Contain    ${SUBMENU_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${SUBMENU_COMPRAS_CONSIGNADAS}
    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

# ══════════════════════════════════════════════════════════════════════════════
# LANÇAMENTO
# ══════════════════════════════════════════════════════════════════════════════
Seleciona fornecedor sem compras consignadas nao pagas
    
    ${codCliente}    Query    SELECT c.Codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND c.Ativo = -1 AND c.Status = 'ATIVA' AND c.CreditoCortado = 0 AND c.Codigo <> 1 AND NOT EXISTS (SELECT 1 FROM compraconsignada cc WHERE cc.CodigoFornecedor = c.Codigo AND cc.Cancelada = 0 AND cc.Status = 'F' AND cc.Pagamento = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    
    IF    len($codCliente) == 0
        
        Fail    Nenhum fornecedor foi encontrado.

    END

    Log To Console    Fornecedor selecionado: ${codCliente[0][0]}

    RETURN    ${codCliente[0][0]}

Adicionar Fornecedor
    [Arguments]    ${TELA}

    ${Codigo_Cliente}    Seleciona fornecedor sem compras consignadas nao pagas

    Sleep    ${SLEEP_BAIXO}

    log    Fornecedor selecionado: ${Codigo_Cliente}

    Set Test Variable    ${CODIGO_FORNECEDOR}    ${Codigo_Cliente}

    Set Test Variable    ${CODIGO}    ${Codigo_Cliente}

    Input Text    ${EMPTY}    ${Codigo_Cliente}

    press Special Key    ENTER
    

    Sleep    ${SLEEP_BAIXO}

Quando eu pressionar em adicionar
    [Documentation]    Clica em Adicionar, aguarda a tela de lançamento e captura o código gerado

    Valida aviso de queda do sistema(${prosseguir_apos_aviso})

    #passa o foco para tela para evitar que o atalho seja enviado para outro lugar
    sikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}

    Press Combination    KEY.ALT    KEY.A
    
    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Capturar Código Da Última Compra Consignada

    Append To List    ${BUFF_COD_COMPRAS_LOTE}    ${COD_COMPRA}

Capturar Código Da Última Compra Consignada
    [Documentation]    Consulta o banco e armazena o código da última compra consignada aberta

    Sleep    ${SLEEP_MEDIO}

    ${consulta}    Query    SELECT c.codigo FROM compraconsignada c ORDER BY c.codigo DESC LIMIT 1;
    Set Test Variable    ${COD_COMPRA}    ${consulta[0][0]}
    

E adiciono Fornecedor
    [Documentation]    Alias para o passo BDD que adiciona o fornecedor na compra consignada
    Adicionar Fornecedor    ${TELA}

Garantir codigo de fornecedor para uso
    [Documentation]    Garante que a variável usada no input do fornecedor possua o último código selecionado.

    IF    "${CODIGO}" == "${EMPTY}" and "${CODIGO_FORNECEDOR}" != "${EMPTY}"
        Set Test Variable    ${CODIGO}    ${CODIGO_FORNECEDOR}
    END

Digitar fornecedor no campo ativo
    [Arguments]    ${valor}
    [Documentation]    Valida o valor, foca a tela e tenta preencher o campo do fornecedor.

    IF    "${valor}" == "${EMPTY}" or "${valor}" == "None" or "${valor}" == ""
        Fail    Não foi possível preencher o campo do fornecedor porque o valor está vazio.
    END

    # Detecta qual tela está ativa
    ${tela_lanc_ativa}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}

    # Clica na tela ativa para dar foco
    IF    ${tela_lanc_ativa}
        SikuliLibrary.Click    ${TELA_LANC_COMPRA_CONSIG}
        
    END

    Sleep    ${SLEEP_MEDIO}


    Press Special Key    TAB

    Sleep    ${SLEEP_BAIXO}


    Sleep    ${SLEEP_BAIXO}

    # Limpa campo com backspace antes de digitar o código do fornecedor
    Press Special Key    BACKSPACE

    Sleep    ${SLEEP_BAIXO}

    # Digita o código do fornecedor
    Input Text    ${EMPTY}    ${valor}
    
    Log To Console    ✓ Fornecedor digitado com sucesso: ${valor}



E adiciono Fornecedor das compras ja lançadas
    [Arguments]    ${reusar_fornecedor}=${True}
    [Documentation]    Adiciona o mesmo fornecedor nas compras consignadas já lançadas em lote para conseguir finalizar o pagamento

    ${tela_lanc_ativa}    ${MSG}=    Run Keyword And Ignore Error
    ...    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}

    IF    "${tela_lanc_ativa}" == "PASS"

        ${TELA}=    Set Variable    ${TELA_LANC_COMPRA_CONSIG}

    ELSE

        ${TELA}=    Set Variable    ${TELA_COMPRAS_CONSIGNADAS}
        
    END

    IF    not ${reusar_fornecedor}

        Adicionar Fornecedor    ${TELA}

    ELSE

    # Reutiliza o fornecedor já lançado anteriormente para a próxima compra
        ${LANCANDO_COMPRA}    ${MSG}=    Run Keyword And Ignore Error
        ...    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}

        ${TOTAL_ITENS}=    Get Length    ${BUFF_FORNECEDORES_LOTE}

        IF    ${TOTAL_ITENS} == 0
            Fail    Não há fornecedores disponíveis para processar no lote atual.
        END

        IF    ${INDEX_FORNECEDOR} < 0
            Set Suite Variable    ${INDEX_FORNECEDOR}    0
        END

        ${CODIGO}=    Set Variable    ${EMPTY}
        
        # Loop para percorrer a lista de fornecedores lançados e encontrar o próximo fornecedor disponível
        FOR    ${n}    ${CODIGO}    IN ENUMERATE    @{BUFF_FORNECEDORES_LOTE}

            IF    ${n} >= ${INDEX_FORNECEDOR}

                IF    "${CODIGO}" != "${EMPTY}"

                    Set Test Variable    ${CODIGO_FORNECEDOR}    ${CODIGO}
                    
                    Set Test Variable    ${CODIGO}    ${CODIGO}

                    ${INDEX_FORNECEDOR}=    Evaluate    ${n} + 1

                    Set Suite Variable    ${INDEX_FORNECEDOR}
                    
                    Exit For Loop

                END
            END
        END

        IF    "${LANCANDO_COMPRA}" == "PASS"

            IF    "${CODIGO}" == "${EMPTY}"

                Fail    O fornecedor não foi encontrado na lista de fornecedores lançados.

            END

            Garantir codigo de fornecedor para uso

            

            Digitar fornecedor no campo ativo    ${CODIGO}

            ${INDEX_FORNECEDOR}=    Evaluate    ${INDEX_FORNECEDOR} + 1

            Set Suite Variable    ${INDEX_FORNECEDOR}

            Press Special Key    ENTER

            Return From Keyword

        END


        SikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}
        


    END

E adciono fornecedor em pagamento da compra consignada
    [Documentation]    Adiciona o fornecedor na tela de pagamento da compra consignada para conseguir finalizar o pagamento

    ${TOTAL_ITENS}=    Get Length    ${BUFF_FORNECEDORES_LOTE}

    IF    ${TOTAL_ITENS} == 0
        Fail    Não há fornecedores disponíveis para processar no lote atual.
    END

    # RESET do INDEX para evitar que fique fora do range das compras
    Set Suite Variable    ${INDEX_FORNECEDOR}    0

    Log To Console    Buffer fornecedores: ${BUFF_FORNECEDORES_LOTE} INDEX FORNECEDORES: ${INDEX_FORNECEDOR} TOTAL ITENS: ${TOTAL_ITENS}

    ${CODIGO}=    Set Variable    ${EMPTY}

    # Itera diretamente sobre a lista de fornecedores e pega o primeiro
    FOR    ${CODIGO}    IN    @{BUFF_FORNECEDORES_LOTE}

        Log To Console    Fornecedor obtido para pagamento: ${CODIGO}
        
        Exit For Loop
    END

    IF    "${CODIGO}" == "${EMPTY}"
        Fail    Nenhum fornecedor foi encontrado na lista para pagamento.
    END
    
    SikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}

    FOR    ${_}    IN RANGE    6
    
        Sleep    ${SLEEP_BAIXO}
    
        Press Special Key    TAB

    END


    Sleep    ${SLEEP_BAIXO}

    #mudar essa keyword adicionar sql para validar a compra x fornecedor a ser utilizado
    Garantir codigo de fornecedor para uso 

    Digitar fornecedor no campo ativo    ${CODIGO}

    Press Special Key    ENTER

    ${tela_lanc_ativa}    Run Keyword And Ignore Error       
    ...     Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}

    IF    ${tela_lanc_ativa}
        Set Variable    ${TELA}    ${TELA_LANC_COMPRA_CONSIG}
    ELSE
        Set Variable    ${TELA}    ${TELA_COMPRAS_CONSIGNADAS}
    END

E adiciono o mesmo fornecedor em outra compra
    [Documentation]    Reutiliza o fornecedor já lançado anteriormente para a próxima compra
    E adiciono Fornecedor das compras ja lançadas    ${True}

E adiciono outro fornecedor em outra compra
    [Documentation]    Insere um novo fornecedor em vez de reaproveitar o já lançado
    E adiciono Fornecedor das compras ja lançadas    ${False}




E adiciono a primeira compra com Fornecedor e produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    [Documentation]    Realiza o fluxo completo de lançamento de uma compra consignada com um produto normal, adicionando um novo fornecedor
    E adiciono uma compra consignada com Fornecedor e produto normal informando a quantidade(${QTDE_PADRAO_TESTES})    ${False}



E adiciono a segunda compra com Fornecedor e produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    [Documentation]    Realiza o fluxo completo de lançamento de uma segunda compra consignada com um produto normal, reutilizando o fornecedor anterior
    E adiciono uma compra consignada com Fornecedor e produto normal informando a quantidade(${QTDE_PADRAO_TESTES})    ${True}





E adiciono uma compra consignada com Fornecedor e produto normal informando a quantidade(${Quantidade_Produto})
    [Arguments]    ${reusar_fornecedor}=${True}
    [Documentation]    Realiza o fluxo completo de lançamento de uma compra consignada com um produto normal, incluindo fornecedor, produto e finalização

    Quando eu pressionar em adicionar

    E adiciono Fornecedor das compras ja lançadas    ${reusar_fornecedor}

    #passa para o campo de codigo do produto
    E insiro um produto normal informando a quantidade(${Quantidade_Produto})

    Então finalizo a compra consignada

    E valido valor da compra
  


# ═════════════════════════════════════════════════════════════════════════════
# Manipulação do produto normal
# ═════════════════════════════════════════════════════════════════════════════

E insiro um produto normal informando a quantidade(${Quantidade_Produto})
    [Documentation]    Insere um produto com estoque e informa a quantidade fornecida

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${SLEEP_MEDIO}

    utils.Inserir Produto normal - Necessita de estoque

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto


    Atualizar Tipo Compra Conforme Aba Ativa

    Set Test Variable    ${CompraConsig_PossuiProduto}    ${True}

    
    ${GUIA_DEVOLUCAO}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${SLEEP_BAIXO}


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

    ${VALOR_COMPRA}    Query    SELECT COALESCE(ValorTotal, 0) FROM compraconsignada WHERE Codigo = ${COD_COMPRA} AND Cancelada = 0 LIMIT 1;

    ${VALOR_COMPRA}=    Set Variable    ${VALOR_COMPRA[0][0]}

    Set Test Variable    ${VALOR_COMPRA}    ${VALOR_COMPRA}



    IF    "${CODIGO_FORNECEDOR}" != "${EMPTY}" and "${CODIGO_FORNECEDOR}" != "None"

        Append To List    ${BUFF_FORNECEDORES_LOTE}    ${CODIGO_FORNECEDOR}

    END



    IF    "${VALOR_COMPRA}" != "${EMPTY}" and "${VALOR_COMPRA}" != "None"

        Append To List    ${BUFF_VALORES_COMPRAS}    ${VALOR_COMPRA}

    ELSE

        Append To List    ${BUFF_VALORES_COMPRAS}    0

    END
    


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


    Pesquisar Compra Por Código


    Selecionar Registro Na Grid


    Set Test Variable    ${SELECIONAR_TODOS}    ${False}




E seleciono todas as compras consignadas geradas nesse lote
    [Documentation]    Alias para selecionar todas as compras consignadas geradas no lote
    Selecionar Todas as Compras Consignadas



E seleciono todas as compras consignadas geradas
    [Documentation]    Localiza e seleciona na grid todas as compras consignadas geradas pelo código
    Selecionar Todas as Compras Consignadas




Selecionar Todas as Compras Consignadas
    [Documentation]    Marca o checkbox de seleção de todas as compras consignadas

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




E filtro por data de criação de compras consignadas
    
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}

    FOR   ${_}    IN RANGE    5

        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

    END

    Sleep    ${SLEEP_BAIXO}

    Press Special Key    BACKSPACE

    #insere data para filtrar todo o periodo

    Input Text    ${EMPTY}    01010001 

    Sleep    ${SLEEP_BAIXO}

    FOR    ${_}    IN RANGE    3

        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

    END

    Sleep    ${SLEEP_MEDIO}
    
    Press Special Key    ENTER


# ══════════════════════════════════════════════════════════════════════════════
# GERENCIAMENTO DE ABAS
# ══════════════════════════════════════════════════════════════════════════════

E Abro Aba de Compra
    [Documentation]    Abre/Navega para a aba de Compra e atualiza o tipo de compra

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C

    Wait Until Screen Contain    ${ABA_DETALHES}    ${TEMPO_TELA}

    Set Test Variable    ${TIPO_COMPRA}    CS




E Abro Aba de Devolução
    [Documentation]    Abre/Navega para a aba de Devolução e atualiza o tipo de compra

    Wait Until Screen Contain    ${TELA_LANC_COMPRA_CONSIG}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.D

    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${TEMPO_TELA}

    Set Test Variable    ${TIPO_COMPRA}    DV




Atualizar Tipo Compra Conforme Aba Ativa
    [Documentation]    Detecta qual aba está ativa e atualiza TIPO_COMPRA automaticamente

    ${aba_devolucao_ativa}    Run Keyword And Return Status    Wait Until Screen Contain    ${ABA_DEVOLUCAO}    ${SLEEP_BAIXO}


    IF    ${aba_devolucao_ativa}

        Set Test Variable    ${TIPO_COMPRA}    DV

    ELSE

        Set Test Variable    ${TIPO_COMPRA}    CS

    END



# ══════════════════════════════════════════════════════════════════════════════
# AÇÕES NA LISTAGEM
# ══════════════════════════════════════════════════════════════════════════════



Então visualizo compra consignada
    [Documentation]    Abre a visualização via ALT+V e navega até a aba Devolução

    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.V
    
    Sleep    ${TEMPO_TELA}

    Wait Until Screen Contain    ${TELA_VISUALIZAR_COMPRAS_CONSIG}    ${TEMPO_TELA}





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

    Validar Edição De Produto No Banco    ${COD_COMPRA}    ${nova_quantidade}




Selecionar Produto Na Grid De Edição
    [Documentation]    Clica no registro da grid e aguarda o campo ficar disponível para edição

    Wait Until Screen Not Contain    ${GRID_CODIGO_LANC_COMPRA_CONSIG}    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.E




Alterar Quantidade Do Produto
    [Documentation]    Digita a nova quantidade e confirma com TABs e ENTER
    [Arguments]    ${nova_quantidade}

    #verifica se nova quantidade é diferente da anterior para evitar regravação do mesmo valor e invalidar teste

    IF    '${nova_quantidade}' == '${Quantidade_Produto}'

        Log    Nova quantidade é igual à quantidade atual. Nenhuma alteração será feita.

        Fail    END

        RETURN

    END

    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${nova_quantidade}

    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.I

    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER




Validar Edição De Produto No Banco
    [Documentation]    Confirma no banco que o produto foi atualizado e não está cancelado

    [Arguments]    ${codigo_compra}    ${nova_quantidade}


    ${SPACE}=    Set Variable    ${SPACE}
    

    ${editado}=    Run Keyword And Return Status
   
    ...    Check If Exists In Database

    ...    SELECT * FROM compraconsignada_produtos WHERE CodigoCompra = ${codigo_compra} AND Cancelado = 0 AND CodigoProduto = '${COD_PRODUTO}' AND quantidade = '${nova_quantidade}'
   
    Should Be True

    ...    ${editado}
 
    ...    Produto da Compra Consignada ${codigo_compra} não foi editado corretamente.




# ══════════════════════════════════════════════════════════════════════════════
# PAGAMENTO
# ══════════════════════════════════════════════════════════════════════════════

Então pressiono pagar
    [Documentation]    Pressiona o botão de pagar na compra consignada selecionada

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    #muda o foco para tela para evitar que o atalho seja enviado para outro lugar
    SikuliLibrary.Click    ${TELA_COMPRAS_CONSIGNADAS}

    Press Combination    KEY.ALT    KEY.P

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    ${TELA}    Set Variable    TELA_COMPRAS_CONSIGNADAS_PAGAMENTO





Então desdobro forma de pagamento
    [Documentation]    Desdobra a forma de pagamento para selecionar a opção de compra consignada
    [Arguments]    ${SELECIONAR_TODOS}
    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    IF    not ${SELECIONAR_TODOS}

        Selecionar Registro Na Grid

    END


    ${CHECK_BOX_MARCADO_true}    Run Keyword And Return Status
    ...    Wait Until Screen Contain    ${CHECK_BOX_TODOS_MARCADO_PAGAMENTO}    ${SLEEP_BAIXO}

    IF    ${CHECK_BOX_MARCADO_true}

        #Navega até forma de parcelamento
        FOR    ${_}    IN RANGE    4

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    TAB

        END

        #Seleciona a forma de parcelamento
        Press Special Key    DOWN


        #Navega até botão de Incluir e Inclui forma de pagamento
        FOR    ${_}    IN RANGE    5

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ENTER

        END

        Sleep    ${SLEEP_BAIXO}

    ELSE IF    not ${CHECK_BOX_MARCADO_true}


        #Navega até forma de parcelamento
        FOR    ${_}    IN RANGE    4

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    TAB

        END


        #Seleciona a forma de parcelamento
        Press Special Key    DOWN


        #Navega até botão de Incluir e Inclui forma de pagamento
        FOR    ${_}    IN RANGE    5

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ENTER

        END
    
    ELSE

        Fail

    END

Então finalizo pagamento
    [Documentation]    Finaliza o pagamento e valida a geração do contas a receber no banco de dados

    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.F

    Wait Until Screen Contain    ${TELA_COMPRAS_CONSIGNADAS}    ${TEMPO_TELA}

    ${TELA}    Set Variable    ComprasConsignadas

    Sleep    ${SLEEP_MEDIO}

    ${VALOR_COMPRA}    Query    SELECT ValorTotal FROM compraconsignada WHERE Codigo = ${COD_COMPRA};

    Set Test Variable    ${VALOR_COMPRA}    ${VALOR_COMPRA[0][0]}


    #Alguns logs aqui pois essa parte fica dificil de debugar sem, algumas dessas variaveis ficaram legadas e são poco utilizadas mesmo
    Log To Console    TOTAL_VALOR_APAGAR: ${TOTAL_VALOR_APAGAR}
    Log To Console    VALOR_COMPRA: ${VALOR_COMPRA}
    Log To Console    Compras: ${BUFF_COD_COMPRAS_LOTE}
    Log To Console    Fornecedores: ${BUFF_FORNECEDORES_LOTE}


# ══════════════════════════════════════════════════════════════════════════════
# VALIDAÇÕES
# ══════════════════════════════════════════════════════════════════════════════

# -----------------------------------------
# A receber
# -----------------------------------------
E valido contas a receber em caixa
    [Documentation]    Valida no banco de dados que as contas a pagar da compra consignada foram geradas
    ...                corretamente para cada fornecedor do lote, comparando os valores pelo campo CompraConsignada

    Sleep    ${SLEEP_MEDIO}

    # ── Verificação de consistência das listas ─────────────────────────────
    ${QTD_COMPRAS}        Get Length    ${BUFF_COD_COMPRAS_LOTE}
    ${QTD_FORNECEDORES}   Get Length    ${BUFF_FORNECEDORES_LOTE}
    ${QTD_VALORES}        Get Length    ${BUFF_VALORES_COMPRAS}

    Should Be Equal As Integers    ${QTD_COMPRAS}    ${QTD_VALORES}
    ...    As listas BUFF_COD_COMPRAS_LOTE e BUFF_VALORES_COMPRAS devem ter o mesmo tamanho.


    #Mais logs para debugar caso necessario
    Log To Console    ⚠️ Verificação de Consistência:
    Log To Console    - Compras: ${QTD_COMPRAS}
    Log To Console    - Fornecedores: ${QTD_FORNECEDORES}
    Log To Console    - Valores: ${QTD_VALORES}


    #Verifica o numero de operações de compra bate com o numero de fornecedores, pois cada compra deve ter um fornecedor

    Should Be Equal As Integers    ${QTD_COMPRAS}    ${QTD_FORNECEDORES}
    ...    As listas BUFF_COD_COMPRAS_LOTE e BUFF_FORNECEDORES_LOTE devem ter o mesmo tamanho!

    # ── Etapa 1: Validar existência do registro por compra/fornecedor ──────
    FOR    ${COD_COMPRA}    ${codigo_fornecedor}    IN ZIP    ${BUFF_COD_COMPRAS_LOTE}    ${BUFF_FORNECEDORES_LOTE}

        Log To Console    Validando conta a pagar para Compra: ${COD_COMPRA} | Fornecedor: ${codigo_fornecedor}

        ${contas_geradas}    Run Keyword And Return Status
        ...    Check If Exists In Database
        ...    SELECT * FROM contasapagar WHERE codigo = '${codigo_fornecedor}' AND descricao = 'Compra Consginada ' AND FIND_IN_SET(${COD_COMPRA}, CompraConsignada) > 0

        Log To Console    Compra: ${COD_COMPRA} | Fornecedor: ${codigo_fornecedor} | Encontrado: ${contas_geradas}

        Should Be True    ${contas_geradas}
        ...    Conta a pagar da Compra Consignada ${COD_COMPRA} para o fornecedor ${codigo_fornecedor} não foi gerada corretamente.

    END

    # ── Etapa 2: Somar valor total das contas a pagar APENAS deste lote ───
    ${FORNECEDORES_UNICOS}    Evaluate    list(dict.fromkeys($BUFF_FORNECEDORES_LOTE))

    ${TOTAL_VALOR_APAGAR}    Set Variable    ${0}

    FOR    ${codigo_fornecedor}    IN    @{FORNECEDORES_UNICOS}

        # Monta lista de CODs do lote que pertencem a este fornecedor
        ${COMPRAS_DO_FORNECEDOR}    Evaluate
        ...    [str(cod) for cod, forn in zip($BUFF_COD_COMPRAS_LOTE, $BUFF_FORNECEDORES_LOTE) if str(forn) == str(${codigo_fornecedor})]

        # Busca a Sequencia da conta a pagar que contém QUALQUER compra do lote deste fornecedor
        # (o campo CompraConsignada armazena os códigos separados por vírgula)
        ${primeira_compra}    Get From List    ${COMPRAS_DO_FORNECEDOR}    0


        #Captura ID da conta a pagar e o valor para somar ao total do lote
        ${result_seq}    Query
        ...    SELECT Sequencia, COALESCE(Valor, 0) AS Valor FROM contasapagar WHERE codigo = '${codigo_fornecedor}' AND descricao = 'Compra Consginada ' AND FIND_IN_SET(${primeira_compra}, CompraConsignada) > 0 LIMIT 1
    

        Should Not Be Empty    ${result_seq}
        ...    Não foi encontrada conta a pagar para o fornecedor ${codigo_fornecedor} com a compra ${primeira_compra}

        #Formata resultado da query para variáveis legíveis
        ${SEQUENCIA_CONTA}    Set Variable    ${result_seq[0][0]}
        ${VALOR_CONTA}        Set Variable    ${result_seq[0][1]}
       
        #Debug importante
        Log To Console    Fornecedor: ${codigo_fornecedor} | Sequencia conta: ${SEQUENCIA_CONTA} | Valor conta: ${VALOR_CONTA}

        # Etapa 3: confirmar que TODAS as compras do lote deste fornecedor estão na mesma conta
        FOR    ${cod_compra_lote}    IN    @{COMPRAS_DO_FORNECEDOR}

            ${compra_na_conta}    Run Keyword And Return Status
            ...    Check If Exists In Database
            ...    SELECT * FROM contasapagar WHERE Sequencia = ${SEQUENCIA_CONTA} AND FIND_IN_SET(${cod_compra_lote}, CompraConsignada) > 0

            Should Be True    ${compra_na_conta}
            ...    Compra ${cod_compra_lote} não está registrada na conta a pagar Sequencia=${SEQUENCIA_CONTA} do fornecedor ${codigo_fornecedor}

        END


        #Validação de valor da conta a pagar, caso seja None ou vazio, considera 0
        IF    '${VALOR_CONTA}' == '${EMPTY}' or '${VALOR_CONTA}' == 'None' or '${VALOR_CONTA}' == ''
            Fail
        END

        #converte para número e soma ao total do lote
        ${VALOR_CONTA}              Convert To Number    ${VALOR_CONTA}    2
        ${TOTAL_VALOR_APAGAR}=      Evaluate    ${TOTAL_VALOR_APAGAR} + float(${VALOR_CONTA})

    END

    # ── Etapa 4: Calcular total das compras do lote e comparar ────────────
    ${VALOR_COMPRA_TOTAL}    Set Variable    ${0}

    FOR    ${valor}    IN    @{BUFF_VALORES_COMPRAS}

        IF    '${valor}' == '${EMPTY}' or '${valor}' == 'None' or '${valor}' == ''
            Fail
        END

        ${valor}                 Convert To Number    ${valor}    2
        ${VALOR_COMPRA_TOTAL}=   Evaluate    ${VALOR_COMPRA_TOTAL} + float(${valor})

    END

    ${TOTAL_VALOR_APAGAR}    Convert To Number    ${TOTAL_VALOR_APAGAR}    2
    ${VALOR_COMPRA_TOTAL}    Convert To Number    ${VALOR_COMPRA_TOTAL}    2

    Log To Console    ════════════════════════════════════════════
    Log To Console    Compras: ${BUFF_COD_COMPRAS_LOTE}
    Log To Console    Fornecedores: ${BUFF_FORNECEDORES_LOTE}
    Log To Console    Valores Compras: ${BUFF_VALORES_COMPRAS}
    Log To Console    Total Compras: ${VALOR_COMPRA_TOTAL}
    Log To Console    Total Contas a Pagar (lote): ${TOTAL_VALOR_APAGAR}
    Log To Console    ════════════════════════════════════════════


    #Validação final compara valores de todo o processo da compra
    Should Be Equal As Numbers    ${TOTAL_VALOR_APAGAR}    ${VALOR_COMPRA_TOTAL}    precision=2

    Log    ✓ Valor total das contas a pagar está correto: ${TOTAL_VALOR_APAGAR}
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

    IF    ${QUANTIDADE_PRODUTOS_COMPRADOS} > ${QUANTIDADE_DEVOLVIDA} or ${QUANTIDADE_PRODUTOS_COMPRADOS} == ${QUANTIDADE_DEVOLVIDA}

        RETURN

    END

    Wait Until Screen Contain    ${AVISO_DEVOLVIDO_SUPERIOR_A_COMPRADO}    ${TEMPO_TELA}
    
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

# -----------------------------------------
# Valor da compra
# -----------------------------------------
#futuro compras em lote SELECT COALESCE(SUM(ValorTotal), 0) AS Total FROM compraconsignada WHERE codigoFornecedor = 70 AND STATUS = 'f';


E valido valor da compra
    [Documentation]    Verifica se o valor da compra está correto no banco de dados

    # ── Buscar valor total da compra ───────────────────────────────────────
    ${valor_compra_result}    Query    SELECT valorTotal FROM compraconsignada WHERE codigo = ${COD_COMPRA} AND Cancelada = 0 LIMIT 1;

    Should Not Be Empty    ${valor_compra_result}
    ...    Compra Consignada com código ${COD_COMPRA} não foi encontrada no banco de dados.

    ${valor_compra}    Set Variable    ${valor_compra_result[0][0]}

    # ── Buscar soma dos produtos da compra ─────────────────────────────────
    ${valor_produto_result}    Query    SELECT SUM(CASE WHEN Tipo = 'DV' THEN -ValorTotal ELSE ValorTotal END) AS ValorTotalCalculado FROM compraconsignada_produtos WHERE codigoCompra = '${COD_COMPRA}' AND cancelado = 0;

    Should Not Be Empty    ${valor_produto_result}
    ...    Nenhum produto foi encontrado para a Compra Consignada ${COD_COMPRA}.

    ${VALOR_PRODUTO_TOTAL}    Set Variable    ${valor_produto_result[0][0]}

    # ── Validar se os valores não são None/vazio ──────────────────────────
    IF    '${valor_compra}' == 'None' or '${valor_compra}' == '${EMPTY}' or ${valor_compra} is None
        ${valor_compra}=    Set Variable    0
    END

    IF    '${VALOR_PRODUTO_TOTAL}' == 'None' or '${VALOR_PRODUTO_TOTAL}' == '${EMPTY}' or ${VALOR_PRODUTO_TOTAL} is None
        ${VALOR_PRODUTO_TOTAL}=    Set Variable    0
    END

    # ── Converter e comparar valores ──────────────────────────────────────
    ${valor_compra}              Convert To Number    ${valor_compra}    2
    ${VALOR_PRODUTO_TOTAL}       Convert To Number    ${VALOR_PRODUTO_TOTAL}    2

    Log    ✓ valor_compra: ${valor_compra}
    Log    ✓ VALOR_PRODUTO_TOTAL: ${VALOR_PRODUTO_TOTAL}

    Should Be Equal As Numbers
    ...    ${valor_compra}
    ...    ${VALOR_PRODUTO_TOTAL}
    ...    precision=2

    Log    ✓ Valor da compra está correto: ${valor_compra}

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
