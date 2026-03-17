*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    Collections
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/estoque.py
Library    ../../../libs/validaComissoes.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot
Resource    ../../../utils/montadorDeCenarios.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                                        ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                                         ${config.IpServidor}
${DBName}                                         ${config.Database}
${DBPass}                                         vssql
${DBPort}                                         ${config.Porta}
${DBUser}                                         root

# Sleep's
${SLEEP_BAIXO}                                    0.7
${SLEEP_MEDIO}                                    1.5
${SLEEP_ALTO}                                     3
${TEMPO_TELA}                                     20

# Telas
${TELA_COMISSOES}                                 tela_Comissoes.png
${TELA_AGENDAMENTO}                               tela_Agendamento_Comissao.png
${TELA_CONTAS_A_PAGAR}                            tela_ContasPagar.png
${TELA_RECEBIMENTO_PAGAMENTO}                     caixa_FinalizacaoRecebimentoPagamento.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}              tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                          tela_CaixaPrinicipalCarregando.png
${TELA_VALE_COMPRA}                               tela_ValeCompra.png
${TELA_BAIXA_VALE_COMPRA}                         tela_BaixaValeCompra.png
${TELA_DETALHES_COMISSAO}                         tela_DetalhesComissao.png
${CAIXA_PRINCIPAL}                                tela_CaixaPrinicipal.png
${TELA_IMPRESSAO}                                 tela_Impressao.png
${TELA_RELATORIO_COMISSOES}                       tela_RelatorioComissoes.png
${TELA_IMPRESSAO}                                 tela_Impressao.png
${TELA_VISUALIZACAO_IMPRESSAO}                    tela_VisualizacaoImpressao.png
${TELA_PESQUISA_TEXTO_IMPRESSAO}                  tela_PesquisaTextoImpressao.png

# Telas Avisos
${AVISO_BAIXA_SUCESSO}                            aviso_BaixaSucesso.png
${AVISO_CONFIRMAÇÃO_BAIXA_CONTA_A_PAGAR}          aviso_confirmacaoBaixaContaPagar.png
${AVISO_BAIXA_VALE_COMPRA}                        aviso_BaixaValeCompra.png
${AVISO_COMISSAO_ZERADA}                          aviso_ComissaoZerada.png
${AVISO_SEM_DADOS_PARA_EXIBICAO}                  aviso_SemDadosParaExibicao.png
${AVISO_PERIODO_COM_LOTE_PAGAMENTO}               aviso_PeriodoComLotePagamento.png
${AVISO_PESQUISA_TEXTO_CONCLUIDA}                 aviso_PesquisaTextoConcluida.png

# Botões
${BT_BAIXAR}                                      bt_Baixar.png
${BT_OK}                                          bt_OkComisssao.png
${BT_FECHAR}                                      bt_fechar.png
${BT_BINOCULO_PESQUISA_RELATORIO}                 bt_BinoculoPesquisaTextoRelatorio.png
${BT_OK_AVISO_LOTE_DE_PAGAMENTO}                  bt_OKAvisoLoteDePagamento.png

# Checkbox
${CHECK_BOX_SELE_TODOS}                           checkBox_Comissao.png
${CHECKBOX_CONTASPAGAR}                           checkBox_ContasPagar.png
${CHECK_BOX_SELE_TODOS_SERVICO}                   checkBox_ComissaoServico.png
${CHECKBOX_PRODUTOS_HABILITADO}                   check_Produtos_Habilitado.png
${CHECKBOX_PRODUTOS_DESABILITADO}                 check_Produtos.png
${CHECKBOX_SERVICOS_HABILITADO}                   check_Servicos_Habilitado.png
${CHECKBOX_SERVICOS_DESABILITADO}                 check_Servicos.png
${CHECKBOX_COMISSAO_FOCO_GRID}                    checkBox_ComissaoFocoGrid.png
${CHECKBOX_CONTA_FOCO_GRID}                       checkBoxContaFocoGrid.png
${CHECKBOX_CONTA_FOCO_GRID_2}                     checkBox_ComissaoFocoGrid2.png

# ComboBox
${COMBOBOX_GERAR_SOBRE_VENDAS}                    combo_gerar_sobre_vendas.png

# Inputs
${INPUT_NUMERO_DOCUMENTO}                         caixa_PesquisaPorNDoc.png

# Labels
${LABEL_DATA_PAGAMENTO_NULA}                      lb_DataPagamentoComBranco.png
${LABEL_CARREGANDO_COMISSOES_GRID}                lb_CarregandoComissoesGrid.png
${LABEL_STATUS_ABERTO}                            lb_StatusAbertoCaixa.png
${LABEL_GERANDO_RELATORIO_AGUARDE}                lb_GerandoRelatorioAguarde.png
${LABEL_COD_VENDEDOR_RELATORIO}                   lb_CodVendRelatComissoes.png

# Radio Buttons
${RADIOBT_COMISSOES_AGENDADAS}                    radioBT_Agendadas.png
${RADIOBT_VISUALIZAR_IMPRESSAO}                   radioBT_Visualizar_Impressao.png
${RADIOBT_COMISSOES_PENDENTES}                    radioBT_Pendentes.png

# Menus
${MENU_FINANCEIRO}                                menu_Financeiro.png
${MENU_COMERCIAL}                                 menu_Comercial.png
${MENU_RELATORIOS}                                menu_Relatorios.png
${SUBMENU_RELATORIOS_COMISSOES}                   subMenu_Relatorios_Comissoes.png
${SUB_MENU_COMISSOES}                             subMenu_Comissoes.png

# Outros
${LISTAGEM_GRID}                                  grid_Comissoes.png
${Quantidade_Zeros_Incluidos}
${ABA_A_PAGAR}                                    aba_contasAPagar.png
${GRID_COMISSOES_PAGAR}                           grid_ComissoesPagar.png
${Total_Comissao}                                 ${0}
${Total_Comissao_Final}                           ${0}
${COL_LOTE}                                       grid_ComissoesLote.png
${ABA_SERVICOS}                                   aba_servicosSelecionada.png
${SETA_ESQUERDA_GRID}                             setaEsqGrid.png
${GRID_SEM_REGISTROS}    	                      grid_ComissoesSemRegistros.png
${NomeTerminalExecucao}                           ${config.terminal_name}
${GUIA_COMISSOES_PAGAS_AGENDADAS}                 guia_ComissoesPagasAgendadas.png
${TOOLTIP_ATALHOS_DATA}                           tooltip_AtalhosData.png
${j}                                              ${0}
${Total_Comissao_Venda}                           ${0}
${Total_Comissao_Produtos}                        ${0}
${Total_Comissao_Servicos}                        ${0}
${Teste_Cenario_Sem_Dados_Exibicao}               ${False}
${Teste_Cenario_Sem_Dados_Exibicao_Outras_Mov}    ${False}
${Comissao_SomenteRecebidas}                      ${False}
${Teste_Comissao_Produto}                         ${False}
${Teste_Comissao_Servico}                         ${False}
${Teste_Comissão_Parcelada}                       ${False}
${Baixa_Eh_Servico}                               ${False}
${Comissao_Zerada_Por_Devolucao}                  ${False}
${Cenario_Sem_Comissao_Servico}                   ${False}
${Cenario_Sem_Comissao_Produto}                   ${False}
${Codigo_Vendedor_Comissao_Tela}                  ${EMPTY}
${comissao_anterior}                              ${0}
${COMISSOES_AGENDADAS}                            ${False}
${COMISSOES_PAGAS}                                ${False}
${COMISSOES_PENDENTES}                            ${False}
${ESPERAVA_MENSAGEM_SEM_DADOS}
${Relatorio_Deve_Conter_Dados}                    ${True}
${Dado_Localizado_Na_Pesquisa_Relatorio}          dadoFoiLocalizadoPesquisaRelatorio.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de comissões

    SikuliLibrary.Click    ${MENU_FINANCEIRO}
    Wait Until Screen Contain    ${SUB_MENU_COMISSOES}    ${TEMPO_TELA}

    FOR    ${I}    IN RANGE    4

        Press Special Key    DOWN

    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_COMISSOES}    ${TEMPO_TELA}

Quando insiro o vendedor comissionado

    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

E seleciono somente as recebidas

    FOR    ${I}    IN RANGE    2

        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}

    END

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Informa a data atual na data de recebimento

    Set Test Variable    ${Comissao_SomenteRecebidas}    ${True}

Informa a data atual na data de recebimento

    Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}
    
    ${dataInicial}    Copia data do campo e converte para o formato ISO 8601
    Sleep    ${SLEEP_BAIXO}

    Type With Modifiers    H
    Press Special Key    TAB

    Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}

    Type With Modifiers    H
    ${dataFinal}    Copia data do campo e converte para o formato ISO 8601
    Press Special Key    TAB

    Deleta os lotes de pagamento das comissões de vendas/OS recebidas, baixadas no período de recebimento filtrado(${dataInicial}, ${dataFinal})

Copia data do campo e converte para o formato ISO 8601
    
    Sleep    ${SLEEP_BAIXO}

    Key Down            CTRL
    Press Combination   C
    Key Up              CTRL

    ${data_copiada}    Get Clipboard Content
    ${dataInicial}    Evaluate    __import__('datetime').datetime.strptime('${data_copiada}'.strip(), '%d/%m/%Y').strftime('%Y-%m-%d')

    RETURN    ${dataInicial}

Deleta os lotes de pagamento das comissões de vendas/OS recebidas, baixadas no período de recebimento filtrado(${dataInicial}, ${dataFinal})
    
    Sleep    ${SLEEP_BAIXO}
    Execute Sql String    DELETE cpv FROM comissoespagasvendas cpv INNER JOIN comissoespagas cp ON cp.ID = cpv.NComissao WHERE cp.PInicial >= '${dataInicial}' AND cp.PFinal <= '${dataFinal}' AND cp.CodigoVendedor = ${Codigo_Vendedor} AND cp.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);
    
    Sleep    ${SLEEP_MEDIO}
    Execute Sql String    DELETE FROM comissoespagas WHERE PInicial >= '${dataInicial}' AND PFinal <= '${dataFinal}' AND CodigoVendedor = ${Codigo_Vendedor} AND Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);
    
    Sleep    ${SLEEP_BAIXO}

E seleciono a comissão de produtos

    Set Test Variable    ${Teste_Comissao_Produto}    ${True}

    # Se o cenário é "sem comissão de produto" (ex: alíquota = 0), a operação NÃO aparece no grid.
    # Nesse caso, pula a pesquisa no grid e valida apenas via banco.
    IF    ${Cenario_Sem_Comissao_Produto}
    
        Log To Console    [Cenario_Sem_Comissao_Produto] Operação não gera comissão → pulando pesquisa no grid.

        Valida Comissão Linha Produto    ${Tipo_Comissao_Linha}    ${Cenario_Comissao_Linha}

        RETURN

    END

    Sleep    ${SLEEP_BAIXO}
    ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

    IF    ${gridSemRegistro}

        Press Combination    KEY.ALT    KEY.I
        Sleep    ${SLEEP_ALTO}
        Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    END

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    Sleep    ${SLEEP_BAIXO}
    ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

    IF    ${gridPassouTamPadrao}

        SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

    END

    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    Sleep    ${SLEEP_ALTO}

    IF    ${Teste_Comissao_Linha}

        # Para cenários de produto com validação de linha DIF/MISTA, usa a keyword de validação detalhada
        ${eh_cenario_produto_linha}    Evaluate    '${Cenario_Comissao_Linha}'.startswith('PROD__')

        IF    ${eh_cenario_produto_linha}

            IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor' or '${Tipo_Comissao_Linha}' == 'Mista'

                Valida Comissão Linha Produto    ${Tipo_Comissao_Linha}    ${Cenario_Comissao_Linha}

            ELSE

                Fail    Cenário de produto '${Cenario_Comissao_Linha}' com tipo '${Tipo_Comissao_Linha}' não reconhecido.

            END

        ELSE IF    $Codigos_Produtos is None

            Calcula comissão por linha de produto - apenas 1 produto

        ELSE

            Set Test Variable    ${POSIÇÃO_VALOR}    ${0}

            IF    $Valores_Parcelas is not None
                
                Set Test Variable    ${Teste_Comissão_Parcelada}    ${True}

                Calcula comissão por linha de produto - por parcela personalizada

            ELSE

                Calcula comissão por linha de produto - múltiplos produtos

            END

        END

    ELSE IF    ${Teste_Comissao_Total_Venda}

        Calcula comissão sobre total venda - Produtos

        IF    ${Teste_Comissao_Devolucao}
            
            ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_OPERAÇÃO} * (-1))

            Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_DEVOLUCAO}

        END
    
    ELSE IF    ${Teste_Comissao_Escalonada}

        Fail    Validar posteriormente comissão escalonada.

    ELSE IF    ${Teste_Comissao_Forma_Parcelamento}

        Calcula comissão sobre forma de parcelamento - Produtos

    END

Calcula comissão por linha de produto - apenas 1 produto

    ${valor_comissao_unitario}    Consulta valor comissão produto único    ${COD_PRODUTO}    ${CODIGO_OPERACAO_MOV}

    ${Total_Comissao_Produtos}    Calcula Comissao Linha Produto Unico
    ...    ${valor_comissao_unitario}
    ...    ${Quantidade_Produto}
    ...    ${Total_Comissao_Produtos}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao_Produtos}

Calcula comissão por linha de produto - por parcela personalizada

    ${valores_comissao}    Consulta valores comissão por produto    ${Codigos_Produtos}

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Parcela Personalizada
    ...    ${valores_comissao}
    ...    ${Quantidade_Produto}
    ...    ${DADOS_VENDA_DEVOLUÇÃO}
    ...    ${Valores_Parcelas}
    ...    ${j}
    ...    ${Total_Comissao}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}
    Set Suite Variable    ${PERCENT_COMISSAO}

    Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao}

    ${j}    Evaluate    ${j} + 1
    Set Test Variable    ${j}

Calcula comissão por linha de produto - múltiplos produtos

    ${valores_comissao}    Consulta valores comissão por produto    ${Codigos_Produtos}

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Multiplos
    ...    ${valores_comissao}
    ...    ${Quantidade_Produto}
    ...    ${DADOS_VENDA_DEVOLUÇÃO}
    ...    ${POSIÇÃO_VALOR}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}
    Set Suite Variable    ${PERCENT_COMISSAO}

Calcula comissão sobre total venda - Produtos

    ${queryComissaoProdutos}    Query    SELECT ROUND(SUM(vp.ValorComissao), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${CODIGO_OPERACAO_MOV} AND vp.Cancelada IS NULL
    
    ${queryComissaoProdutos[0][0]}    Evaluate    decimal.Decimal(str(${queryComissaoProdutos[0][0]}))    modules=decimal

    ${calcComissaoProdutos}    Evaluate    (decimal.Decimal(str(${Valor_Total_Produtos})) * (decimal.Decimal(str(${PercentualComissaoTotalVenda_Produto})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
    
    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${calcComissaoProdutos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcComissaoProdutos}    ${queryComissaoProdutos[0][0]}

    Should Be Equal As Numbers    ${queryComissaoProdutos[0][0]}    ${calcComissaoProdutos}

    Set Test Variable    ${Total_Comissao_Produtos}    ${calcComissaoProdutos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    Valor final da comissão (Produto): ${Total_Comissao_Produtos}

Calcula comissão sobre forma de parcelamento - Produtos

    ${query_comissaoProduto}    Query    SELECT ROUND(SUM(vp.ValorComissao), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA} AND vp.Cancelada IS NULL

    ${calcComissaoProduto}    Evaluate    (decimal.Decimal(str(${Valor_Total_Produtos})) * (decimal.Decimal(str(${PercentualComissaoFormaParcParcela_Produto})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"))    modules=decimal

    ${query_comissaoProduto[0][0]}    Evaluate    decimal.Decimal(str(${query_comissaoProduto[0][0]}))    modules=decimal

    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${calcComissaoProduto}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcComissaoProduto}    ${query_comissaoProduto[0][0]}

    Should Be Equal As Numbers    ${query_comissaoProduto[0][0]}    ${calcComissaoProduto}

    Set Test Variable    ${Total_Comissao_Produtos}    ${calcComissaoProduto}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    [VENDA] Valor final da comissão (Forma Parcelamento): ${Total_Comissao_Produtos}

E seleciono a comissão de produtos - Devolução

    Set Test Variable    ${Teste_Comissao_Produto}    ${True}

    Sleep    ${SLEEP_BAIXO}
    ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

    IF    ${gridSemRegistro}

        Press Combination    KEY.ALT    KEY.I
        Sleep    ${SLEEP_ALTO}
        Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

    END

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    Set Test Variable    ${Quantidade_Produto_Venda/Dev}    ${Quantidade_Produto_Devolucao}

    FOR    ${I}    IN RANGE    2

        Sleep    ${SLEEP_BAIXO}
        ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

        IF    ${gridPassouTamPadrao}

            SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

        END

        SikuliLibrary.Click    ${LISTAGEM_GRID}
        Sleep    ${SLEEP_BAIXO}

        Pesquisa código da operação com zeros a esquerda

        IF    ${Teste_Comissao_Linha}

            IF    $Codigos_Produtos is None

                Calcula comissão por linha de produto - apenas 1 produto - Devolução

            ELSE

                Set Test Variable    ${POSIÇÃO_VALOR}    ${I}

                Calcula comissão por linha de produto - múltiplos produtos

            END

        ELSE IF    ${Teste_Comissao_Total_Venda}

            Calcula comissão sobre total venda - Produtos

            ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_VENDA} * (-1))
            Set Test Variable    ${VALOR_FINAL_VENDA}    ${VALOR_DEVOLUCAO}

        END

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}
        Set Test Variable    ${Quantidade_Produto_Venda/Dev}    ${Quantidade_Produto}

    END

E vou para a aba de servicos

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ABA_SERVICOS}    ${SLEEP_ALTO}

E seleciono a comissão de serviços

    Set Test Variable    ${Baixa_Eh_Servico}    ${True}

    # Se o cenário é "sem comissão de serviço", a OS NÃO aparece no grid. Nesse caso, pula a pesquisa no grid e valida apenas a ausência de registro via banco.
    IF    ${Cenario_Sem_Comissao_Servico}
    
        Log To Console    [Cenario_Sem_Comissao_Servico] OS não gera comissão → pulando pesquisa no grid.

        Valida Comissão Linha Serviço    ${Tipo_Comissao_Linha}    ${Cenario_Comissao_Linha}

        RETURN

    END

    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}

    Sleep    ${SLEEP_BAIXO}
    ${gridPassouTamPadrao}    Exists    ${SETA_ESQUERDA_GRID}

    IF    ${gridPassouTamPadrao}

        SikuliLibrary.Click    ${SETA_ESQUERDA_GRID}

    END

    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    Pesquisa código da operação com zeros a esquerda

    Sleep    ${SLEEP_ALTO}

    IF    ${Teste_Comissao_Linha}

        Calcula comissão por linha de serviço - apenas 1 serviço
        
    ELSE IF    ${Teste_Comissao_Total_Venda}

        IF    ${OS_PossuiProduto}
            
            Calcula comissão sobre total venda - Produtos

        END

        Calcula comissão sobre total venda - Serviços

    END

Calcula comissão por linha de serviço - apenas 1 serviço

    IF    '${Tipo_Comissao_Linha}' == 'Simples'

        ${valor_comissao_servico}    Consulta valor comissão serviço único    ${COD_SERVICO}    ${CODIGO_OPERACAO_MOV}    ${Total_Tributos_Servico}

        ${Total_Comissao_OS}    Calcula Comissao Linha Servico Unico    ${valor_comissao_servico}

        Set Test Variable    ${Total_Comissao_OS}
        Set Test Variable    ${Total_Comissao}    ${Total_Comissao_OS}
        Set Test Variable    ${Total_Comissao_Servicos}    ${Total_Comissao_OS}

        Log To Console    [OS] Valor final da comissão (Linha Simples): ${Total_Comissao_Servicos}

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor' or '${Tipo_Comissao_Linha}' == 'Mista'

        # Se o cenário é de PRODUTO (PROD__*), o serviço usa cálculo genérico por tipo de linha (sem cenário específico de serviço).
        ${eh_cenario_produto}    Evaluate    '${Cenario_Comissao_Linha}'.startswith('PROD__')

        IF    ${eh_cenario_produto}

            ${valor_comissao_servico}    Consulta valor comissão serviço único    ${COD_SERVICO}    ${CODIGO_OPERACAO_MOV}    ${Total_Tributos_Servico}

            ${Total_Comissao_OS}    Calcula Comissao Linha Servico Unico    ${valor_comissao_servico}

            Set Test Variable    ${Total_Comissao_OS}
            Set Test Variable    ${Total_Comissao_Servicos}    ${Total_Comissao_OS}

            Log To Console    [OS] Valor final da comissão de serviço (cenário PROD__* — cálculo genérico ${Tipo_Comissao_Linha}): ${Total_Comissao_Servicos}

        ELSE

            Valida Comissão Linha Serviço    ${Tipo_Comissao_Linha}    ${Cenario_Comissao_Linha}

        END

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

        Fail    Comissão por linha de serviço para Tabela de Preço ainda não implementada.

    END

Verifica Comissão Serviço Gerada
    [Arguments]    ${codigo_os}    ${codigo_funcionario}    ${deve_gerar}=${True}

    ${query_count}    Query    SELECT COUNT(*) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.Cancelada IS NULL;

    ${existe}    Verifica Comissao Servico Existe    ${query_count}

    IF    ${deve_gerar} and not ${existe}

        Fail    Comissão de serviço deveria ter sido gerada para OS ${codigo_os} / Funcionário ${codigo_funcionario}, mas NÃO foi encontrado registro em comissoesservico.

    ELSE IF    not ${deve_gerar} and ${existe}

        Fail    Comissão de serviço NÃO deveria ter sido gerada para OS ${codigo_os} / Funcionário ${codigo_funcionario}, mas FOI encontrado registro em comissoesservico.

    END

    IF    ${deve_gerar}

        Log To Console    [Verifica Comissão Serviço Gerada] ✓ Registro encontrado para OS ${codigo_os} / Funcionário ${codigo_funcionario}.

    ELSE

        Log To Console    [Verifica Comissão Serviço Gerada] ✓ Nenhum registro (esperado) para OS ${codigo_os} / Funcionário ${codigo_funcionario}.

    END

Busca Valor Comissão Serviço Gerada
    [Arguments]    ${codigo_os}    ${codigo_funcionario}

    ${query_valor}    Query    SELECT ROUND(COALESCE(SUM(cs.ValorComissao), 0), 2) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.Cancelada IS NULL;

    ${valor}    Busca Comissao Servico Gerada    ${query_valor}

    RETURN    ${valor}

Verifica Comissão Serviço Gerada Por Papel
    [Arguments]    ${codigo_os}    ${codigo_funcionario}    ${papel}    ${deve_gerar}=${True}

    IF    '${papel}' == 'vendedor'

        ${query_count}    Query    SELECT COUNT(*) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.ComissaoVendedor = 1 AND cs.Cancelada IS NULL;

    ELSE IF    '${papel}' == 'executor'

        ${query_count}    Query    SELECT COUNT(*) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.ComissaoVendedor IS NULL AND cs.Cancelada IS NULL;

    ELSE

        Fail    Papel inválido: '${papel}'. Use 'vendedor' ou 'executor'.

    END

    ${existe}    Verifica Comissao Servico Existe    ${query_count}

    IF    ${deve_gerar} and not ${existe}

        Fail    Comissão de serviço (${papel}) deveria ter sido gerada para OS ${codigo_os} / Funcionário ${codigo_funcionario}, mas NÃO foi encontrado registro na tabela 'comissoesservico'.

    ELSE IF    not ${deve_gerar} and ${existe}

        Fail    Comissão de serviço (${papel}) NÃO deveria ter sido gerada para OS ${codigo_os} / Funcionário ${codigo_funcionario}, mas FOI encontrado registro na tabela 'comissoesservico'.

    END

    IF    ${deve_gerar}

        Log To Console    [Verifica Comissão Serviço Gerada Por Papel] ✓ Registro (${papel}) encontrado para OS ${codigo_os} / Funcionário ${codigo_funcionario}.

    ELSE

        Log To Console    [Verifica Comissão Serviço Gerada Por Papel] ✓ Nenhum registro (${papel}) (esperado) para OS ${codigo_os} / Funcionário ${codigo_funcionario}.

    END

Busca Valor Comissão Serviço Gerada Por Papel
    [Arguments]    ${codigo_os}    ${codigo_funcionario}    ${papel}

    IF    '${papel}' == 'vendedor'

        ${query_valor}    Query    SELECT ROUND(COALESCE(SUM(cs.ValorComissao), 0), 2) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.ComissaoVendedor = 1 AND cs.Cancelada IS NULL;

    ELSE IF    '${papel}' == 'executor'

        ${query_valor}    Query    SELECT ROUND(COALESCE(SUM(cs.ValorComissao), 0), 2) FROM comissoesservico cs WHERE cs.CodigoVenda = ${codigo_os} AND cs.CodigoFuncionario = ${codigo_funcionario} AND cs.ComissaoVendedor IS NULL AND cs.Cancelada IS NULL;

    ELSE

        Fail    Papel inválido: '${papel}'. Use 'vendedor' ou 'executor'.

    END

    ${valor}    Busca Comissao Servico Gerada    ${query_valor}

    RETURN    ${valor}

Valida Comissão Linha Serviço
    [Arguments]    ${tipo_linha}    ${cenario}

    Log To Console    \n[Valida Comissão Linha Serviço] Tipo: ${tipo_linha} | Cenário: ${cenario}

    ${valor_base}    Consulta valor base serviço    ${CODIGO_OPERACAO_MOV}    ${Total_Tributos_Servico}

    IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ] Vendedor ${Codigo_Vendedor} não possui registro na tabela 'comissaoporlinha_vendedor' para o serviço ${COD_SERVICO}.
        END

        ${aliquota}    Set Variable    ${aliquotas}[0]

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota}

        Log To Console    [PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ] Aliquota: ${aliquota} | Comissão: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${valor_bd}    Busca Valor Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}

        Should Be Equal As Numbers    ${valor_bd}    0    msg=[PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ] Comissão deveria ser 0, mas encontrou ${valor_bd}.

        ${Total_Comissao_OS}    Set Variable    ${0}

        Log To Console    [PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ] cpv.Aliquota = 0 → Comissão: 0 (registro com valor 0)

    ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    deve_gerar=${True}

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${False}

        ${aliquotas_executor}    Consulta alíquotas serviço por vendedor    ${Codigo_Tecnico_Servico}    ${COD_SERVICO}

        IF    $aliquotas_executor is None
            Fail    [PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ] Executor ${Codigo_Tecnico_Servico} não possui registro na tabela 'comissaoporlinha_vendedor' para o serviço ${COD_SERVICO}.
        END

        ${aliquota_executor}    Set Variable    ${aliquotas_executor}[0]

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_executor}

        Log To Console    [PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ] Executor ${Codigo_Tecnico_Servico} cpv.Aliquota: ${aliquota_executor} | Comissão executor: ${Total_Comissao_OS} | Vendedor OS: SEM registro na tabela 'comissaoporlinha_vendedor'

    ELSE IF    '${cenario}' == 'PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}

        Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ] Comissão do executor (${Codigo_Tecnico_Servico}) deveria ser 0, mas encontrou ${valor_executor_bd}.

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${False}

        ${Total_Comissao_OS}    Set Variable    ${0}

        Log To Console    [PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ] Executor cpv.Aliquota = 0 → NINGUÉM recebe | Executor: registro com valor 0 | Vendedor OS: SEM registro na tabela 'comissaoporlinha_vendedor'

    ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC] Vendedor ${Codigo_Vendedor} não possui registro em cpv para o serviço ${COD_SERVICO}.
        END

        ${aliquota}    Set Variable    ${aliquotas}[0]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC] Comissão do executor (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_executor_bd}.

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota}

        Log To Console    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC] Aliquota: ${aliquota} | AliquotaExec: 0 | Comissão vendedor: ${Total_Comissao_OS} | Executor: valor 0

    ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC] Vendedor ${Codigo_Vendedor} não possui registro em cpv para o serviço ${COD_SERVICO}.
        END

        ${aliquota_execucao}    Set Variable    ${aliquotas}[1]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Should Be Equal As Numbers    ${valor_vendedor_bd}    0    msg=[PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC] Comissão do vendedor (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_vendedor_bd}.

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_execucao}

        Log To Console    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC] Aliquota: 0 | AliquotaExec: ${aliquota_execucao} | Vendedor: valor 0 | Comissão executor: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ] Vendedor ${Codigo_Vendedor} não possui registro em cpv para o serviço ${COD_SERVICO}.
        END

        ${aliquota}             Set Variable    ${aliquotas}[0]
        ${aliquota_execucao}    Set Variable    ${aliquotas}[1]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        ${Total_Comissao_OS}    Calcula Comissao Servico Aliquota Somada    ${valor_base}    ${aliquota}    ${aliquota_execucao}

        Log To Console    [PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ] Aliquota: ${aliquota} | AliquotaExec: ${aliquota_execucao} | Comissão total: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_ALIQ' or '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_SEM_ALIQ'

        ${aliquotas_executor}    Consulta alíquotas serviço por vendedor    ${Codigo_Tecnico_Servico}    ${COD_SERVICO}

        IF    $aliquotas_executor is None
            Fail    [${cenario}] Executor ${Codigo_Tecnico_Servico} não possui registro em cpv para o serviço ${COD_SERVICO}.
        END

        ${aliquota_execucao}    Set Variable    ${aliquotas_executor}[1]

        ${aliquotas_vendedor}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas_vendedor is not None
            ${aliquota_vendedor_os}    Set Variable    ${aliquotas_vendedor}[0]
        ELSE
            ${aliquota_vendedor_os}    Set Variable    0
        END

        ${resultado}    Calcula Comissao Servico Vendedores Diferentes    ${valor_base}    ${aliquota_execucao}    ${aliquota_vendedor_os}

        ${comissao_executor}       Set Variable    ${resultado}[comissao_executor]
        ${comissao_vendedor_os}    Set Variable    ${resultado}[comissao_vendedor_os]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor    deve_gerar=${True}

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        IF    ${comissao_executor} == 0

            ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor

            Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[${cenario}] Comissão do executor (${Codigo_Tecnico_Servico}) deveria ser 0, mas encontrou ${valor_executor_bd}.

            Log To Console    [${cenario}] Executor ${Codigo_Tecnico_Servico}: AliquotaExec = 0 → registro com valor 0.

        ELSE

            ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor
            
            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${comissao_executor}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${comissao_executor}    ${valor_executor_bd}

            Should Be Equal As Numbers    ${valor_executor_bd}    ${comissao_executor}    msg=[${cenario}] Comissão do executor (${Codigo_Tecnico_Servico}) diverge.

            Log To Console    [${cenario}] Executor ${Codigo_Tecnico_Servico}: AliquotaExec ${aliquota_execucao} → comissão: ${comissao_executor}

        END

        IF    ${comissao_vendedor_os} == 0

            ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

            Should Be Equal As Numbers    ${valor_vendedor_bd}    0    msg=[${cenario}] Comissão do vendedor OS (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_vendedor_bd}.

            Log To Console    [${cenario}] Vendedor OS ${Codigo_Vendedor}: Aliquota = 0 → registro com valor 0.

        ELSE

            ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${comissao_vendedor_os}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${comissao_vendedor_os}    ${valor_vendedor_bd}

            Should Be Equal As Numbers    ${valor_vendedor_bd}    ${comissao_vendedor_os}    msg=[${cenario}] Comissão do vendedor OS (${Codigo_Vendedor}) diverge.

            Log To Console    [${cenario}] Vendedor OS ${Codigo_Vendedor}: Aliquota ${aliquota_vendedor_os} → comissão: ${comissao_vendedor_os}

        END

        IF    ${comissao_executor} > 0

            ${Total_Comissao_OS}    Set Variable    ${comissao_executor}

            Set Test Variable    ${Codigo_Vendedor_Comissao_Tela}    ${Codigo_Tecnico_Servico}

            Log To Console    [${cenario}] Comissão do executor para baixa: ${Total_Comissao_OS}

        ELSE IF    ${comissao_vendedor_os} > 0

            ${Total_Comissao_OS}    Set Variable    ${comissao_vendedor_os}

            Set Test Variable    ${Codigo_Vendedor_Comissao_Tela}    ${Codigo_Vendedor}

            Log To Console    [${cenario}] Comissão do vendedor OS para baixa: ${Total_Comissao_OS}

        ELSE

            ${Total_Comissao_OS}    Set Variable    0

            Log To Console    [${cenario}] Nenhuma comissão para baixa (ambos zero).

        END

    ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ] Vendedor ${Codigo_Vendedor} deveria ter registro em cpv para serviço ${COD_SERVICO}.
        END

        ${aliquota}    Set Variable    ${aliquotas}[0]

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota}

        Log To Console    [PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ] cpv.Aliquota DIFERENCIADA: ${aliquota} | Comissão: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${valor_bd}    Busca Valor Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}

        Should Be Equal As Numbers    ${valor_bd}    0    msg=[PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO] Comissão do vendedor (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_bd}.

        ${Total_Comissao_OS}    Set Variable    ${0}

        Log To Console    [PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO] Mesmo vend, param desab | cpv.Aliquota = 0 → registro com valor 0, NÃO aparece no grid

    ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquota_geral}    Consulta alíquota geral serviço    ${COD_SERVICO}

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_geral}

        Log To Console    [PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV] SEM cpv → Aliquota Geral: ${aliquota_geral} | Comissão: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV'

        ${aliquotas_executor}    Consulta alíquotas serviço por vendedor    ${Codigo_Tecnico_Servico}    ${COD_SERVICO}

        IF    $aliquotas_executor is None
            Fail    [${cenario}] Executor ${Codigo_Tecnico_Servico} não possui registro em cpv para o serviço ${COD_SERVICO}.
        END

        ${aliquota_executor}    Set Variable    ${aliquotas_executor}[0]

        IF    ${aliquota_executor} > 0
            
            Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    deve_gerar=${True}

            Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${False}

            ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_executor}

            Log To Console    [${cenario}] Executor cpv.Aliquota: ${aliquota_executor} | Comissão executor: ${Total_Comissao_OS} | Vendedor OS: SEM registro em comissoesservico

        ELSE
            
            Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    deve_gerar=${True}

            ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}

            Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[${cenario}] Comissão do executor (${Codigo_Tecnico_Servico}) deveria ser 0, mas encontrou ${valor_executor_bd}.

            Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${False}

            ${Total_Comissao_OS}    Set Variable    ${0}

            Log To Console    [${cenario}] Executor cpv.Aliquota = 0 → NINGUÉM recebe | Executor: registro com valor 0 | Vendedor OS: SEM registro em comissoesservico

        END

    ELSE IF    '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

        ${aliquota_geral}    Consulta alíquota geral serviço    ${COD_SERVICO}

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    deve_gerar=${True}

        Verifica Comissão Serviço Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${False}

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_geral}

        Log To Console    [${cenario}] Vend ≠, param desab | Executor SEM cpv → Aliquota Geral: ${aliquota_geral} | Comissão executor: ${Total_Comissao_OS} | Vendedor OS: SEM registro em comissoesservico

    ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO] Vendedor ${Codigo_Vendedor} não possui registro em cpv para serviço ${COD_SERVICO}.
        END

        ${aliquota}    Set Variable    ${aliquotas}[0]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO] Comissão do executor (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_executor_bd}.

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota}

        Log To Console    [PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO] cpv.Aliquota: ${aliquota} | cpv.AliquotaExec: 0 | Comissão vendedor: ${Total_Comissao_OS} | Executor: valor 0

    ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC] Vendedor ${Codigo_Vendedor} não possui registro em cpv para serviço ${COD_SERVICO}.
        END

        ${aliquota_execucao}    Set Variable    ${aliquotas}[1]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Should Be Equal As Numbers    ${valor_vendedor_bd}    0    msg=[PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC] Comissão do vendedor (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_vendedor_bd}.

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        ${Total_Comissao_OS}    Calcula Comissao Servico Com Aliquota    ${valor_base}    ${aliquota_execucao}

        Log To Console    [PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC] cpv.Aliquota: 0 | cpv.AliquotaExec: ${aliquota_execucao} | Vendedor: valor 0 | Comissão executor: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ'

        ${aliquotas}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    $aliquotas is None
            Fail    [PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ] Vendedor ${Codigo_Vendedor} não possui registro em cpv para serviço ${COD_SERVICO}.
        END

        ${aliquota}             Set Variable    ${aliquotas}[0]
        ${aliquota_execucao}    Set Variable    ${aliquotas}[1]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        ${Total_Comissao_OS}    Calcula Comissao Servico Aliquota Somada    ${valor_base}    ${aliquota}    ${aliquota_execucao}

        Log To Console    [PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ] Mesmo vend, param hab | cpv.Aliquota: ${aliquota} | cpv.AliquotaExec: ${aliquota_execucao} | Comissão total: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV'

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor    deve_gerar=${True}

        ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    executor

        ${aliquota_geral}    Consulta alíquota geral serviço    ${COD_SERVICO}

        ${Total_Comissao_OS}    Calcula Comissao Servico Aliquota Somada    ${valor_base}    ${aliquota_geral}    ${aliquota_geral}

        Log To Console    [PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV] Mesmo vend, param hab, SEM cpv | 2 × AliquotaGeral: ${aliquota_geral} | Comissão total: ${Total_Comissao_OS}

    ELSE IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

        ${aliquotas_executor}    Consulta alíquotas serviço por vendedor    ${Codigo_Tecnico_Servico}    ${COD_SERVICO}

        IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'
            
            ${aliquota_geral}    Consulta alíquota geral serviço    ${COD_SERVICO}

            ${aliquota_execucao}    Set Variable    ${aliquota_geral}

        ELSE

            IF    $aliquotas_executor is None
                Fail    [${cenario}] Executor ${Codigo_Tecnico_Servico} não possui registro em cpv para o serviço ${COD_SERVICO}.
            END

            ${aliquota_execucao}    Set Variable    ${aliquotas_executor}[1]

        END

        ${aliquotas_vendedor}    Consulta alíquotas serviço por vendedor    ${Codigo_Vendedor}    ${COD_SERVICO}

        IF    '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV' or '${cenario}' == 'PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV'

            ${aliquota_geral_vend}    Consulta alíquota geral serviço    ${COD_SERVICO}

            ${aliquota_vendedor_os}    Set Variable    ${aliquota_geral_vend}

        ELSE IF    $aliquotas_vendedor is not None

            ${aliquota_vendedor_os}    Set Variable    ${aliquotas_vendedor}[0]
            
        ELSE

            ${aliquota_vendedor_os}    Set Variable    0

        END

        ${resultado}    Calcula Comissao Servico Vendedores Diferentes    ${valor_base}    ${aliquota_execucao}    ${aliquota_vendedor_os}

        ${comissao_executor}       Set Variable    ${resultado}[comissao_executor]
        ${comissao_vendedor_os}    Set Variable    ${resultado}[comissao_vendedor_os]

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor    deve_gerar=${True}

        Verifica Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor    deve_gerar=${True}

        IF    ${comissao_executor} == 0

            ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor

            Should Be Equal As Numbers    ${valor_executor_bd}    0    msg=[${cenario}] Comissão do executor (${Codigo_Tecnico_Servico}) deveria ser 0, mas encontrou ${valor_executor_bd}.

            Log To Console    [${cenario}] Executor ${Codigo_Tecnico_Servico}: AliquotaExec = 0 → registro com valor 0.

        ELSE

            ${valor_executor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Tecnico_Servico}    executor

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${comissao_executor}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${comissao_executor}    ${valor_executor_bd}

            Should Be Equal As Numbers    ${valor_executor_bd}    ${comissao_executor}    msg=[${cenario}] Comissão do executor (${Codigo_Tecnico_Servico}) diverge.

            Log To Console    [${cenario}] Executor ${Codigo_Tecnico_Servico}: AliquotaExec ${aliquota_execucao} → comissão: ${comissao_executor}

        END

        IF    ${comissao_vendedor_os} == 0

            ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor

            Should Be Equal As Numbers    ${valor_vendedor_bd}    0    msg=[${cenario}] Comissão do vendedor OS (${Codigo_Vendedor}) deveria ser 0, mas encontrou ${valor_vendedor_bd}.

            Log To Console    [${cenario}] Vendedor OS ${Codigo_Vendedor}: Aliquota = 0 → registro com valor 0.

        ELSE

            ${valor_vendedor_bd}    Busca Valor Comissão Serviço Gerada Por Papel    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    vendedor
            
            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${comissao_vendedor_os}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${comissao_vendedor_os}    ${valor_vendedor_bd}

            Should Be Equal As Numbers    ${valor_vendedor_bd}    ${comissao_vendedor_os}    msg=[${cenario}] Comissão do vendedor OS (${Codigo_Vendedor}) diverge.

            Log To Console    [${cenario}] Vendedor OS ${Codigo_Vendedor}: Aliquota ${aliquota_vendedor_os} → comissão: ${comissao_vendedor_os}

        END

        IF    ${comissao_executor} > 0

            ${Total_Comissao_OS}    Set Variable    ${comissao_executor}

            Set Test Variable    ${Codigo_Vendedor_Comissao_Tela}    ${Codigo_Tecnico_Servico}

            Log To Console    [${cenario}] Comissão do executor para baixa: ${Total_Comissao_OS}

        ELSE IF    ${comissao_vendedor_os} > 0

            ${Total_Comissao_OS}    Set Variable    ${comissao_vendedor_os}

            Set Test Variable    ${Codigo_Vendedor_Comissao_Tela}    ${Codigo_Vendedor}

            Log To Console    [${cenario}] Comissão do vendedor OS para baixa: ${Total_Comissao_OS}
            
        ELSE

            ${Total_Comissao_OS}    Set Variable    0

            Log To Console    [${cenario}] Nenhuma comissão para baixa (ambos zero).

        END

    ELSE

        Fail    Cenário '${cenario}' não reconhecido para tipo '${tipo_linha}'.

    END

    Set Test Variable    ${Total_Comissao_OS}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_OS}
    Set Test Variable    ${Total_Comissao_Servicos}    ${Total_Comissao_OS}

Calcula comissão sobre total venda - Serviços

    ${queryComissaoServicos}    Query    SELECT ROUND(SUM(vs.ComissaoTotal), 2) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL;

    IF    ${Parametro_ComissaoVendedorEExecutorServico}
        
        ${consultaValorTotalServico}    Query    SELECT vs.ValorTotal FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} AND vs.Cancelada IS NULL;

        ${valorTotalServico}    Set Variable    ${consultaValorTotalServico[0][0]}    

        ${calcComissaoServicos}    Evaluate    ((decimal.Decimal(str(${valorTotalServico})) - (decimal.Decimal(str(${valorTotalServico})) * (decimal.Decimal(str(${Total_Tributos_Servico})) / decimal.Decimal("100")))) * (decimal.Decimal(str(${PercentualComissaoTotalVenda_Servico})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
        
        IF    not ${OS_Vendedor_E_Tecnico_Diferentes}

            ${calcComissaoServicos}    Evaluate    (decimal.Decimal(str(${calcComissaoServicos})) * decimal.Decimal("2"))    modules=decimal 
            
        END

        IF    ${OS_Vendedor_E_Tecnico_Diferentes}

            ${Codigo_Funcionario}    Set Variable    ${Codigo_Tecnico_Servico}

        ELSE

            ${Codigo_Funcionario}    Set Variable    ${Codigo_Vendedor}

        END

        ${query_ComissaoServico}    Query    SELECT ROUND(SUM(cs.ValorComissao), 2) FROM comissoesservico cs WHERE cs.CodigoVenda = ${COD_ORDEM_SERVICO} AND cs.CodigoFuncionario = ${Codigo_Funcionario} AND cs.Cancelada IS NULL;

        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${calcComissaoServicos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcComissaoServicos}    ${query_ComissaoServico[0][0]}

        Should Be Equal As Numbers    ${query_ComissaoServico[0][0]}    ${calcComissaoServicos}
        
    ELSE

        ${calcComissaoServicos}    Evaluate    (decimal.Decimal(str(${Valor_Total_Servicos})) * (decimal.Decimal(str(${PercentualComissaoTotalVenda_Servico})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
        
        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${calcComissaoServicos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${calcComissaoServicos}    ${queryComissaoServicos[0][0]}

        Should Be Equal As Numbers    ${queryComissaoServicos[0][0]}    ${calcComissaoServicos}

    END

    Set Test Variable    ${Total_Comissao_Servicos}    ${calcComissaoServicos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Servicos}

    Log To Console    Valor final da comissão (Serviço): ${Total_Comissao_Servicos}

Pesquisa código da operação com zeros a esquerda

    # Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda
    ${Cod_Venda_String}    Convert To String    ${CODIGO_OPERACAO_MOV}

    ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Venda_String}

    ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}

    FOR    ${I}    IN RANGE    ${Quantidade_de_zeros_esquerda}

        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

    END

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    9

        Press Special Key    RIGHT

    END

    Press Special Key    SPACE

E baixo a comissao recém recebida

    IF    ${Cenario_Sem_Comissao_Servico} and ${Baixa_Eh_Servico}

        Log To Console    [Cenario_Sem_Comissao_Servico] Sem comissão de serviço para baixar → pulando baixa.
        RETURN

    END

    IF    ${Cenario_Sem_Comissao_Produto} and not ${Baixa_Eh_Servico}

        Log To Console    [Cenario_Sem_Comissao_Produto] Sem comissão de produto para baixar → pulando baixa.
        RETURN

    END

    SikuliLibrary.Click    ${BT_BAIXAR}
    Wait Until Screen Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_OK}

    # IF    ${Total_Comissao} == 0 and ${Comissao_Zerada_Por_Devolucao}
    IF    ${Comissao_Zerada_Por_Devolucao}

        Wait Until Screen Contain    ${AVISO_COMISSAO_ZERADA}    ${TEMPO_TELA}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_FECHAR}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ESC

        Log To Console    Finalizando Teste pois comissão está zerada (correto para os cenários 2 e 3)

    ELSE

        Wait Until Screen Contain    ${AVISO_BAIXA_SUCESSO}    ${TEMPO_TELA}
        
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

        IF    ${Comissao_SomenteRecebidas}

            Wait Until Screen Contain    ${AVISO_PERIODO_COM_LOTE_PAGAMENTO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

            # Press Special Key    ENTER
            SikuliLibrary.Click    ${BT_OK_AVISO_LOTE_DE_PAGAMENTO}
            
        END

        Wait Until Screen Not Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

        Valida baixa de comissão

    END

Valida baixa de comissão

    IF    ${Baixa_Eh_Servico}
        
        Sleep    ${SLEEP_BAIXO}

        IF    '${Codigo_Vendedor_Comissao_Tela}' != '${EMPTY}'

            ${queryComissoesPagas_Servico}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor_Comissao_Tela} ORDER BY ID DESC LIMIT 1;

        ELSE IF    ${OS_Vendedor_E_Tecnico_Diferentes}

            ${queryComissoesPagas_Servico}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Tecnico_Servico} ORDER BY ID DESC LIMIT 1;

        ELSE

            ${queryComissoesPagas_Servico}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC LIMIT 1;
            
        END
        
        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${Total_Comissao_Servicos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Servicos}    ${queryComissoesPagas_Servico[0][1]}

        IF    ${houve_ajuste}
            Set Test Variable    ${Total_Comissao_Servicos}
        END

        Should Be Equal As Numbers    ${queryComissoesPagas_Servico[0][1]}    ${Total_Comissao_Servicos}

        Set Test Variable    ${NDoc_Comissao}    ${queryComissoesPagas_Servico[0][0]}

    END

    IF    not ${Baixa_Eh_Servico}

        ${queryComissoesPagas_Produto}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC LIMIT 1;

        IF    ${Teste_Comissão_Parcelada}
            
            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Total_Comissao}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao}    ${queryComissoesPagas_Produto[0][1]}

            IF    ${houve_ajuste}
                Set Test Variable    ${Total_Comissao}
            END

            Should Be Equal As Numbers    ${queryComissoesPagas_Produto[0][1]}    ${Total_Comissao}

        ELSE
            
            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Total_Comissao_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Produtos}    ${queryComissoesPagas_Produto[0][1]}

            IF    ${houve_ajuste}
                Set Test Variable    ${Total_Comissao_Produtos}
            END

            Should Be Equal As Numbers    ${queryComissoesPagas_Produto[0][1]}    ${Total_Comissao_Produtos}

        END

        Set Test Variable    ${NDoc_Comissao}    ${queryComissoesPagas_Produto[0][0]}

    END

Quando acesso o caixa aberto

    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    Wait Until Screen Contain    ${LABEL_STATUS_ABERTO}    ${TEMPO_TELA}

E vou para a aba de contas a pagar

    SikuliLibrary.Click    ${ABA_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR}    ${TEMPO_TELA}

Então faço o pagamento da comissao

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    Wait Until Screen Contain    ${GRID_COMISSOES_PAGAR}    ${SLEEP_ALTO}

    SikuliLibrary.Click    ${INPUT_NUMERO_DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${NDoc_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.g
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA_CONTA_A_PAGAR}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S

    IF    ${Parametro_CaixaControladoPorUsuario}

        # No MyCommerce valida se o caixa que está aberto ou por usuario ou por terminal, tem marcado o recebimento ou pagamento diario, se não tiver exibe a tela de confirmação de data
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Usuario = ( SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1 ) AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa

        END

    ELSE

        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa

        END

    END

    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    ${Total_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C

    Sleep    ${SLEEP_ALTO}
    ${telaDeImpressao}    Exists    ${TELA_IMPRESSAO}

    IF    ${telaDeImpressao}

        Press Special Key    ESC
        Wait Until Screen Not Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}

    END

    Valida baixa comissao

Valida baixa comissao

    Sleep    ${SLEEP_BAIXO}
    ${ComissaoPaga}    Query    SELECT Codigo, valor FROM contasapagar WHERE NDocumento = ${NDoc_Comissao} AND Quitado = 1 AND Descricao LIKE '%Comissão%' AND nComissao = ${NDoc_Comissao}
    # ${Comissao_Paga_BD}    Evaluate    round((${ComissaoPaga[0][1]}), 2)
    ${Comissao_Paga_BD}    Evaluate    decimal.Decimal(str(${ComissaoPaga[0][1]})).quantize(decimal.Decimal("0.00"))    modules=decimal
    
    Should Be Equal    ${ComissaoPaga[0][0]}    ${Codigo_Vendedor}

    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${Total_Comissao}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao}    ${Comissao_Paga_BD}

    IF    ${houve_ajuste}
        Set Test Variable    ${Total_Comissao}
    END

    Should Be Equal    ${Comissao_Paga_BD}    ${Total_Comissao}

    Check If Exists In Database    SELECT Sequencia, nDocumento, CodigoAbertura, ValorDocumento FROM caixamovimentos WHERE nDocumento = ${NDoc_Comissao}

Então visualizo os detalhes da comissao recem paga

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    
    IF    ${Comissao_SomenteRecebidas}

        FOR    ${i}    IN RANGE    2

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
        Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}
    
        ${dataInicial}    Copia data do campo e converte para o formato ISO 8601
        Sleep    ${SLEEP_BAIXO}

        Type With Modifiers    H
        Press Special Key    TAB

        Wait Until Screen Contain    ${TOOLTIP_ATALHOS_DATA}    ${SLEEP_ALTO}

        Type With Modifiers    H
        ${dataFinal}    Copia data do campo e converte para o formato ISO 8601

        Press Combination    KEY.ALT    KEY.C
        Wait Until Screen Contain    ${GUIA_COMISSOES_PAGAS_AGENDADAS}    ${TEMPO_TELA}

        Sleep    ${SLEEP_BAIXO}
        ${gridSemRegistro}    Exists    ${GRID_SEM_REGISTROS}

        IF    ${gridSemRegistro}

            Press Combination    KEY.ALT    KEY.I
            Sleep    ${SLEEP_ALTO}
            Wait Until Screen Not Contain    ${LABEL_CARREGANDO_COMISSOES_GRID}    ${TEMPO_TELA}

        END

    END

    ${Cod_Com_String}    Convert To String    ${NDoc_Comissao}

    ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Com_String}

    ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}

    FOR    ${J}    IN RANGE    ${Quantidade_de_zeros_esquerda}

        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

    END

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${COL_LOTE}

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${NDoc_Comissao}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Wait Until Screen Contain    ${TELA_DETALHES_COMISSAO}    ${SLEEP_ALTO}

    Press Special Key    ESC

Dado que acesso o menu de vale compras

    SikuliLibrary.Click    ${MENU_COMERCIAL}

    FOR    ${I}    IN RANGE    9

        Press Special Key    DOWN

    END
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_VALE_COMPRA}     ${TEMPO_TELA}

E seleciono o vale gerado pela devolução

    Input Text    ${EMPTY}    ${ID_VALE_COMPRA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER

Quando faço a baixa do mesmo

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.B
    Wait Until Screen Contain    ${AVISO_BAIXA_VALE_COMPRA}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${TELA_BAIXA_VALE_COMPRA}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_BAIXO}

    Finalização com recebimento de duplicatas(${VALOR_FINAL_DEVOLUCAO})

    Wait Until Screen Contain    ${TELA_VALE_COMPRA}    ${TEMPO_TELA}

    Press Special Key    ESC

Dado que acesso a tela de relatório de comissão

    SikuliLibrary.Click    ${MENU_RELATORIOS}
    SikuliLibrary.Click    ${SUBMENU_RELATORIOS_COMISSOES}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${SUBMENU_RELATORIOS_COMISSOES}

    Wait Until Screen Contain    ${TELA_RELATORIO_COMISSOES}    ${TEMPO_TELA}

Informa o vendedor

    SikuliLibrary.Click    ${LABEL_COD_VENDEDOR_RELATORIO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB

Valida os dados do relatório de comissões

    IF    ${COMISSOES_AGENDADAS}

        Log To Console    Comissões agendadas ainda não foram validadas.
        
    ELSE IF    ${COMISSOES_PAGAS}

        Log To Console    Comissões pagas ainda não foram validadas.  

    ELSE IF    ${COMISSOES_PENDENTES}
        
        Validação de comissões pendentes

    END

    IF    ${Relatorio_Deve_Conter_Dados} == ${False}

       Validação de dados que não devem constar no relatório
    
    ELSE

        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.G

        Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${TEMPO_TELA}
        
        Verifica se a operação gerada está vinculada a uma comissão pendente

    END
    
    # De início, comparação com o banco disponível somente para comissões pendentes.
    IF    ${COMISSOES_PENDENTES} and ${Relatorio_Deve_Conter_Dados}

        Compara Valores Relatorio e Banco Pendentes

    END

Validação de comissões pendentes
    
    Sleep    ${SLEEP_MEDIO}

    IF    '${COMISSOES_GERAR_SOBRE}' == 'Somente Recebidas'
        
        ${queryConsulta}    Set Variable    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda, verificaVlrParcelasPagasMes_Func(VlrParcelasPagasMES, CodigoVenda, CodigoVendedor) AS TotalRecFunc FROM Temp_rel_comissao WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;
        
        ${haDadosBanco}    Run Keyword And Return Status    Check If Exists In Database    SELECT *, verificaVlrParcelasPagasMes_Func(VlrParcelasPagasMES, CodigoVenda, CodigoVendedor) AS TotalRecFunc FROM Temp_rel_comissao WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV};

    ELSE IF    '${COMISSOES_GERAR_SOBRE}' == 'Vendas Faturadas'

        ${queryConsulta}    Set Variable    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM temp_rel_comissao WHERE NOT NumeroNF is null AND CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;
        
        ${haDadosBanco}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM temp_rel_comissao WHERE NOT NumeroNF is null AND CodigoVenda = ${CODIGO_OPERACAO_MOV};

    ELSE

        IF    ${Filtro_Produtos} and ${Filtro_Servicos}

            ${queryConsulta}    Set Variable    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} UNION ALL SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;

        ELSE IF    ${Filtro_Produtos}
         
            ${queryConsulta}    Set Variable    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;

        ELSE IF    ${Filtro_Servicos}

            ${queryConsulta}    Set Variable    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;

        END

    END
    
    Set Test Variable    ${queryConsulta}
    
Validação de dados que não devem constar no relatório

    IF    '${COMISSOES_GERAR_SOBRE}' == 'Somente Recebidas'
        
        Sleep    ${SLEEP_BAIXO}
        ${consulta}    Query    SELECT EXISTS (SELECT 1 FROM vendas v INNER JOIN caixamovimentos cm ON v.Codigo = cm.NVenda WHERE v.CodigoVendedor = ${Codigo_Vendedor} AND v.`Data` = CURDATE() AND v.Codigo NOT IN (${CODIGO_OPERACAO_MOV}) AND cm.ValorPago IS NOT NULL) AS tem_venda_paga;
        
        ${vendedor_tem_venda_recebida_hoje}    Set Variable    ${consulta[0][0]}

        IF    '${vendedor_tem_venda_recebida_hoje}' == '0'

            Wait Until Screen Contain    ${AVISO_SEM_DADOS_PARA_EXIBICAO}    ${SLEEP_ALTO}

            Press Special Key    ENTER

        ELSE

            Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${SLEEP_ALTO}
        
            Sleep    ${SLEEP_BAIXO}
            Press Combination    KEY.ALT    KEY.G

            Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${TEMPO_TELA}

            Verifica se a operação gerada está vinculada a uma comissão pendente
        
        END
    
    ELSE

        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.G

        Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${TEMPO_TELA}

        Verifica se a operação gerada está vinculada a uma comissão pendente

    END

Compara Valores Relatorio e Banco Pendentes
    
    ${consultaRelatorio}    Query    ${queryConsulta}
    ${qtdeRegistro}         Get Length    ${consultaRelatorio}

    FOR    ${i}    IN RANGE    ${qtdeRegistro}
        
        ${VALOR_FINAL_OPERAÇÃO}    Evaluate    decimal.Decimal(str(${VALOR_FINAL_OPERAÇÃO}))    modules=decimal

        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${VALOR_FINAL_OPERAÇÃO}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${VALOR_FINAL_OPERAÇÃO}    ${consultaRelatorio[${i}][0]}

        Should Be Equal As Numbers    ${consultaRelatorio[${i}][0]}    ${VALOR_FINAL_OPERAÇÃO}

        IF    '${consultaRelatorio[${i}][8]}' == 'OS'

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Valor_Total_Servicos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Valor_Total_Servicos}    ${consultaRelatorio[${i}][2]}

            Should Be Equal As Numbers    ${consultaRelatorio[${i}][2]}    ${Valor_Total_Servicos}

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Total_Comissao_Servicos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Servicos}    ${consultaRelatorio[${i}][4]}

            Should Be Equal As Numbers    ${consultaRelatorio[${i}][4]}    ${Total_Comissao_Servicos}
            
        END

        IF    '${consultaRelatorio[${i}][8]}' == 'VP'

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Valor_Total_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Valor_Total_Produtos}    ${consultaRelatorio[${i}][1]}

            Should Be Equal As Numbers    ${consultaRelatorio[${i}][1]}    ${Valor_Total_Produtos}

            # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
            ${Total_Comissao_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Produtos}    ${consultaRelatorio[${i}][3]}

            Should Be Equal As Numbers    ${consultaRelatorio[${i}][3]}    ${Total_Comissao_Produtos}

        END
        
    END

Verifica se a operação gerada está vinculada a uma comissão pendente

    SikuliLibrary.Click    ${BT_BINOCULO_PESQUISA_RELATORIO}

    Wait Until Screen Contain    ${TELA_PESQUISA_TEXTO_IMPRESSAO}    ${SLEEP_ALTO}
        
    ${codigo_operacao_formatado}    Formata código venda em texto para pesquisa    ${CODIGO_OPERACAO_MOV}

    Type    ${EMPTY}    ${codigo_operacao_formatado}
        
    Press Special Key    ENTER

    Sleep    ${SLEEP_BAIXO}

    ${dado_encontrado}    Exists    ${Dado_Localizado_Na_Pesquisa_Relatorio}

    IF    ${Relatorio_Deve_Conter_Dados} == $False
        
        IF    ${dado_encontrado} == $False
            
            Log To Console    \nNenhum registro encontrado, conforme o esperado.
            
            # Nesse cenário, a mensagem 'Pesquisa do relatório concluída' significa que o valor pesquisado não foi encontrado no relatório.
            Wait Until Screen Contain    ${AVISO_PESQUISA_TEXTO_CONCLUIDA}    ${SLEEP_ALTO}

            Press Special Key    ENTER

        ELSE

            Fail    Registro encontrado no relatório de comissões, contrariando o comportamento esperado.\nComissão da venda consta como pendente no relatório de comissões.
        
        END

    ELSE

        IF    ${dado_encontrado}
            
            Log To Console    \nRegistro encontrado no relatório de comissões, conforme o esperado.
        
        ELSE
            
            # Nesse cenário, a mensagem 'Pesquisa do relatório concluída' significa que o valor pesquisado não foi encontrado no relatório.
            Wait Until Screen Contain    ${AVISO_PESQUISA_TEXTO_CONCLUIDA}    ${SLEEP_ALTO}

            Fail    Nenhum registro encontrado, contrariando o comportamento esperado.
        
        END

    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC

    Wait Until Screen Contain    ${TELA_RELATORIO_COMISSOES}    ${SLEEP_ALTO}

Quando insiro o técnico executor de serviço comissionado

    Input Text    ${EMPTY}    ${Codigo_Tecnico_Servico}
    
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

E seleciono as comissaos das vendas

    ${QuantidadeVendas}    Get Length    ${Codigo_Vendas}

    FOR    ${I}    IN RANGE    ${QuantidadeVendas}

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendas[${I}]}

        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Final_Vendas[${I}]}

        Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${DESCONTOS_COMISSOES[${I}][1]}

        E seleciono a comissão de produtos

    END

Calcula comissão por linha de produto - apenas 1 produto - Devolução

    Sleep    ${SLEEP_MEDIO}

    ${valor_comissao_unitario}    Consulta valor comissão produto único    ${COD_PRODUTO}    ${CODIGO_OPERACAO_MOV}

    ${Total_Comissao_Produtos}    Calcula Comissao Linha Produto Unico
    ...    ${valor_comissao_unitario}
    ...    ${Quantidade_Produto_Venda/Dev}
    ...    ${Total_Comissao_Produtos}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao_Produtos}

# Não testado ainda, apenas separei das demais operações. 
# VERIFICAR POSTERIORMENTE...
Calcula comissão por linha de produto - múltiplos produtos - Devolução

    Sleep    ${SLEEP_MEDIO}

    ${valores_comissao}    Consulta valores comissão por produto    ${Codigos_Produtos}

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Multiplos
    ...    ${valores_comissao}
    ...    ${Quantidade_Produto_Devolucao}
    ...    ${DADOS_VENDA_DEVOLUÇÃO}
    ...    ${POSIÇÃO_VALOR}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}
    Set Suite Variable    ${PERCENT_COMISSAO}

E comparo a comissão antes e após a edição da venda

    # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
    ${Total_Comissao}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao}    ${comissao_anterior}

    IF    ${houve_ajuste}
        Set Test Variable    ${Total_Comissao}
    END

    Should Be Equal As Numbers    ${comissao_anterior}    ${Total_Comissao}

E informo o vendedor comissionado

    SikuliLibrary.Click    ${LABEL_COD_VENDEDOR_RELATORIO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB

E seleciono o tipo da comissão(${tipo_comissao})

    IF    '${tipo_comissao}' == 'Agendadas'

        SikuliLibrary.Click    ${RADIOBT_COMISSOES_AGENDADAS}

        Set Test Variable    ${COMISSOES_AGENDADAS}    ${True}
        
    ELSE IF    '${tipo_comissao}' == 'Pagas'

        Log To Console    Implementar posteriormente.

        Set Test Variable    ${COMISSOES_PAGAS}    ${True}

    ELSE IF    '${tipo_comissao}' == 'Pendentes'

        SikuliLibrary.Click    ${RADIOBT_COMISSOES_PENDENTES}
        
        Set Test Variable    ${COMISSOES_PENDENTES}    ${True}

    END

E seleciono para gerar sobre(${tipo_geracao})

    Set Test Variable    ${COMISSOES_GERAR_SOBRE}    ${tipo_geracao}

    IF    '${tipo_geracao}' != 'Vendas'

        SikuliLibrary.Double Click    ${COMBOBOX_GERAR_SOBRE_VENDAS}

        IF    '${tipo_geracao}' == 'Vendas Faturadas'

            Press Special Key    DOWN

        ELSE IF    '${tipo_geracao}' == 'Somente Recebidas'

            Press Special Key    DOWN
            Press Special Key    DOWN

        END

    END
 
E valido os filtros de produtos e serviços
    [Arguments]    ${marcar_produtos}    ${marcar_servicos}

    # Validação Checkbox Produtos
    ${is_produtos_habilitado}    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_PRODUTOS_HABILITADO}    ${SLEEP_MEDIO}

    IF    ${marcar_produtos}
        
        IF    not ${is_produtos_habilitado}
            SikuliLibrary.Click    ${CHECKBOX_PRODUTOS_DESABILITADO}
        END

    ELSE
        
        IF    ${is_produtos_habilitado}
            SikuliLibrary.Click    ${CHECKBOX_PRODUTOS_HABILITADO}
        END

    END
    
    # Validação Checkbox Serviços
    ${is_servicos_habilitado}    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_SERVICOS_HABILITADO}    ${SLEEP_MEDIO}
    
    IF    ${marcar_servicos}
        
        IF    not ${is_servicos_habilitado}
            SikuliLibrary.Click    ${CHECKBOX_SERVICOS_DESABILITADO}
        END

    ELSE
        
        IF    ${is_servicos_habilitado}
            SikuliLibrary.Click    ${CHECKBOX_SERVICOS_HABILITADO}
        END

    END

    Set Test Variable    ${Filtro_Produtos}    ${marcar_produtos}
    Set Test Variable    ${Filtro_Servicos}    ${marcar_servicos}

Consulta valor comissão produto único
    [Arguments]    ${codigo_produto}    ${codigo_operacao}

    IF    '${Tipo_Comissao_Linha}' == 'Simples'

        ${resultado}    Query    SELECT vp.ValorUnitario * (cl.Aliquota / 100) AS ValorComissao FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo WHERE p.Codigo = ${codigo_produto} AND vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL;

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

        ${resultado}    Query    SELECT vp.ValorUnitario * (cpv.Aliquota / 100) AS ValorComissao FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor} WHERE p.Codigo = ${codigo_produto} AND vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL;

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

        ${vendedor_tem_aliquota}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND p.Codigo = ${codigo_produto} AND cl.Tipo = 'D' AND cl.Mista = 1;

        IF    ${vendedor_tem_aliquota}

            ${resultado}    Query    SELECT vp.ValorUnitario * (cpv.Aliquota / 100) AS ValorComissao FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor} WHERE p.Codigo = ${codigo_produto} AND vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL;

        ELSE

            ${resultado}    Query    SELECT vp.ValorUnitario * (cl.Aliquota / 100) AS ValorComissao FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo WHERE p.Codigo = ${codigo_produto} AND vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL;

        END

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

        Fail    Consulta de comissão para Tabela de Preço ainda não implementada.

    END

    IF    $resultado == []
        Fail    Comissão não encontrada para produto ${codigo_produto} na operação ${codigo_operacao} (tipo: ${Tipo_Comissao_Linha}).
    END

    ${valor_comissao_unitario}    Set Variable    ${resultado[0][0]}

    RETURN    ${valor_comissao_unitario}

Consulta valores comissão por produto
    [Arguments]    ${codigos_produtos}

    @{valores_comissao}    Create List

    FOR    ${cod_produto}    IN    @{codigos_produtos}

        IF    '${Tipo_Comissao_Linha}' == 'Simples'

            ${resultado}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo WHERE p.Codigo = ${cod_produto};

        ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

            ${resultado}    Query    SELECT SUM(p.vendaT1 * (cpv.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor} WHERE p.Codigo = ${cod_produto};

        ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

            ${vendedor_tem_aliquota}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND p.Codigo = ${cod_produto} AND cl.Tipo = 'D' AND cl.Mista = 1;

            IF    ${vendedor_tem_aliquota}

                ${resultado}    Query    SELECT SUM(p.vendaT1 * (cpv.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor} WHERE p.Codigo = ${cod_produto};

            ELSE

                ${resultado}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo WHERE p.Codigo = ${cod_produto};

            END

        ELSE IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

            Fail    Consulta de comissão para Tabela de Preço ainda não implementada.

        END

        IF    $resultado != [] and $resultado[0][0] is not None

            Append To List    ${valores_comissao}    ${resultado[0][0]}

        ELSE

            Append To List    ${valores_comissao}    ${None}

        END

    END

    Log To Console    [Consulta comissão múltiplos produtos] Tipo: ${Tipo_Comissao_Linha} | Valores: ${valores_comissao}

    RETURN    ${valores_comissao}

Consulta valor comissão serviço único
    [Arguments]    ${cod_servico}    ${codigo_operacao}    ${total_tributos_servico}

    IF    '${Tipo_Comissao_Linha}' == 'Simples'

        ${resultado}    Query    SELECT SUM((v.TotalServicos - (v.TotalServicos * (${total_tributos_servico} / 100))) * (cl.Aliquota / 100)) FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${cod_servico} INNER JOIN vendas v ON v.Codigo = ${codigo_operacao};

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Diferenciada Por Vendedor'

        ${resultado}    Query    SELECT SUM((v.TotalServicos - (v.TotalServicos * (${total_tributos_servico} / 100))) * (cpv.Aliquota / 100)) FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${cod_servico} INNER JOIN vendas v ON v.Codigo = ${codigo_operacao} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor};

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Mista'

        ${vendedor_tem_aliquota}    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo WHERE cpv.CodigoVendedor = ${Codigo_Vendedor} AND s.Codigo = ${cod_servico} AND cl.Tipo = 'D' AND cl.Mista = 1;

        IF    ${vendedor_tem_aliquota}

            ${resultado}    Query    SELECT SUM((v.TotalServicos - (v.TotalServicos * (${total_tributos_servico} / 100))) * (cpv.Aliquota / 100)) FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${cod_servico} INNER JOIN vendas v ON v.Codigo = ${codigo_operacao} INNER JOIN comissaoporlinha_vendedor cpv ON cpv.IDLinhaComissao = cl.Codigo AND cpv.CodigoVendedor = ${Codigo_Vendedor};

        ELSE

            ${resultado}    Query    SELECT SUM((v.TotalServicos - (v.TotalServicos * (${total_tributos_servico} / 100))) * (cl.Aliquota / 100)) FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${cod_servico} INNER JOIN vendas v ON v.Codigo = ${codigo_operacao};

        END

    ELSE IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco'

        Fail    Consulta de comissão para Tabela de Preço ainda não implementada.

    END

    IF    $resultado == [] or $resultado[0][0] is None
        Fail    Comissão não encontrada para serviço ${cod_servico} na operação ${codigo_operacao} (tipo: ${Tipo_Comissao_Linha}).
    END

    ${valor_comissao_servico}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta comissão serviço único] Serviço: ${cod_servico} | Operação: ${codigo_operacao} | Tipo: ${Tipo_Comissao_Linha} | Valor comissão: ${valor_comissao_servico}

    RETURN    ${valor_comissao_servico}

Consulta valor base serviço
    [Arguments]    ${codigo_operacao}    ${total_tributos_servico}

    ${resultado}    Query    SELECT (v.TotalServicos - (v.TotalServicos * (${total_tributos_servico} / 100))) AS ValorBase FROM vendas v WHERE v.Codigo = ${codigo_operacao};

    IF    $resultado == []
        Fail    Valor base do serviço não encontrado para a operação ${codigo_operacao}.
    END

    ${valor_base}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta valor base serviço] Operação: ${codigo_operacao} | Tributos: ${total_tributos_servico}% | Valor base: ${valor_base}

    RETURN    ${valor_base}

Consulta alíquotas serviço por vendedor
    [Arguments]    ${codigo_vendedor_consulta}    ${cod_servico}

    ${resultado}    Query    SELECT cpv.Aliquota, cpv.AliquotaExecucao FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo WHERE cpv.CodigoVendedor = ${codigo_vendedor_consulta} AND s.Codigo = ${cod_servico};

    IF    $resultado == []

        Log To Console    [Consulta alíquotas serviço] Vendedor ${codigo_vendedor_consulta} não possui registro em comissaoporlinha_vendedor para o serviço ${cod_servico}.
        RETURN    ${None}
        
    END

    ${aliquota}             Set Variable    ${resultado[0][0]}
    ${aliquota_execucao}    Set Variable    ${resultado[0][1]}

    Log To Console    [Consulta alíquotas serviço] Vendedor: ${codigo_vendedor_consulta} | Serviço: ${cod_servico} | Aliquota: ${aliquota} | AliquotaExecucao: ${aliquota_execucao}

    RETURN    ${aliquota}    ${aliquota_execucao}

Consulta alíquota geral serviço
    [Arguments]    ${cod_servico}

    ${resultado}    Query    SELECT cl.Aliquota FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo WHERE s.Codigo = ${cod_servico};

    IF    $resultado == []
        Fail    Alíquota geral da comissaoporlinha não encontrada para o serviço ${cod_servico}.
    END

    ${aliquota_geral}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta alíquota geral serviço] Serviço: ${cod_servico} | Aliquota geral: ${aliquota_geral}

    RETURN    ${aliquota_geral}

# ============================================================================================
# Keywords de Validação de Comissão por Linha — PRODUTO (Diferenciada Por Vendedor + Mista)
# ============================================================================================

Consulta alíquotas produto por vendedor
    [Arguments]    ${codigo_vendedor_consulta}    ${codigo_produto}

    ${resultado}    Query    SELECT cpv.Aliquota FROM comissaoporlinha_vendedor cpv INNER JOIN comissaoporlinha cl ON cl.Codigo = cpv.IDLinhaComissao INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo WHERE cpv.CodigoVendedor = ${codigo_vendedor_consulta} AND p.Codigo = ${codigo_produto};

    IF    $resultado == []

        Log To Console    [Consulta alíquotas produto] Vendedor ${codigo_vendedor_consulta} não possui registro em comissaoporlinha_vendedor para o produto ${codigo_produto}.
        RETURN    ${None}
        
    END

    ${aliquota}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta alíquotas produto] Vendedor: ${codigo_vendedor_consulta} | Produto: ${codigo_produto} | Aliquota: ${aliquota}

    RETURN    ${aliquota}

Consulta alíquota geral produto
    [Arguments]    ${codigo_produto}

    ${resultado}    Query    SELECT cl.Aliquota FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo WHERE p.Codigo = ${codigo_produto};

    IF    $resultado == []
        Fail    Alíquota geral da comissaoporlinha não encontrada para o produto ${codigo_produto}.
    END

    ${aliquota_geral}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta alíquota geral produto] Produto: ${codigo_produto} | Aliquota geral: ${aliquota_geral}

    RETURN    ${aliquota_geral}

Consulta valor base produto
    [Arguments]    ${codigo_produto}    ${codigo_operacao}

    ${resultado}    Query    SELECT vp.ValorUnitario FROM vendasprodutos vp WHERE vp.CodigoProduto = ${codigo_produto} AND vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL;

    IF    $resultado == []
        Fail    Valor base do produto ${codigo_produto} não encontrado para a operação ${codigo_operacao}.
    END

    ${valor_base}    Set Variable    ${resultado[0][0]}

    Log To Console    [Consulta valor base produto] Produto: ${codigo_produto} | Operação: ${codigo_operacao} | Valor base (unitário): ${valor_base}

    RETURN    ${valor_base}

Verifica Comissão Produto Gerada
    [Arguments]    ${codigo_operacao}    ${codigo_vendedor_verifica}    ${deve_gerar}=${True}

    ${query_count}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${codigo_operacao} AND vp.Cancelada IS NULL AND vp.ValorComissao IS NOT NULL AND vp.ValorComissao > 0;

    ${contagem}    Set Variable    ${query_count[0][0]}
    ${existe}    Evaluate    int(${contagem}) > 0

    IF    ${deve_gerar} and not ${existe}

        Fail    Comissão de produto deveria ter sido gerada para operação ${codigo_operacao} / Vendedor ${codigo_vendedor_verifica}, mas NÃO foi encontrado registro com ValorComissao > 0 em vendasprodutos.

    ELSE IF    not ${deve_gerar} and ${existe}

        Fail    Comissão de produto NÃO deveria ter sido gerada para operação ${codigo_operacao} / Vendedor ${codigo_vendedor_verifica}, mas FOI encontrado registro com ValorComissao > 0 em vendasprodutos.

    END

    IF    ${deve_gerar}

        Log To Console    [Verifica Comissão Produto Gerada] ✓ ValorComissao > 0 encontrado para operação ${codigo_operacao} / Vendedor ${codigo_vendedor_verifica}.

    ELSE

        Log To Console    [Verifica Comissão Produto Gerada] ✓ Nenhum ValorComissao > 0 (esperado) para operação ${codigo_operacao} / Vendedor ${codigo_vendedor_verifica}.

    END

Busca Valor Comissão Produto Gerada
    [Arguments]    ${codigo_operacao}    ${codigo_produto}

    ${query_valor}    Query    SELECT ROUND(COALESCE(SUM(vp.ValorComissao), 0), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${codigo_operacao} AND vp.CodigoProduto = ${codigo_produto} AND vp.Cancelada IS NULL;

    ${valor}    Evaluate    decimal.Decimal(str(${query_valor[0][0]})).quantize(decimal.Decimal("0.00"))    modules=decimal

    Log To Console    [Busca Valor Comissão Produto Gerada] Operação: ${codigo_operacao} | Produto: ${codigo_produto} | Valor: ${valor}

    RETURN    ${valor}

Calcula Comissao Produto Com Aliquota
    [Arguments]    ${valor_base}    ${aliquota}

    ${comissao}    Evaluate    (decimal.Decimal(str(${valor_base})) * (decimal.Decimal(str(${aliquota})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

    Log To Console    [Calcula Comissao Produto] Base: ${valor_base} | Aliquota: ${aliquota}% | Comissão: ${comissao}

    RETURN    ${comissao}

Valida Comissão Linha Produto
    [Arguments]    ${tipo_linha}    ${cenario}

    Log To Console    \n[Valida Comissão Linha Produto] Tipo: ${tipo_linha} | Cenário: ${cenario}

    ${valor_base}    Consulta valor base produto    ${COD_PRODUTO}    ${CODIGO_OPERACAO_MOV}

    IF    '${cenario}' == 'PROD__DIF_POR_VEND__COM_ALIQ'

        Verifica Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquota}    Consulta alíquotas produto por vendedor    ${Codigo_Vendedor}    ${COD_PRODUTO}

        IF    $aliquota is None
            Fail    [PROD__DIF_POR_VEND__COM_ALIQ] Vendedor ${Codigo_Vendedor} não possui registro na tabela 'comissaoporlinha_vendedor' para o produto ${COD_PRODUTO}.
        END

        ${Total_Comissao_Produtos}    Calcula Comissao Produto Com Aliquota    ${valor_base}    ${aliquota}

        ${valor_bd}    Busca Valor Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${COD_PRODUTO}
        
        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${Total_Comissao_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Produtos}    ${valor_bd}

        Should Be Equal As Numbers    ${valor_bd}    ${Total_Comissao_Produtos}    msg=[PROD__DIF_POR_VEND__COM_ALIQ] Comissão do produto diverge. BD: ${valor_bd} | Calculado: ${Total_Comissao_Produtos}

        Log To Console    [PROD__DIF_POR_VEND__COM_ALIQ] Aliquota: ${aliquota} | Comissão: ${Total_Comissao_Produtos}

    ELSE IF    '${cenario}' == 'PROD__DIF_POR_VEND__SEM_ALIQ'

        ${valor_bd}    Busca Valor Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${COD_PRODUTO}

        Should Be Equal As Numbers    ${valor_bd}    0    msg=[PROD__DIF_POR_VEND__SEM_ALIQ] Comissão deveria ser 0, mas encontrou ${valor_bd}.

        ${Total_Comissao_Produtos}    Set Variable    ${0}

        Log To Console    [PROD__DIF_POR_VEND__SEM_ALIQ] cpv.Aliquota = 0 → Comissão: 0 (registro com valor 0)

    ELSE IF    '${cenario}' == 'PROD__MISTA__COM_ALIQ'

        Verifica Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquota}    Consulta alíquotas produto por vendedor    ${Codigo_Vendedor}    ${COD_PRODUTO}

        IF    $aliquota is None
            Fail    [PROD__MISTA__COM_ALIQ] Vendedor ${Codigo_Vendedor} deveria ter registro em cpv para produto ${COD_PRODUTO}.
        END

        ${Total_Comissao_Produtos}    Calcula Comissao Produto Com Aliquota    ${valor_base}    ${aliquota}

        ${valor_bd}    Busca Valor Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${COD_PRODUTO}
        
        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${Total_Comissao_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Produtos}    ${valor_bd}

        Should Be Equal As Numbers    ${valor_bd}    ${Total_Comissao_Produtos}    msg=[PROD__MISTA__COM_ALIQ] Comissão do produto diverge. BD: ${valor_bd} | Calculado: ${Total_Comissao_Produtos}

        Log To Console    [PROD__MISTA__COM_ALIQ] cpv.Aliquota DIFERENCIADA: ${aliquota} | Comissão: ${Total_Comissao_Produtos}

    ELSE IF    '${cenario}' == 'PROD__MISTA__COM_ALIQ_ZERO'

        ${valor_bd}    Busca Valor Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${COD_PRODUTO}

        Should Be Equal As Numbers    ${valor_bd}    0    msg=[PROD__MISTA__COM_ALIQ_ZERO] Comissão deveria ser 0, mas encontrou ${valor_bd}.

        ${Total_Comissao_Produtos}    Set Variable    ${0}

        Log To Console    [PROD__MISTA__COM_ALIQ_ZERO] cpv.Aliquota = 0 → Comissão: 0 (registro com valor 0, NÃO aparece no grid)

    ELSE IF    '${cenario}' == 'PROD__MISTA__SEM_REG_CPLV'

        Verifica Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${Codigo_Vendedor}    deve_gerar=${True}

        ${aliquota_geral}    Consulta alíquota geral produto    ${COD_PRODUTO}

        ${Total_Comissao_Produtos}    Calcula Comissao Produto Com Aliquota    ${valor_base}    ${aliquota_geral}

        ${valor_bd}    Busca Valor Comissão Produto Gerada    ${CODIGO_OPERACAO_MOV}    ${COD_PRODUTO}
        
        # Valida se há diferença de um centavo entre o valor do BD/ERP e o valor calculado pela automação. Se houver diferença, retorna o valor esperado (BD/ERP).
        ${Total_Comissao_Produtos}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao_Produtos}    ${valor_bd}

        Should Be Equal As Numbers    ${valor_bd}    ${Total_Comissao_Produtos}    msg=[PROD__MISTA__SEM_REG_CPLV] Comissão do produto diverge. BD: ${valor_bd} | Calculado: ${Total_Comissao_Produtos}

        Log To Console    [PROD__MISTA__SEM_REG_CPLV] SEM cpv → Aliquota Geral: ${aliquota_geral} | Comissão: ${Total_Comissao_Produtos}

    ELSE

        Fail    Cenário '${cenario}' não reconhecido para tipo '${tipo_linha}' em validação de produto.

    END

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

E gero o relatório de comissões

    Press Combination    KEY.ALT    KEY.O
    
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${LABEL_GERANDO_RELATORIO_AGUARDE}    ${TEMPO_TELA}

    Valida os dados do relatório de comissões