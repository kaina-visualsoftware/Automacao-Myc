*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/validaComissoes.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Library    XML
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Telas
${TELA_ADICIONAR_ORDEM_DE_SERVICO}     tela_OrdemDeServicoAdicionar.png
${TELA_FATURAMENTO_OS}                 modal_OpcoesDeFaturamento.png
${TELA_IMPRIME_CARNE_OS}               tela_ImprimeCarneOS.png
${TELA_VISUALIZA_VENDA}                tela_VisualizaVenda.png
${TELA_EXCLUIR_PAGAMENTOS_OS}          aviso_ExcluirPagOS.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}           tela_exclusaoVenda.png
${TELA_SIMULADOR_FORMA_PACELAMENTO}    tela_SimuladorFormaParcelamento.png
${TELA_CHECKLIST}                      tela_CheckList.png
${TELA_NFS-E}                          tela_NFSe.png
${TELA_OPCOES_FATURAMENTO}             tela_OpcoesFaturamento.png
${GUIA_SERVICOS_OS}                    guia_ServicosOS.png
${TELA_ALTERACAO_STATUS_OS}            tela_AlteracaoStatusOS.png
${TELA_INCLUSAO_INSUMOS}               tela_InclusaoInsumos.png
${TELA_STATUS_OS}                      tela_StatusOS.png

# Telas Avisos
${AVISO_NFSE_REJEITADA}                aviso_NFSeRejeitada.png
${AVISO_NFSE_COM_PROBLEMA}             aviso_NFSeComProblema.png
${AVISO_NFSE_PROCESSAMENTO}            aviso_NFSeProcessamento.png
${RETORNO_NFS}                         retornoNFS.png
${AVISO_STATUS_ATUALIZADO}             aviso_StatusAtualizadoOS.png

# Icones
${ICONE_PASTA_STATUS_OS}               icone_PastaStatusOS.png

# Botões
${BT_EXCLUIR_PAGAMENTOS}               bt_ExcluirPag.png
${BT_SIMULADOR_FORMAS_PARCELAMENTO}    tela_SimulacaoRecebimentos.png
${BT_ADICIONAR}                        bt_Adicionar.png
${BT_EDITAR}                           bt_Editar.png
${BT_FECHAR_OS}                        bt_FecharOS.png
${BT_REABRIR_OS}                       bt_ReabrirOS.png

# Inputs
${INPUT_QUANTIDADE_PRODUTO}            input_QuantidadeProduto.png
${INPUT_QUANTIDADE_SERVICO}            input_QuantidadeServico.png
${INPUT_DESCRICAO_STATUS_OS}           input_DescricaoStatusOS.png

# Labels
${LABEL_DESCRIÇÃO}                     lb_Descricao.png
${LABEL_AGUARDE_GERANDO_NFSE}          lb_AguardeGerandoNFSe.png
${LABEL_EMITIR_BOLETOS}                lb_EmitirBoletos.png
${LABEL_CRITERIO_CODIGO_OS}            label_CriterioCodigo_OS.png
${LABEL_CODIGO_GRID}                   lb_Codigo_Grid.png

# ComboBox
${COMBO_SERVICO_DO_INSUMO}             combo_ServicoDoInsumo.png

# Rows
${ROW_PAGAMENTO_INCLUSO}               row_PagIncluso.png
${ROW_INSUMO_INCLUSO_GRID}             insumo_incluso_grid.png
${ROW_ADIANTAMENTO_INCLUSO_GRID}       row_AdiantamentoInclusoOS.png

# Outros
${FORMA_RECEBIMENTO_OUTROS}            Outros...
${ABA_ADIANTAMENTOS_OS}                aba_AdiantamentosOS.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${CODIGO_OPERACAO_MOV}                 None
${COD_ORDEM_SERVICO}                   None
${Codigos_Servicos}                    ${None}
${DESCONTO_FORMA}                      None
${EntradaIgualA_Outros}                None
${modalidadeCB_OS}                     None
${Quantidade_Produto}                  None
${QUANTIDADE_SERVICOS}                 None
${QTDE_BAIXA_PRODUTO}                  None
${VALOR_FINAL_OPERAÇÃO}                None
${Valor_Total_Produtos}                None
${Valor_Total_Servicos}                None
${Qtde_Minima_Estoque}                 None
${valor_adiantamento}                  None
${OS_PossuiProduto}                    ${False}
${OS_PossuiServico}                    ${False}
${GRID_REGISTRO_ENCONTRADO}            grid_RegistroEncontrado.png
${Quantidade_Servico}                  ${1}
${List_Quantidades_Produto}            ${None}
${List_Quantidades_Servico}            ${None}

*** Keywords ***
Dado que acesso a tela de ordens de serviços
    
    ${FORMA_PADRAO}    Valida Configuracoes OS
    ${FORMA_PRAZO}     Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO}

    Press Special Key    F3

    Valida lançamento de ordem de serviço em aberto

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar
    
    SikuliLibrary.Click    ${BT_ADICIONAR}

    Valida indicação de venda(${Parametro_IndicacaoOS})

    Valida local de negociação da venda
    
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    Sleep    ${SLEEP_MEDIO}
    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_ORDEM_SERVICO}    ${Consulta[0][0]}

E adiciono vendedor e cliente
    
    utils.Adicionar Vendedor e Cliente(OrdemDeServico)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E insiro um serviço informando a quantidade(${Quantidade_Servico})

    IF    ${OS_Vendedor_E_Tecnico_Diferentes}

        Seleciona técnico executor do serviço

    END
    
    IF    ${Teste_Comissao_Linha_Servico}

        utils.Seleciona serviço com linha de comissão

    ELSE

        utils.Inserir serviço

    END

    Informa a quantidade do serviço(${Quantidade_Servico})

    utils.Validação após incluir serviço

    utils.Insere funcionários comissionados por serviço

    Set Test Variable    ${OS_PossuiServico}    ${True}

E insiro um produto normal informando a quantidade(${Quantidade_Produto})
    
    IF    ${Teste_Comissao_Linha}

        utils.Seleciona produto com linha cadastrada(${Parametro_VendaSemEstoqueOrdemDeServico})

    ELSE IF     ${Parametro_VendaSemEstoqueOrdemDeServico}
        
        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END
    
    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

    Set Test Variable    ${OS_PossuiProduto}    ${True}

E insiro um produto normal informando a quantidade e desconto(${Quantidade_Produto}, ${Desconto_Produto})

    IF     ${Parametro_VendaSemEstoqueOrdemDeServico}
        
        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END
    
    Informa a quantidade e desconto do produto(${Quantidade_Produto}, ${Desconto_Produto})

    utils.Valida parametros após incluir produto

    Set Test Variable    ${OS_PossuiProduto}    ${True}

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.M

    validacaoAviso.Valida cliente com vales compra disponíveis

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    ${EntradaIgualA_Outros}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'
        
        utils.Personalização de Pagamentos

    END 

    IF    ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto 

    END

Então finalizo a ordem de serviço

    Verifica vendedor com senha

    Calcula valor final da OS

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento em fins de semana e feriados(${FORMA_PADRAO[4]})

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto

    END

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.F

    Valida check list

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'

        IF    ${Parametro_ControlaCreditoOS}

            Press Special Key    TAB 
            Sleep    ${SLEEP_BAIXO}
            
            Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})

            Valida solicitação de senha do usuário supervisor

        END

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    Valida solicitação de senha do usuário supervisor

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'
        
        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Finalização com recebimento de duplicatas(${VALOR_FINAL_OS})

            END

        END

    END

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_ORDEM_SERVICO}

    Extrair dados da ordem de serviço gerada

Então visualizo a ordem de serviço
    
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.r
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${SLEEP_ALTO}

Quando clico em editar
    
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_EDITAR}
    Sleep    ${SLEEP_BAIXO}

    validacaoAviso.Valida edição de ordem de serviço finalizada

    IF    ${Parametro_InfoCreditoClienteVenda}

        Valida informações de crédito

    END

    Valida indicação de venda(${Parametro_IndicacaoOS})

    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

E excluo os pagamentos lançados

    validacaoAviso.Valida cliente com vales compra disponíveis
    
    # Validação até corrigir a tarefa 184700.
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.M 
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    SikuliLibrary.Click    ${BT_EXCLUIR_PAGAMENTOS}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PAGAMENTOS_OS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'

        utils.Personalização de Pagamentos

    END

Então finalizo a ordem de serviço - A Prazo
    
    Verifica vendedor com senha

    Calcula valor final da OS

    # Essa validação é necessária, pois caso há grids personalizados, não funciona a pesquisa da forma de parcelamento pela sua descrição.
    utils.Remove os grids personalizados de simulação de parcelas

    SikuliLibrary.Click    ${BT_SIMULADOR_FORMAS_PARCELAMENTO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        
    END

    Wait Until Screen Contain    ${TELA_SIMULADOR_FORMA_PACELAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${LABEL_DESCRIÇÃO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${FORMA_PRAZO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_BAIXO}

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto

    END

    Valida vencimento em fins de semana e feriados(${FORMA_PADRAO[4]})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.F

    IF    ${Parametro_ControlaCreditoVenda}
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}

        Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})
        
        Valida solicitação de senha do usuário supervisor

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.    
    Valida solicitação de senha do usuário supervisor

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_ORDEM_SERVICO}

Então clico em excluir

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.X
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitação de senha do usuário supervisor

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Type    ${EMPTY}    Exclusao de OS - Teste Automacao

    Press Special Key    TAB

    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${os_excluida}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_ORDEM_SERVICO} AND Status = 'x' AND Cancelada = 1
    Sleep    ${SLEEP_BAIXO}

    Should Be True    ${os_excluida}    Ordem de Serviço não foi excluída corretamente.

Calcula valor final da OS

    # Verificacao dinamica no banco - nao depende de variaveis setadas manualmente
    ${consultaProdutos}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};
    ${OS_PossuiProduto_DB}    Set Variable    ${consultaProdutos[0][0]}
    ${OS_PossuiProduto_DB}    Evaluate    ${OS_PossuiProduto_DB} > 0

    ${consultaServicos}    Query    SELECT COUNT(*) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL;
    ${OS_PossuiServico_DB}    Set Variable    ${consultaServicos[0][0]}
    ${OS_PossuiServico_DB}    Evaluate    ${OS_PossuiServico_DB} > 0

    ${somaValorTotalProdutos}    Evaluate    0

    IF    ${OS_PossuiProduto_DB}

        Sleep    ${SLEEP_BAIXO}
        ${consultaOSProdutos}     Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO} ORDER BY vp.Sequencia;

        ${consultaQtdeProdutos}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};

        ${QUANTIDADE_PRODUTOS}    Set Variable    ${consultaQtdeProdutos[0][0]}

        FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

            IF    $List_Quantidades_Produto is not None

                ${Quantidade_Produto}    Set Variable    ${List_Quantidades_Produto[${i}]}

            END

            ${Produto_ValorUnitario}    Set Variable    ${consultaOSProdutos[${i}][1]}
            ${Produto_ValorTotal}       Set Variable    ${consultaOSProdutos[${i}][2]}

            ${calcValorTotalProduto}    Evaluate    round((${Quantidade_Produto} * ${Produto_ValorUnitario}), 2)

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calcValorTotalProduto}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcValorTotalProduto}    ${Produto_ValorTotal}

            ${somaValorTotalProdutos}    Evaluate    (${somaValorTotalProdutos} + ${calcValorTotalProduto})

        END

    END

    ${somaValorTotalServicos}    Evaluate    0

    IF    ${OS_PossuiServico_DB}
        
        Sleep    ${SLEEP_BAIXO}
        ${consultaOSServicos}     Query    SELECT vs.CodigoServico, vs.ValorUnitario, vs.ValorTotal FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL ORDER BY vs.Sequencia;
        
        ${consultaQtdeServicos}    Query    SELECT COUNT(*) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL;

        ${QUANTIDADE_SERVICOS}    Set Variable    ${consultaQtdeServicos[0][0]}

        FOR    ${i}    IN RANGE    ${QUANTIDADE_SERVICOS}
            
            ${Servico_ValorUnitario}    Set Variable    ${consultaOSServicos[${i}][1]}
            ${Servico_ValorTotal}       Set Variable    ${consultaOSServicos[${i}][2]}

            ${calcValorTotalServico}    Evaluate    (decimal.Decimal(str(${Servico_ValorUnitario})) * decimal.Decimal(str(${Quantidade_Servico}))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${calcValorTotalServico}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcValorTotalServico}    ${Servico_ValorTotal}

            IF    not ${Parametro_NaoDeduzirISSQNComissaoOS}
        
                ${calcValorTotalServicoDeducaoTrbutos}    Evaluate    ((decimal.Decimal(str(${Servico_ValorUnitario})) - (decimal.Decimal(str(${Servico_ValorUnitario})) * (decimal.Decimal(str(${Total_Tributos_Servico})) / decimal.Decimal("100")))) * decimal.Decimal("1")).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

            END

            ${somaValorTotalServicos}    Evaluate    (${somaValorTotalServicos} + ${calcValorTotalServico})
            
        END

    END

    ${calcValorTotalOS}    Evaluate    round((${somaValorTotalProdutos} + ${somaValorTotalServicos}), 2)

    ${ValorTotalOS}    Query    SELECT ROUND(IFNULL((SELECT SUM(vp.ValorTotal) FROM vendasprodutos vp WHERE vp.CodigoVenda = v.Codigo AND vp.Cancelada IS NULL), 0) + IFNULL((SELECT SUM(vs.ValorTotal) FROM vendasservicos vs WHERE vs.CodigoVenda = v.Codigo AND vs.Cancelada IS NULL), 0), 2) AS TotalGeral FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO};

    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${calcValorTotalOS}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcValorTotalOS}    ${ValorTotalOS[0][0]}

    IF    ${OS_PossuiServico_DB} and not ${Parametro_NaoDeduzirISSQNComissaoOS}

        Set Test Variable    ${Valor_Total_Servicos}    ${calcValorTotalServicoDeducaoTrbutos}

    ELSE

        Set Test Variable    ${Valor_Total_Servicos}    ${somaValorTotalServicos}

    END

    Set Test Variable    ${Valor_Total_Produtos}    ${somaValorTotalProdutos}

    Set Test Variable    ${VALOR_FINAL_OS}    ${ValorTotalOS[0][0]}
    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_OS}
    
Valida avisos ao finalizar Ordem de serviço
    
    IF    ${Parametro_Imprime_OS}
        
        Valida impressao direta de venda(${Parametro_Imprime_OS})

    END

    IF    ${Parametro_Imprime_Carne_OS}

        Valida impressao carne OS 

    END

Valida faturamento os pos finalizar
    
    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_FATURAMENTO_OS}    ${TEMPO_TELA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.F 

    END

Valida impressao carne OS 

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRIME_CARNE_OS}    ${TEMPO_TELA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.N

    END
    
Valida check list
    
    IF    ${Check_List_Objeto}
        
        Wait Until Screen Contain    ${TELA_CHECKLIST}    ${TEMPO_TELA}

        ${Perguntas_CheckList}    Query    SELECT Pergunta, TipoResposta, Obrigar FROM checklist_questions WHERE CodigoCheckList = ${Codigo_CheckList}

        ${QuantidadePerguntas}    DatabaseLibrary.Row Count    SELECT Pergunta FROM checklist_questions WHERE CodigoCheckList = ${Codigo_CheckList}

        SikuliLibrary.Click Text    ${Perguntas_CheckList[0][0]}

        FOR    ${I}    IN RANGE    ${QuantidadePerguntas}
            
            IF    ${Perguntas_CheckList[${I}][2]} == 1

                Sleep    ${SLEEP_BAIXO}
                Press Special Key    RIGHT
                Press Special Key    ENTER 
                Sleep    ${SLEEP_BAIXO}
                
                IF    '${Perguntas_CheckList[${I}][1]}' == 'A'
                    
                    # Validação para ficar alternando entre sim e não.
                    IF    ${I} % ${2} == 0

                        Press Special Key    DOWN
                        Press Special Key    ENTER 

                    ELSE

                        Press Special Key    DOWN
                        Press Special Key    DOWN
                        Press Special Key    ENTER 

                    END                   

                ELSE
                    
                    Type    ${EMPTY}    Descricao de automacao em check list
                    Sleep    ${SLEEP_BAIXO}

                END

            END

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

        Press Combination    KEY.ALT    KEY.G
        Sleep    ${SLEEP_BAIXO}

    END

Quando pressiono o atalho de faturar

    ${aberturaDiretaTelaNFS-e}    Valida a modalidade de cobrança da OS para o faturamento

    IF    ${Parametro_FaturamentoAoFinalizarOS}

        IF    ${aberturaDiretaTelaNFS-e}

            Wait Until Screen Contain    ${TELA_NFS-E}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

        ELSE

           Valida opções de faturamento 

        END

    ELSE

        Press Combination    KEY.ALT    KEY.U

        IF    ${aberturaDiretaTelaNFS-e}

            Wait Until Screen Contain    ${TELA_NFS-E}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

        ELSE

           Valida opções de faturamento 

        END
        
    END

Valida opções de faturamento

    Wait Until Screen Contain    ${TELA_OPCOES_FATURAMENTO}    ${TEMPO_TELA}
    
    Sleep    ${SLEEP_BAIXO}
    ${vendasprodutos}    Run Keyword And Return Status    Check If Exists In Database    SELECT vp.CodigoVenda FROM vendasprodutos AS vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};

    SikuliLibrary.Click    ${TELA_OPCOES_FATURAMENTO}

    Press Special Key    TAB

    IF    not ${vendasprodutos}

        Press Special Key    TAB
        
        ${emitirBoletos}    Exists    ${LABEL_EMITIR_BOLETOS}

        IF    ${emitirBoletos}

            SikuliLibrary.Click    ${LABEL_EMITIR_BOLETOS}
            
        END

    ELSE IF    ${vendasprodutos}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE

    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.T
    Wait Until Screen Contain    ${TELA_NFS-E}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Valida a modalidade de cobrança da OS para o faturamento

    Sleep    ${SLEEP_BAIXO}
    ${vendasprodutos}    Run Keyword And Return Status    Check If Exists In Database    SELECT vp.CodigoVenda FROM vendasprodutos AS vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};
    
    ${telaNFS-E}    Set Variable    ${False}

    # Essa validação é necessária porque, ao faturar uma OS sem produto e com modalidade de cobrança diferente de boleto, o sistema não exibe a tela 'Opções de Faturamento', mas sim vai diretamente para a tela 'NFS-e'.
    IF    '${modalidadeCB_OS}' != 'BOLETO' and '${vendasprodutos}' == 'False'

        ${telaNFS-E}    Set Variable    ${True}
        
    END

    RETURN    ${telaNFS-E}

Então realizo o faturamento da NFSe
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.G
    Wait Until Screen Contain    ${LABEL_AGUARDE_GERANDO_NFSE}    ${TEMPO_TELA}

    Valida faturamento de NFSe
    
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Valida faturamento de NFSe
    
    ${retornoFatNFS}    Run Keyword And Return Status    Wait Until Screen Contain    ${RETORNO_NFS}    60

    IF    ${retornoFatNFS}

       Press Special Key    ENTER

    END
    
    Sleep    ${SLEEP_BAIXO}
    ${consultaNotaFiscalServico}    Query    SELECT Situacao, motivoRejeicao FROM notafiscalservico WHERE CodigoOS = ${COD_ORDEM_SERVICO};

    ${situacao}          Set Variable    ${consultaNotaFiscalServico[0][0]}
    ${motivoRejeicao}    Set Variable    ${consultaNotaFiscalServico[0][1]}

    Run Keyword If    '${situacao}' == 'None' and '${motivoRejeicao}' == 'None'    Fail    Nota fiscal de serviço não gerada.

    IF    '${situacao}' == 'Rejeitada'

        IF    '${motivoRejeicao}' == 'None'
            
            ${msg_nfse_com_problema}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_NFSE_COM_PROBLEMA}    ${TEMPO_TELA}

            IF    ${msg_nfse_com_problema}
                
                Sleep    ${SLEEP_BAIXO}
                Press Special Key    ENTER

                Fail    Nota fiscal de serviço com problema.

            END
        
        ELSE

            Log To Console    Nota fiscal de serviço rejeitada.

        END
    
    ELSE IF    '${situacao}' == 'Impressa'

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        
        Log To Console    Nota fiscal de serviço faturada com sucesso.
    
    ELSE IF    '${situacao}' == 'Consultar'

        ${msg_nfse_processamento}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_NFSE_PROCESSAMENTO}    ${TEMPO_TELA}

        IF    ${msg_nfse_processamento}

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ENTER
            
            Log To Console    Nota fiscal de serviço em processamento.

        END       
         
    END

Extrair dados da ordem de serviço gerada

    ${consulta}    Query    SELECT v.ModalidadeCB FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    ${modalidadeCB}    Set Variable    ${consulta[0][0]}

    Set Test Variable    ${modalidadeCB_OS}    ${modalidadeCB}

Informa a quantidade do produto(${Quantidade_Produto})

    IF    ${Quantidade_Produto} != ${Parametro_QuantidadePadraoProduto}
        
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

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

Seleciona técnico executor do serviço

    IF    ${Teste_Comissao_Escalonada}
        
        Seleciona técnico executor comissionado diferente do vendedor da OS('D')

    ELSE IF    ${Teste_Comissao_Total_Venda}

        Seleciona técnico executor comissionado diferente do vendedor da OS('T')

    ELSE IF    ${Teste_Comissao_Linha}

        Seleciona técnico executor comissionado diferente do vendedor da OS('L')

    ELSE IF    ${Teste_Comissao_Forma_Parcelamento}

        Seleciona técnico executor comissionado diferente do vendedor da OS('F')

    END

E pesquiso pela ordem de serviço gerada
    
    Sleep    ${SLEEP_BAIXO}
    ${criterioCodigo}    Exists    ${LABEL_CRITERIO_CODIGO_OS}

    IF    not ${criterioCodigo}
        
        SikuliLibrary.Click    ${LABEL_CODIGO_GRID}

    END

    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${COD_ORDEM_SERVICO}

    Press Special Key    ENTER

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${GRID_REGISTRO_ENCONTRADO}    ${SLEEP_ALTO}

Informa a quantidade do serviço(${Quantidade_Servico})

    IF    ${Quantidade_Servico} != 1

        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_SERVICO}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}   ${Quantidade_Servico}
        
    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Servico}

Quando insiro mais de um serviço(${QuantidadeDeServico})

    ${Codigos_Servicos}    Create List

    FOR    ${i}    IN RANGE    ${QuantidadeDeServico}
        
        E insiro um serviço informando a quantidade(${Quantidade_Servico})

        Append To List    ${Codigos_Servicos}    ${COD_SERVICO}
        
    END

    Set Test Variable    ${Codigos_Servicos}
    Set Test Variable    ${QUANTIDADE_SERVICOS}    ${QuantidadeDeServico}

Quando insiro mais de um produto normal(${QuantidadeDeProduto})

    ${Quantidade_Produto}    Considera quantidade padrão de produtos quando utilizado múltiplos produtos    ${Parametro_QtdePadraoOS}

    ${Codigos_Produtos}    Create List

    FOR    ${I}    IN RANGE    ${QuantidadeDeProduto}

        E insiro um produto normal informando a quantidade(${Quantidade_Produto})

        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Produtos}
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QuantidadeDeProduto}

Quando acesso a guia de serviços na ordem de serviço

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${GUIA_SERVICOS_OS}    ${TEMPO_TELA}

E edito (${campo}) do serviço lançado

    ${tabs}    Set Variable    0
    
    Press Combination    KEY.ALT    KEY.D

    utils.Valida solicitação de senha do usuário supervisor

    ${servico}    Query    SELECT vs.CodigoServico, vs.Quantidade, vs.Desconto, vs.ValorUnitario, vs.ValorTotal, vs.DescExpandida FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO}

    IF    $servico[0][5] is not None

        Insere detalhamento no serviço
        
    END

    IF    $campo == 'quantidade'

        ${tabs}     Set Variable    0
        ${valor}    Set Variable    ${servico[0][1]}

    ELSE IF    $campo == 'desconto'

        ${tabs}     Set Variable    1
        ${valor}    Set Variable    ${servico[0][2]}

    ELSE IF    $campo == 'valor unitario'

        ${tabs}     Set Variable    2
        ${valor}    Set Variable    ${servico[0][3]}

    ELSE IF    $campo == 'valor total'

        ${tabs}     Set Variable    3
        ${valor}    Set Variable    ${servico[0][4]}

    END

    FOR    ${i}    IN RANGE    ${tabs}
        Press Special Key    TAB
    END
    
    ${valorGerado}    Evaluate    random.randint(int(${valor}) + 1, int(${valor}) * 2)    modules=random

    Input Text    ${EMPTY}    ${valorGerado}

    Press Special Key    TAB

    Press Combination    KEY.ALT    KEY.N

    utils.Insere funcionários comissionados por serviço

E pressiono o atalho de status

    Press Combination    KEY.ALT    KEY.T
    Wait Until Screen Contain    ${TELA_ALTERACAO_STATUS_OS}    ${TEMPO_TELA}

    Garante status 'automacao' para ordem de serviço

Então altero o status da ordem de serviço

    SikuliLibrary.Click    ${ICONE_PASTA_STATUS_OS}

    Wait Until Screen Contain    ${TELA_STATUS_OS}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${INPUT_DESCRICAO_STATUS_OS}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    AUTOMACAO
    Sleep    ${SLEEP_BAIXO}
    
    Press Combination    KEY.ALT    KEY.S
    
    utils.Valida solicitação de senha do usuário supervisor para liberação de status da OS

    Wait Until Screen Contain    ${TELA_ALTERACAO_STATUS_OS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.G
    
    # Valida alteração de status da OS
    Check If Exists In Database    SELECT 1 FROM vendas v INNER JOIN statusos s ON s.Codigo = v.IDStatusOS WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.Cancelada IS NULL;

    Wait Until Screen Contain    ${AVISO_STATUS_ATUALIZADO}    ${TEMPO_TELA}

    Press Special Key    ENTER

E pressiono o atalho de insumos

    Press Combination    KEY.ALT    KEY.M
    Wait Until Screen Contain    ${TELA_INCLUSAO_INSUMOS}    ${TEMPO_TELA}

E insiro insumos para cada serviço da OS

    ${consultaQtdeServicos}    Query    SELECT COUNT(*) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL;
    ${qtdeServicos}    Set Variable    ${consultaQtdeServicos[0][0]}

    SikuliLibrary.Double Click    ${COMBO_SERVICO_DO_INSUMO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    HOME
    Sleep    ${SLEEP_BAIXO}

    FOR    ${i}    IN RANGE    ${qtdeServicos}

        ${codigoInsumo}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque >= ${Qtde_Minima_Estoque} WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;

        IF    ${i} > 0

            SikuliLibrary.Double Click    ${COMBO_SERVICO_DO_INSUMO}
            Sleep    ${SLEEP_BAIXO}

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

        Inclui insumo para o serviço selecionado    ${codigoInsumo[0][0]}
        
    END

    Press Combination    KEY.ALT    KEY.S

Inclui insumo para o serviço selecionado
    [Arguments]    ${codigoInsumo}
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codigoInsumo}
    Press Special Key    TAB

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.I

    Wait Until Screen Contain    ${ROW_INSUMO_INCLUSO_GRID}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E acesso a aba adiantamentos

    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${ABA_ADIANTAMENTOS_OS}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    Adiantamento - Automacao

    Press Special Key    TAB

    ${valor_adiantamento}    Valor de adiantamento menor que o valor final da OS

    Input Text    ${EMPTY}    ${valor_adiantamento}

    Press Special Key    TAB

    Press Combination    KEY.ALT    KEY.N

    Wait Until Screen Contain    ${ROW_ADIANTAMENTO_INCLUSO_GRID}    ${TEMPO_TELA}

    Set Test Variable    ${valor_adiantamento}

Valor de adiantamento menor que o valor final da OS

    ${valor_total_os}    Query    SELECT ROUND((SELECT COALESCE(SUM(ValorTotal), 0) FROM vendasprodutos AS vp WHERE vp.CodigoVenda = 12813) + (SELECT COALESCE(SUM(ValorTotal), 0) FROM vendasservicos AS vs WHERE vs.CodigoVenda = 12813), 2) AS TotalOS

    ${valor_total}    Evaluate    int(${valor_total_os[0][0]})
    ${valor_adiantamento}    Evaluate    random.randint(1, ${valor_total} - 1)    modules=random
    ${valor_adiantamento}    Evaluate    f"{${valor_adiantamento}}.00"

    RETURN    ${valor_adiantamento}

E ajusto o valor a receber para o restante da OS

    ${valor_restante}    Evaluate    round(float(${VALOR_FINAL_OPERAÇÃO}) - float(${valor_adiantamento}), 2)
    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${valor_restante}

Então gravo a ordem de serviço

    Press Combination    KEY.ALT    KEY.G
    
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    Verifica ordem de serviço após ser gravada

Verifica ordem de serviço após ser gravada

    Calcula valor final da OS

    ${consulta}    Query    SELECT v.TotalPedido, v.ValorFinalPagamentos FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.`Status` = 'o' AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    Should Not Be Empty    ${consulta}    msg=OS não encontrada no banco de dados.

    ${total_pedido}              Convert To Number    ${consulta[0][0]}
    ${valor_final_pagamentos}    Convert To Number    ${consulta[0][1]}

    Should Be Equal As Numbers    ${total_pedido}    0    msg=Valor total da OS está divergente do esperado que é 0.
    Should Be Equal As Numbers    ${valor_final_pagamentos}    0    msg=Valor final dos pagamentos da OS está divergente do esperado que é 0.

Então fecho a ordem de serviço

    SikuliLibrary.Click    ${BT_FECHAR_OS}
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    Verifica ordem de serviço após ser fechada

Verifica ordem de serviço após ser fechada

    Calcula valor final da OS

    ${consulta}    Query    SELECT v.TotalPedido, v.ValorFinalPagamentos FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.`Status` = 'c' AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

    Should Not Be Empty    ${consulta}    msg=OS não encontrada no banco de dados.

    ${total_pedido}              Convert To Number    ${consulta[0][0]}
    ${valor_final_pagamentos}    Convert To Number    ${consulta[0][1]}

    Should Be Equal As Numbers    ${total_pedido}    0    msg=Valor total da OS está divergente do esperado que é 0.
    Should Be Equal As Numbers    ${valor_final_pagamentos}    0    msg=Valor final dos pagamentos da OS está divergente do esperado que é 0.

E clico em reabrir OS

    SikuliLibrary.Click    ${BT_REABRIR_OS}
    Sleep    ${SLEEP_BAIXO}

Garante status 'automacao' para ordem de serviço

    ${status_automamacao}    Query    SELECT EXISTS (SELECT s.Codigo FROM statusos s WHERE s.Descricao = 'AUTOMACAO');

    IF    ${status_automamacao[0][0]} == 0

        Execute Sql String    INSERT INTO statusos (Descricao, Cor, PadraoAbrirOS, PadraoFinalizarOS, ExigirSenhaSupervisor, PadraoFecharOS, sto_OrdemExibicao) VALUES ('AUTOMACAO', '8421440', 0, 0, 1, 0, NULL);

    END