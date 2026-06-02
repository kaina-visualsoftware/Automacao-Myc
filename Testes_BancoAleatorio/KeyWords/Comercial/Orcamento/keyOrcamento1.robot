*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot

*** Variables ***

# Telas
${TELA_ORC_ADICIONAR}                        tela_OrcamentoAdicionar.png
${MODAL_GERAR_VENDA_ORCAMENTO}               modal_GerarVendaOrcamento.png
${TELA_ALTERACAO_STATUS_ORCAMENTO}           tela_AlteracaoStatusOrcamento.png
${TELA_STATUS_ORCAMENTO}                     tela_StatusOrcamento.png

# Botões
${BT_GERAR_PRE_VEN}                          bt_GerarPreVen.png

# Telas Avisos
${AVISO_DESEJA_EXCLUIR}                      aviso_DesejaExcluir.png
${AVISO_SELECIONAR_TODOS_ORCAMENTOS_GRID}    aviso_SelecionarTodosOrcamentosDoGrid.png

# Icones
${ICONE_PASTA_STATUS}                        icone_PastaStatusOrcamento.png

# Inputs
${INPUT_QUANTIDADE_SERVICO}                  input_QuantidadeServico.png
${INPUT_DESCRICAO_STATUS_ORC}                input_DescricaoStatusOrcamento.png

# Labels
${LABEL_CRITERIO_CODIGO_ORC}                 label_CriterioCodigo_Orcamento.png
${LABEL_REGISTRO_ENCONTRADO_ORC}             lb_RegistroEncontradoOrcamento.png
${LABEL_NOVO_STATUS}                         lb_NovoStatusOrcamento.png
${LABEL_DESCONTO_FINAL_ORCAMENTO}            lb_DescontoFinalOrcamento.png

# Abas
${ABA_PAGAMENTOS}                            aba_Pagamentos.png

# Outros
${GRID_REGISTRO_STATUS_AUTOMACAO}            grid_RegistroStatusAutomacaoOrcamento.png
${GRID_STATUS_ORCAMENTO}                     grid_StatusOrcamento.png
${GRID_SEM_ORCAMENTOS_GERACAO_VENDAS}        grid_SemOrcamentosGeracaoVendasAgrup.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${COD_ORCAMENTO}                             None
${Codigo_Pedido}                             None
${Codigo_Venda_Gerada}                       None
${Codigos_Servicos}                          ${None}
${Quantidade_Servico}                        None
${QUANTIDADE_SERVICOS}                       None
${VALOR_FINAL_ORCAMENTO}                     None
${Orc_PossuiProduto}                         ${False}
${Orc_PossuiServico}                         ${False}
${Desconto_Maximo_Produto}                   ${None}
${Status_Orc_Com_Senha_Supervisor}           ${False}
${Status_Orcamento}                          ${None}

*** Keywords ***
Dado que acesso a tela de orçamentos
    
    ${FORMA_PADRAO}    Valida Configuracoes Venda
    Set Test Variable    ${FORMA_PADRAO}
    ${FORMA_PRAZO}    Seleciona Forma Prazo

    Type With Modifiers    O    CTRL

    Valida lançamento de orçamento em aberto

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar

    Press Combination    KEY.ALT    KEY.A

    Valida indicação de venda(${Parametro_IndicacaoOrcamento})

    Valida local de negociação da venda

    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_ORCAMENTO}

E adiciono vendedor e cliente
    
    utils.Adicionar Vendedor e Cliente(Orcamento)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando insiro mais de um produto normal(${QuantidadeDeProduto})

    ${Quantidade_Produto}    Considera quantidade padrão de produtos quando utilizado múltiplos produtos    ${Parametro_QtdePadraoOrcamentos}
    
    ${Codigos_Produtos}    Create List

    FOR    ${I}    IN RANGE    ${QuantidadeDeProduto}

        Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Produtos}
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QuantidadeDeProduto}

Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

    IF     ${Parametro_RealizaVendaSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END

    IF     ${Parametro_Permite_Varias_Tabelas}

        Valida a tela de preços & prazos de pagamentos

    END

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

    Set Test Variable    ${Orc_PossuiProduto}    ${True}

Então gravo o orçamento
    
    # Caso for cenário de agrupamento de produtos, desmarca o checkbox para não impactar os outros cenários.
    IF    ${Teste_Orcamento_Agrupamento_Produto}
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.P
    
        SikuliLibrary.Click    ${CHECKBOX_INFORMA_AGRUPAMENTO}
    
    END

    ${FORMA_PACELAMENTO_CLIENTE}    Verifica Forma Parcelamento Cliente    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.M 
    Sleep    ${SLEEP_BAIXO}

    Valida cliente com vales compra disponíveis

    Calcula valor final do orçamento

    IF    '${FORMA_PACELAMENTO_CLIENTE}' == 'Personalizada'
        
        Wait Until Screen Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

        FOR    ${I}    IN RANGE    3
            
            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Press Combination    KEY.ALT    KEY.G

    END

    Wait Until Screen Contain    ${ABA_PAGAMENTOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.G

    Valida impressao direta de venda(${Parametro_ImprimirVendaAoFinalizarVenda})

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    utils.Verifica status padrão de orçamento    OrcamentoGravado    ${Status_Orcamento}

Então visualizo o orçamento
    
    Press Combination    KEY.ALT    KEY.U
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.r
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

Quando clico em editar

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_BAIXO}

    Valida indicação de venda(${Parametro_IndicacaoOrcamento})

    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}

    Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando clico em excluir

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.X

    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

Então finalizo a exclusão

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Type    ${EMPTY}    Exclusao de Venda - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${orcamento_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM orcamentos o WHERE o.Codigo = ${COD_ORCAMENTO} AND o.`Status` = 'x' AND o.Cancelada = 1 AND o.ExclusaoMotivo IS NOT NULL;
    
    Should Be True    ${orcamento_excluido}    Orçamento não foi excluído corretamente.
    
Informa a quantidade do produto(${Quantidade_Produto})

    IF    $Parametro_QuantidadePadraoProduto is not None and ${Quantidade_Produto} != ${Parametro_QuantidadePadraoProduto}
        
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

Quando insiro um produto normal informando a quantidade e desconto(${Quantidade_Produto}, ${Desconto_Produto})

    IF     ${Parametro_RealizaVendaSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END

    IF     ${Parametro_Permite_Varias_Tabelas}

        Valida a tela de preços & prazos de pagamentos

    END

    Informa a quantidade e desconto do produto(${Quantidade_Produto}, ${Desconto_Produto})

    utils.Valida parametros após incluir produto

    Set Test Variable    ${Quantidade_Produto}
    Set Test Variable    ${Desconto_Produto}
    Set Test Variable    ${Orc_PossuiProduto}    ${True}

Informa a quantidade e desconto do produto(${Quantidade_Produto}, ${Desconto_Produto})

    IF    ${Quantidade_Produto} != ${Parametro_QuantidadePadraoProduto}

        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Input Text    ${EMPTY}    ${Desconto_Produto}
    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

Então valido a venda gerada a partir do orçamento com desconto
    
    Sleep    ${SLEEP_BAIXO}
    ${consulta_venda}    Query    SELECT v.TotalPedido FROM vendas v WHERE v.Codigo = ${COD_VENDA} AND v.CodOrcamento = ${COD_ORCAMENTO} AND v.Cancelada IS NULL;

    ${valor_total_venda}    Set Variable    ${consulta_venda[0][0]}
    
    Sleep    ${SLEEP_BAIXO}

    Should Be Equal As Numbers    ${valor_total_venda}    ${VALOR_FINAL_ORCAMENTO}

E pesquiso pelo orçamento gerado

    Sleep    ${SLEEP_BAIXO}
    
    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_BAIXO}

    ${criterioCodigo}    Exists    ${LABEL_CRITERIO_CODIGO_ORC}

    IF    not ${criterioCodigo}

        SikuliLibrary.Click    ${LABEL_CODIGO_GRID}
        
    END

    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}
    
    ${codigo_orcamento}    Convert To String    ${COD_ORCAMENTO}

    Input Text    ${EMPTY}    ${codigo_orcamento}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER

    Wait Until Screen Contain    ${LABEL_REGISTRO_ENCONTRADO_ORC}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${LABEL_REGISTRO_ENCONTRADO_ORC}

Quando clico em gerar venda

    Press Combination    KEY.ALT    KEY.G

    Wait Until Screen Contain    ${MODAL_GERAR_VENDA_ORCAMENTO}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Verifica se cliente possui condicional em aberto(${Codigo_Cliente})

    IF    ${Parametro_InfoCreditoClienteVenda}

        Valida informações de crédito

    END

    Valida indicação de venda(${Parametro_IndicacaoVenda})

    Valida vencimento em fins de semana e feriados(1)    

    Valida parâmetros/impressões pós venda

    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

    Consulta venda gerada a partir do orçamento

    keyVendas1.Valida baixa de estoque

Validação da venda gerada a partir do orçamento

    ${Codigo_Venda_Gerada_Orc}    Query    SELECT Codigo FROM vendas AS v WHERE v.CodOrcamento = ${COD_ORCAMENTO} AND v.`Status` = 'f';

    Should Be Equal    ${COD_VENDA}    ${Codigo_Venda_Gerada_Orc[0][0]}

    Set Test Variable    ${Codigo_Venda_Gerada}    ${Codigo_Venda_Gerada_Orc[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Venda_Gerada}

    utils.Verifica status padrão de orçamento    GeradoVenda

Consulta venda gerada a partir do orçamento

    ${Consulta}    Query    SELECT v.Codigo FROM vendas v WHERE v.CodOrcamento = ${COD_ORCAMENTO} AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

E acesso a guia Pagamentos

    Press Combination    KEY.ALT    KEY.M 
    Sleep    ${SLEEP_BAIXO}

    Valida cliente com vales compra disponíveis

Então gero pré-venda do orçamento

    Press Combination    KEY.ALT    KEY.V

    Processa geração de pré-venda do orçamento

Validação da pré-venda gerada a partir do orçamento

    Check If Exists In Database    SELECT 1 FROM pedidosvenda pv WHERE pv.CodigoOrcamento = ${COD_ORCAMENTO} AND pv.Codigo = ${Codigo_Pedido} AND pv.`Status` = 'f' AND pv.Cancelada IS NULL;

    Check If Exists In Database    SELECT 1 FROM orcamentos o WHERE o.Codigo = ${COD_ORCAMENTO} AND o.`Status` = 'p';

Processa geração de pré-venda do orçamento

    Valida impressão pré-venda ao finalizar pré-venda

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

    ${codigo_do_pedido}    Query    SELECT pv.Codigo FROM pedidosvenda pv WHERE pv.CodigoOrcamento = ${COD_ORCAMENTO} AND pv.`Status` = 'f' AND pv.Cancelada IS NULL AND pv.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    Set Test Variable    ${Codigo_Pedido}    ${codigo_do_pedido[0][0]}

    Valida baixa de estoque

    Validação da pré-venda gerada a partir do orçamento

    utils.Verifica status padrão de orçamento    GeradoPreVenda

Valida baixa de estoque

    Log To Console    \n

    IF    ${Parametro_BaixaEstoquePreVenda}

        ${COD_OPERACAO}    Set Variable    ${Codigo_Pedido}

        Sleep    ${SLEEP_MEDIO}

        IF    ${QUANTIDADE_PRODUTOS} > 1

            FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

                ${COD_PRODUTO}    Set Variable    ${Codigos_Produtos[${i}]}

                ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_OPERACAO}    ${QTDE_BAIXA_PRODUTO}

                IF    ${Baixa_De_Estoque}
                    Log To Console    Baixou estoque corretamente do produto [${COD_PRODUTO}] na pré-venda gerada a partir do orçamento!
                ELSE
                    Fail    Falha na baixa do estoque do produto [${COD_PRODUTO}] na pré-venda gerada a partir do orçamento! Verifique!
                END

            END

        ELSE

            ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_OPERACAO}    ${QTDE_BAIXA_PRODUTO}

            IF    ${Baixa_De_Estoque}
                Log To Console    Baixou estoque corretamente do produto [${COD_PRODUTO}] na pré-venda gerada a partir do orçamento!
            ELSE
                Fail    Falha na baixa do estoque do produto [${COD_PRODUTO}] na pré-venda gerada a partir do orçamento! Verifique!
            END

        END

    ELSE

        IF    ${QUANTIDADE_PRODUTOS} > 1

            FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

                ${COD_PRODUTO}    Set Variable    ${Codigos_Produtos[${i}]}

                ${movimentou_estoque}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM produtosestoque pe WHERE pe.CodigoOperacao = ${Codigo_Pedido} AND pe.CodigoProduto = ${COD_PRODUTO};

                IF    ${movimentou_estoque}
                    Fail    O parâmetro BaixaEstoquePreVenda está desabilitado, mas houve movimentação de estoque para o produto [${COD_PRODUTO}] na pré-venda!
                ELSE
                    Log To Console    Produto [${COD_PRODUTO}] não teve movimentação de estoque na pré-venda, conforme esperado.
                END

            END

        ELSE

            ${movimentou_estoque}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM produtosestoque pe WHERE pe.CodigoOperacao = ${Codigo_Pedido} AND pe.CodigoProduto = ${COD_PRODUTO};

            IF    ${movimentou_estoque}
                Fail    O parâmetro BaixaEstoquePreVenda está desabilitado, mas houve movimentação de estoque para o produto [${COD_PRODUTO}] na pré-venda!
            ELSE
                Log To Console    Produto [${COD_PRODUTO}] não teve movimentação de estoque na pré-venda, conforme esperado.
            END

        END

    END

E clico em Gerar Pré-Ven

    SikuliLibrary.Click    ${BT_GERAR_PRE_VEN}

    Processa geração de pré-venda do orçamento

Quando insiro um serviço informando a quantidade(${Quantidade_Servico})

    utils.Inserir serviço

    Informa a quantidade do serviço(${Quantidade_Servico})

    utils.Validação após incluir serviço

    Press Combination    KEY.ALT    KEY.I

    Set Test Variable    ${Orc_PossuiServico}    ${True}

Quando insiro mais de um serviço(${QuantidadeDeServico})

    ${Codigos_Servicos}    Create List

    FOR    ${i}    IN RANGE    ${QuantidadeDeServico}

        Quando insiro um serviço informando a quantidade(1)

        Append To List    ${Codigos_Servicos}    ${COD_SERVICO}

    END

    Set Test Variable    ${Codigos_Servicos}
    Set Test Variable    ${QUANTIDADE_SERVICOS}    ${QuantidadeDeServico}

Informa a quantidade do serviço(${Quantidade_Servico})

    IF    ${Quantidade_Servico} != 1

        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_SERVICO}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Servico}

    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Servico}

E pressiono o atalho de alterar status

    Press Combination    KEY.ALT    KEY.T

    Wait Until Screen Contain    ${TELA_ALTERACAO_STATUS_ORCAMENTO}    ${TEMPO_TELA}

E altero o status do orçamento após finalizar o orçamento
    [Arguments]    ${status}

    Garante status para orçamento    ${status}

    SikuliLibrary.Click    ${ICONE_PASTA_STATUS}

    Wait Until Screen Contain    ${TELA_STATUS_ORCAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${INPUT_DESCRICAO_STATUS_ORC}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${status}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${GRID_STATUS_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S

    IF    ${Status_Orc_Com_Senha_Supervisor}

        utils.Valida solicitação de senha do supervisor para liberação de alteração de status do orçamento

    END

    Press Combination    KEY.ALT    KEY.G

    Wait Until Screen Not Contain    ${TELA_STATUS_ORCAMENTO}    ${SLEEP_ALTO}

    Set Test Variable    ${Status_Orcamento}    ${status}

E altero o status do orçamento durante o lançamento do orçamento
    [Arguments]    ${status}

    Garante status para orçamento    ${status}

    SikuliLibrary.Click    ${ICONE_PASTA_STATUS}

    Wait Until Screen Contain    ${TELA_STATUS_ORCAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${INPUT_DESCRICAO_STATUS_ORC}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${status}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${GRID_STATUS_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S

    IF    ${Status_Orc_Com_Senha_Supervisor}

        utils.Valida solicitação de senha do supervisor para liberação de alteração de status do orçamento

    END

    Set Test Variable    ${Status_Orcamento}    ${status}

E valido a alteração de status do orçamento

    Check If Exists In Database    SELECT 1 FROM orcamentos WHERE Codigo = ${COD_ORCAMENTO} AND StatusOR = '${Status_Orcamento}' AND IDStatusOR = (SELECT Codigo FROM status_registros WHERE Descricao = '${Status_Orcamento}' AND Excluido = 0);

Calcula valor final do orçamento

    ${soma_valor_total_produtos}    Evaluate    0

    IF    ${Orc_PossuiProduto}

        Sleep    ${SLEEP_BAIXO}

        ${consulta_orcamento_produtos}    Query    SELECT ocp.ValorUnitario, ocp.ValorTotal FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = ${COD_ORCAMENTO} AND ocp.Cancelada IS NULL ORDER BY ocp.Sequencia;

        ${consulta_qtde_produtos}    Query    SELECT COUNT(*) FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = ${COD_ORCAMENTO} AND ocp.Cancelada IS NULL;

        ${QUANTIDADE_PRODUTOS}    Set Variable    ${consulta_qtde_produtos[0][0]}

        FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

            ${produto_valor_unitario}    Set Variable    ${consulta_orcamento_produtos[${i}][0]}
            ${produto_valor_total}       Set Variable    ${consulta_orcamento_produtos[${i}][1]}

            ${calc_valor_total_produto}    Evaluate    round((${Quantidade_Produto} * ${produto_valor_unitario}), 2)

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calc_valor_total_produto}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calc_valor_total_produto}    ${produto_valor_total}

            ${soma_valor_total_produtos}    Evaluate    round((${soma_valor_total_produtos} + ${calc_valor_total_produto}), 2)

        END

    END

    ${soma_valor_total_servicos}    Evaluate    0

    IF    ${Orc_PossuiServico}

        Sleep    ${SLEEP_BAIXO}

        ${consulta_orcamento_servicos}    Query    SELECT ocs.ValorUnitario, ocs.ValorTotal FROM orcamentosservicos ocs WHERE ocs.CodigoOrcamento = ${COD_ORCAMENTO} AND ocs.Cancelada IS NULL ORDER BY ocs.Sequencia;

        ${consulta_qtde_servicos}    Query    SELECT COUNT(*) FROM orcamentosservicos ocs WHERE ocs.CodigoOrcamento = ${COD_ORCAMENTO} AND ocs.Cancelada IS NULL;

        ${QUANTIDADE_SERVICOS}    Set Variable    ${consulta_qtde_servicos[0][0]}

        FOR    ${i}    IN RANGE    ${QUANTIDADE_SERVICOS}

            ${servico_valor_unitario}    Set Variable    ${consulta_orcamento_servicos[${i}][0]}
            ${servico_valor_total}       Set Variable    ${consulta_orcamento_servicos[${i}][1]}

            ${calc_valor_total_servico}    Evaluate    (decimal.Decimal(str(${servico_valor_unitario})) * decimal.Decimal(str(${Quantidade_Servico}))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calc_valor_total_servico}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calc_valor_total_servico}    ${servico_valor_total}

            ${soma_valor_total_servicos}    Evaluate    round((${soma_valor_total_servicos} + float(${calc_valor_total_servico})), 2)

        END

    END

    ${calc_valor_total_orcamento}    Evaluate    round((${soma_valor_total_produtos} + ${soma_valor_total_servicos}), 2)

    Sleep    ${SLEEP_BAIXO}
    ${valor_total_orcamento}    Query    SELECT ROUND(IFNULL((SELECT SUM(ocp.ValorTotal) FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = o.Codigo AND ocp.Cancelada IS NULL), 0) + IFNULL((SELECT SUM(ocs.ValorTotal) FROM orcamentosservicos ocs WHERE ocs.CodigoOrcamento = o.Codigo AND ocs.Cancelada IS NULL), 0), 2) AS TotalGeral FROM orcamentos o WHERE o.Codigo = ${COD_ORCAMENTO};

    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${calc_valor_total_orcamento}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calc_valor_total_orcamento}    ${valor_total_orcamento[0][0]}

    Set Test Variable    ${VALOR_FINAL_ORCAMENTO}    ${valor_total_orcamento[0][0]}

Calcula valor final do orçamento com desconto
    
    ${soma_valor_total_produtos}    Evaluate    0

    Sleep    ${SLEEP_BAIXO}
    
    ${consulta_orcamento_produtos}    Query    SELECT ocp.ValorTabela, ocp.ValorUnitario, ocp.ValorTotal FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = ${COD_ORCAMENTO} AND ocp.Cancelada IS NULL ORDER BY ocp.Sequencia;

    ${consulta_qtde_produtos}    Query    SELECT COUNT(*) FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = ${COD_ORCAMENTO} AND ocp.Cancelada IS NULL;

    ${QUANTIDADE_PRODUTOS}    Set Variable    ${consulta_qtde_produtos[0][0]}

    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

        ${produto_valor_tabela}      Set Variable    ${consulta_orcamento_produtos[${i}][0]}
        ${produto_valor_unitario}    Set Variable    ${consulta_orcamento_produtos[${i}][1]}
        ${produto_valor_total}       Set Variable    ${consulta_orcamento_produtos[${i}][2]}

        IF    $Desconto_Maximo_Produto is None

            # Desconto aplicado na linha do produto
            ${calc_valor_unitario_com_desconto_produto}    Evaluate    round((${produto_valor_tabela} - (${produto_valor_tabela} * (${Desconto_Produto} / 100))), 2)

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calc_valor_unitario_com_desconto_produto}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calc_valor_unitario_com_desconto_produto}    ${produto_valor_unitario}

            ${calc_valor_total_produto}    Evaluate    round((${Quantidade_Produto} * ${produto_valor_unitario}), 2)

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calc_valor_total_produto}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calc_valor_total_produto}    ${produto_valor_total}

        ELSE

            # Desconto aplicado na guia Pagamentos
            ${calc_valor_total_produto}    Evaluate    round((${produto_valor_total} * (1 - ${Desconto_Produto} / 100)), 2)

        END

        ${soma_valor_total_produtos}    Evaluate    round((${soma_valor_total_produtos} + ${calc_valor_total_produto}), 2)

    END

    IF    $Desconto_Maximo_Produto is None

        Sleep    ${SLEEP_BAIXO}
        ${valor_total_produtos_venda}    Query    SELECT ROUND(SUM(ocp.ValorTotal), 2) FROM orcamentosprodutos ocp WHERE ocp.CodigoOrcamento = ${COD_ORCAMENTO} AND ocp.Cancelada IS NULL

        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${soma_valor_total_produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${soma_valor_total_produtos}    ${valor_total_produtos_venda[0][0]}

        Set Test Variable    ${VALOR_FINAL_ORCAMENTO}    ${valor_total_produtos_venda[0][0]}

    ELSE

        # Desconto na guia Pagamentos
        Set Test Variable    ${VALOR_FINAL_ORCAMENTO}    ${soma_valor_total_produtos}

    END

Então gravo o orçamento - Com desconto
    
    # Caso for cenário de agrupamento de produtos, desmarca o checkbox para não impactar os outros cenários.
    IF    ${Teste_Orcamento_Agrupamento_Produto}
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.P
    
        SikuliLibrary.Click    ${CHECKBOX_INFORMA_AGRUPAMENTO}
    
    END

    ${FORMA_PACELAMENTO_CLIENTE}    Verifica Forma Parcelamento Cliente    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.M
    Sleep    ${SLEEP_BAIXO}

    Valida cliente com vales compra disponíveis

    IF    $Desconto_Maximo_Produto is not None

        SikuliLibrary.Double Click    ${LABEL_DESCONTO_FINAL_ORCAMENTO}
        Wait Until Screen Contain    ${LABEL_FOCO_DESCONTO_FINAL_VENDA}    ${SLEEP_ALTO}

        Input Text    ${EMPTY}    ${Desconto_Produto}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        validacaoAviso.Valida tela de liberação de desconto

    END

    Calcula valor final do orçamento com desconto

    IF    '${FORMA_PACELAMENTO_CLIENTE}' == 'Personalizada'
        
        Wait Until Screen Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

        FOR    ${I}    IN RANGE    3
            
            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Press Combination    KEY.ALT    KEY.G

    END

    Wait Until Screen Contain    ${ABA_PAGAMENTOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.G

    utils.Valida desconto que não se encaixa em nenhuma escala de comissão

    IF    ${Parametro_LiberaDescontoMaiorMaximo}

        IF    $Desconto_Maximo_Produto is not None and ${Desconto_Produto} > ${Desconto_Maximo_Produto}
            
            validacaoAviso.Valida tela de retorno de liberação de desconto maior que o máximo do produto

        END
        
    END    

    Valida impressao direta de venda(${Parametro_ImprimirVendaAoFinalizarVenda})

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Garante status para orçamento
    [Arguments]    ${status}

    ${possui_status_automacao}    Query    SELECT EXISTS (SELECT 1 FROM status_registros WHERE Descricao = '${status}' AND Excluido = 0);

    IF    ${possui_status_automacao[0][0]} == 0

        IF    '${status}' == 'SENHA_SUPERVISOR'
            Execute Sql String    INSERT INTO status_registros (Sequencia, Tipo, Codigo, Descricao, Cor, PadraoAbrir, PadraoFechar, ExibirAlerta, ExigirSenhaSupervisor, Excluido, Usuario_exclusao, Terminal_exclusao, Data_exclusao, padraoGerarPreVenda) VALUES ((SELECT COALESCE(MAX(Sequencia), 0) + 1 FROM status_registros), 'O', (SELECT COALESCE(MAX(Codigo), 0) + 1 FROM status_registros), '${status}', '9408399', 0, 0, 0, 1, 0, NULL, NULL, NULL, 0);
        ELSE
            Execute Sql String    INSERT INTO status_registros (Sequencia, Tipo, Codigo, Descricao, Cor, PadraoAbrir, PadraoFechar, ExibirAlerta, ExigirSenhaSupervisor, Excluido, Usuario_exclusao, Terminal_exclusao, Data_exclusao, padraoGerarPreVenda) VALUES ((SELECT COALESCE(MAX(Sequencia), 0) + 1 FROM status_registros), 'O', (SELECT COALESCE(MAX(Codigo), 0) + 1 FROM status_registros), '${status}', '9408399', 0, 0, 0, 0, 0, NULL, NULL, NULL, 0);
        END
    END

    ${status_necessita_senha_supervisor}    Query    SELECT sr.ExigirSenhaSupervisor FROM status_registros AS sr WHERE sr.Descricao = '${status}' AND sr.Excluido = 0

    IF    ${status_necessita_senha_supervisor[0][0]} == 1

        Set Test Variable    ${Status_Orc_Com_Senha_Supervisor}    ${True}

    END

Quando insiro um produto com desconto maior que o desconto máximo

    IF     ${Parametro_RealizaVendaSemEstoque}

        ${codProduto}    Query    SELECT p.Codigo, p.DescontoMaximo FROM produtos AS p WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND p.DescontoMaximo IS NOT NULL AND p.DescontoMaximo != 100 AND p.DescontoMaximo > 0 AND p.DescontoMaximo < 99 ORDER BY RAND() LIMIT 1;

    ELSE

        ${codProduto}    Query    SELECT p.Codigo, p.DescontoMaximo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque >= 1 WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND p.DescontoMaximo IS NOT NULL AND p.DescontoMaximo != 100 AND p.DescontoMaximo > 0 AND p.DescontoMaximo < 99 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;

    END

    IF    len($codProduto) == 0
        Fail    Nenhum produto com DescontoMaximo válido encontrado. Verifique os cadastros no MyCommerce.
    END

    ${Desconto_Maximo_Produto}    Set Variable    ${codProduto[0][1]}

    ${Desconto_Produto}    Evaluate    random.randint(int(${Desconto_Maximo_Produto}) + 1, 99)    modules=random

    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codProduto[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}
    Set Test Variable    ${Desconto_Maximo_Produto}

    IF     ${Parametro_Permite_Varias_Tabelas}

        Valida a tela de preços & prazos de pagamentos

    END

    Informa a quantidade do produto(1)

    utils.Valida parametros após incluir produto

    Set Test Variable    ${Desconto_Produto}
    Set Test Variable    ${Orc_PossuiProduto}    ${True}

Quando o atalho de Venda Agrup

    Press Combination    KEY.ALT    KEY.V

    Wait Until Screen Contain    ${AVISO_SELECIONAR_TODOS_ORCAMENTOS_GRID}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Not Contain    ${GRID_SEM_ORCAMENTOS_GERACAO_VENDAS}    ${SLEEP_ALTO}

Então gero a venda agrupada do orçamento

    Press Combination    KEY.ALT    KEY.V

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_BAIXO}

    validacaoAviso.Valida vencimento em fins de semana e feriados(1)

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.F

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'

        IF    ${Parametro_ControlaCreditoVenda}

            Valida Controle de Credito - Liberação(${VALOR_FINAL_VENDA})

            Valida solicitação de senha do usuário supervisor

        END

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    Valida solicitação de senha do usuário supervisor

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'

        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}

                Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA})

            END

        END

    END

    Valida vencimento em fins de semana e feriados(1)

    Valida parâmetros/impressões pós venda

    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

    Consulta venda gerada a partir do orçamento

    keyVendas1.Valida baixa de estoque