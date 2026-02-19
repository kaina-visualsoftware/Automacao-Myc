*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/validaComissoes.py
Library    ../../../libs/estoque.py
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

# Checkbox
${CHECK_BOX_SELE_TODOS}                           checkBox_Comissao.png
${CHECKBOX_CONTASPAGAR}                           checkBox_ContasPagar.png
${CHECK_BOX_SELE_TODOS_SERVICO}                   checkBox_ComissaoServico.png
${CHECKBOX_COMISSAO_FOCO_GRID}                    checkBox_ComissaoFocoGrid.png
${CHECKBOX_CONTA_FOCO_GRID}                       checkBoxContaFocoGrid.png
${CHECKBOX_CONTA_FOCO_GRID_2}                     checkBox_ComissaoFocoGrid2.png

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

        IF    ${Codigos_Produtos} is None

            Calcula comissão por linha de produto - apenas 1 produto

        ELSE

            Set Test Variable    ${POSIÇÃO_VALOR}    ${0}

            IF    ${Valores_Parcelas} is not None
                
                Set Test Variable    ${Teste_Comissão_Parcelada}    ${True}

                Calcula comissão por linha de produto - por parcela personalizada

            ELSE

                Calcula comissão por linha de produto - múltiplos produtos

            END

        END

    ELSE IF    ${Teste_Comissao_Total_Venda}

        Calcula comissão sobre total venda - Produtos

        ${VALOR_DEVOLUCAO}    Evaluate    (${VALOR_FINAL_OPERAÇÃO} * (-1))

        Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_DEVOLUCAO}
    
    ELSE IF    ${Teste_Comissao_Escalonada}

        Fail    Validar posteriormente comissão escalonada.

    ELSE IF    ${Teste_Comissao_Forma_Parcelamento}

        Calcula comissão sobre forma de parcelamento - Produtos

    END

# Calcula comissão por linha de produto - apenas 1 produto

#     Sleep    ${SLEEP_BAIXO}
#     # ${query_comissaoProduto}    Query    SELECT SUM(v.ValorFinalPagamentos * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${COD_PRODUTO} INNER JOIN vendas AS v ON v.Codigo = ${CODIGO_OPERACAO_MOV}
#     ${query_comissaoProduto}    Query    SELECT vp.ValorUnitario * (cl.Aliquota / 100) AS ValorComissao FROM comissaoporlinha cl INNER JOIN produtos p ON p.CodigoComissao = cl.Codigo INNER JOIN vendasprodutos vp ON vp.CodigoProduto = p.Codigo WHERE p.Codigo = ${COD_PRODUTO} AND vp.CodigoVenda = ${CODIGO_OPERACAO_MOV} AND vp.Cancelada IS NULL;

#     ${comissaoProduto}    Evaluate    ${query_comissaoProduto[0][0]} * ${Quantidade_Produto}

#     # ${Total_Comissao_Produtos}    Evaluate    decimal.Decimal(str(${query_comissaoProduto[0][0]} + ${Total_Comissao_Produtos})).quantize(decimal.Decimal("0.0000"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
#     ${Total_Comissao_Produtos}    Evaluate    decimal.Decimal(str(${comissaoProduto} + ${Total_Comissao_Produtos})).quantize(decimal.Decimal("0.0000"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
#     ${Total_Comissao_Produtos}    Evaluate    decimal.Decimal(str(${Total_Comissao_Produtos})).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     Set Test Variable    ${Total_Comissao_Produtos}
#     Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

#     Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao_Produtos}

Calcula comissão por linha de produto - apenas 1 produto

    ${Total_Comissao_Produtos}    Calcula Comissao Linha Produto Unico
    ...    ${COD_PRODUTO}
    ...    ${CODIGO_OPERACAO_MOV}
    ...    ${Quantidade_Produto}
    ...    ${Total_Comissao_Produtos}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao_Produtos}

# Calcula comissão por linha de produto - por parcela personalizada

#     ${somaComissaoParcela}    Evaluate    0

#     ${qtdeProdutos}    Get Length    ${Codigos_Produtos}

#     FOR    ${I}    IN RANGE    ${qtdeProdutos}

#         ${query_comissaoProduto}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}

#         ${comissaoProduto}    Evaluate    decimal.Decimal(str(${query_comissaoProduto[0][0]})) * decimal.Decimal(str(${Quantidade_Produto}))    modules=decimal

#         # ${somaComissaoParcela}    Evaluate    round((${query_comissaoProduto[0][0]} + ${somaComissaoParcela}), 4)
#         # ${somaComissaoParcela}    Evaluate    (decimal.Decimal(str(${query_comissaoProduto[0][0]})) + decimal.Decimal(str(${somaComissaoParcela}))).quantize(decimal.Decimal("0.0000"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
#         ${somaComissaoParcela}    Evaluate    (decimal.Decimal(str(${comissaoProduto})) + decimal.Decimal(str(${somaComissaoParcela}))).quantize(decimal.Decimal("0.0000"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     END

#     # Vai definir a % de comissão apenas positiva
#     IF    ${Valores_Parcelas[${j}]} > 0

#         # ${PERCENT_COMISSAO}    Evaluate    ((${somaComissaoParcela} / ${DADOS_VENDA_DEVOLUÇÃO[0][1]}) * 100)
#         ${PERCENT_COMISSAO}    Evaluate    decimal.Decimal(str(${somaComissaoParcela})) / decimal.Decimal(str(${DADOS_VENDA_DEVOLUÇÃO[0][1]})) * decimal.Decimal("100")    modules=decimal

#         Set Suite Variable    ${PERCENT_COMISSAO}

#     END
 
#     # ${calcComissaoTotalParcela}    Evaluate    round((${Valores_Parcelas[${j}]} * (${PERCENT_COMISSAO} / 100)), 4)
#     # ${calcComissaoTotalParcela}    Evaluate    round(${calcComissaoTotalParcela}, 2)

#     ${calcComissaoTotalParcela}    Evaluate    (decimal.Decimal(str(${Valores_Parcelas[${j}]})) * (decimal.Decimal(str(${PERCENT_COMISSAO})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     Set Test Variable    ${Total_Comissao_Produtos}    ${calcComissaoTotalParcela}
    
#     ${Total_Comissao}    Evaluate    decimal.Decimal(str(${Total_Comissao})) + decimal.Decimal(str(${Total_Comissao_Produtos}))    modules=decimal

#     Set Test Variable    ${Total_Comissao_Produtos}
#     Set Test Variable    ${Total_Comissao}

#     Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao}

#     ${j}    Evaluate    ${j} + 1
#     Set Test Variable    ${j}

Calcula comissão por linha de produto - por parcela personalizada

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Parcela Personalizada
    ...    ${Codigos_Produtos}
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

# Calcula comissão por linha de produto - múltiplos produtos

#     ${calcComissaoProduto}    Evaluate    0

#     ${qtdeProdutos}    Get Length    ${Codigos_Produtos}

#     FOR    ${I}    IN RANGE    ${qtdeProdutos}

#         ${query_comissaoProduto}    Query    SELECT SUM(p.vendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}

#         # ${comissaoProduto}    Evaluate    ${query_comissaoProduto[0][0]} * ${Quantidade_Produto}
#         ${comissaoProduto}    Evaluate    decimal.Decimal(str(${query_comissaoProduto[0][0]})) * decimal.Decimal(str(${Quantidade_Produto}))    modules=decimal

#         # ${Total_Comissao_Produtos}    Evaluate    round((${query_comissaoProduto[0][0]} + ${Total_Comissao_Produtos}), 4)
#         # ${Total_Comissao_Produtos}    Evaluate    round((${comissaoProduto} + ${Total_Comissao_Produtos}), 4)
#         ${Total_Comissao_Produtos}    Evaluate    (decimal.Decimal(str(${comissaoProduto})) + decimal.Decimal(str(${Total_Comissao_Produtos}))).quantize(decimal.Decimal("0.0000"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     END

#     # Vai definir a % de comissão apenas positiva
#     IF    ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} > 0

#         # ${PERCENT_COMISSAO}    Evaluate    ((${Total_Comissao_Produtos} / ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]}) * 100)
#         ${PERCENT_COMISSAO}    Evaluate    decimal.Decimal(str(${Total_Comissao_Produtos})) / decimal.Decimal(str(${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]})) * decimal.Decimal("100")    modules=decimal

#         Set Suite Variable    ${PERCENT_COMISSAO}

#     END

#     # ${Total_Comissao_Produtos}    Evaluate    round((${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} * (${PERCENT_COMISSAO} / 100)), 4)
#     ${Total_Comissao_Produtos}    Evaluate    (decimal.Decimal(str(${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]})) * (decimal.Decimal(str(${PERCENT_COMISSAO})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
#     # ${Total_Comissao}    Evaluate    round((${Total_Comissao} + ${Total_Comissao_Produtos}), 2)
#     ${Total_Comissao}    Evaluate    (decimal.Decimal(str(${Total_Comissao})) + decimal.Decimal(str(${Total_Comissao_Produtos}))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     Set Test Variable    ${Total_Comissao_Produtos}
#     Set Test Variable    ${Total_Comissao}

Calcula comissão por linha de produto - múltiplos produtos

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Multiplos
    ...    ${Codigos_Produtos}
    ...    ${Quantidade_Produto}
    ...    ${DADOS_VENDA_DEVOLUÇÃO}
    ...    ${POSIÇÃO_VALOR}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}
    Set Suite Variable    ${PERCENT_COMISSAO}

Calcula comissão sobre total venda - Produtos

    ${queryComissaoProdutos}    Query    SELECT ROUND(SUM(vp.ValorComissao), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${CODIGO_OPERACAO_MOV}
    ${queryComissaoProdutos[0][0]}    Evaluate    decimal.Decimal(str(${queryComissaoProdutos[0][0]}))    modules=decimal

    ${calcComissaoProdutos}    Evaluate    (decimal.Decimal(str(${Valor_Total_Produtos})) * (decimal.Decimal(str(${PercentualComissaoTotalVenda_Produto})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

    Should Be Equal As Numbers    ${queryComissaoProdutos[0][0]}    ${calcComissaoProdutos}

    Set Test Variable    ${Total_Comissao_Produtos}    ${calcComissaoProdutos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    Valor final da comissão (Produto): ${Total_Comissao_Produtos}

Calcula comissão sobre forma de parcelamento - Produtos

    ${query_comissaoProduto}    Query    SELECT ROUND(SUM(vp.ValorComissao), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA}

    ${calcComissaoProduto}    Evaluate    (decimal.Decimal(str(${Valor_Total_Produtos})) * (decimal.Decimal(str(${PercentualComissaoFormaParcParcela_Produto})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"))    modules=decimal

    ${query_comissaoProduto[0][0]}    Evaluate    decimal.Decimal(str(${query_comissaoProduto[0][0]}))    modules=decimal

    Should Be Equal    ${query_comissaoProduto[0][0]}    ${calcComissaoProduto}

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

            IF    ${Codigos_Produtos} is None

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

# Calcula comissão por linha de serviço - apenas 1 serviço

#     ${query_comissaoServico}    Query    SELECT SUM((v.TotalServicos - (v.TotalServicos * (${Total_Tributos_Servico} / 100))) * (cl.Aliquota / 100)) FROM comissaoporlinha cl INNER JOIN servicos s ON s.TabelaComissao = cl.Codigo AND s.Codigo = ${COD_SERVICO} INNER JOIN vendas v ON v.Codigo = ${CODIGO_OPERACAO_MOV};

#     # ${Total_Comissao_OS}    Evaluate    round((${query_comissaoServico[0][0]}), 2)
#     ${Total_Comissao_OS}    Evaluate    decimal.Decimal(str(${query_comissaoServico[0][0]})).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal

#     Set Test Variable    ${Total_Comissao_OS}
#     Set Test Variable    ${Total_Comissao}    ${Total_Comissao_OS}
#     Set Test Variable    ${Total_Comissao_Servicos}    ${Total_Comissao_OS}

#     Log To Console    [OS] Valor final da comissão (Linha): ${Total_Comissao_Servicos}

Calcula comissão por linha de serviço - apenas 1 serviço

    ${Total_Comissao_OS}    Calcula Comissao Linha Servico Unico    ${COD_SERVICO}    ${CODIGO_OPERACAO_MOV}    ${Total_Tributos_Servico}
    
    Set Test Variable    ${Total_Comissao_OS}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_OS}
    Set Test Variable    ${Total_Comissao_Servicos}    ${Total_Comissao_OS}

    Log To Console    [OS] Valor final da comissão (Linha): ${Total_Comissao_Servicos}

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

        Should Be Equal As Numbers    ${calcComissaoServicos}    ${query_ComissaoServico[0][0]}
        
    ELSE

        ${calcComissaoServicos}    Evaluate    (decimal.Decimal(str(${Valor_Total_Servicos})) * (decimal.Decimal(str(${PercentualComissaoTotalVenda_Servico})) / decimal.Decimal("100"))).quantize(decimal.Decimal("0.00"), rounding=decimal.ROUND_HALF_UP)    modules=decimal
            
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
    # Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    9

        Press Special Key    RIGHT

    END

    Press Special Key    SPACE

E baixo a comissao recém recebida

    SikuliLibrary.Click    ${BT_BAIXAR}
    Wait Until Screen Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_OK}

    IF    ${Total_Comissao} == 0
        
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

            Press Special Key    ENTER
            
        END

        Wait Until Screen Not Contain    ${TELA_AGENDAMENTO}    ${TEMPO_TELA}

        Valida baixa de comissão

    END

Valida baixa de comissão

    IF    ${Baixa_Eh_Servico}
        
        Sleep    ${SLEEP_BAIXO}

        IF    ${OS_Vendedor_E_Tecnico_Diferentes}

            ${queryComissoesPagas_Servico}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Tecnico_Servico} ORDER BY ID DESC LIMIT 1;

        ELSE

            ${queryComissoesPagas_Servico}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC LIMIT 1;
            
        END

        Should Be Equal As Numbers    ${queryComissoesPagas_Servico[0][1]}    ${Total_Comissao_Servicos}

        Set Test Variable    ${NDoc_Comissao}    ${queryComissoesPagas_Servico[0][0]}

    END

    IF    not ${Baixa_Eh_Servico}

        ${queryComissoesPagas_Produto}    Query    SELECT ID, Total FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC LIMIT 1;

        IF    ${Teste_Comissão_Parcelada}

            ${Total_Comissao}    ${houve_ajuste}    Valida Diferenca De Um Centavo    ${Total_Comissao}    ${queryComissoesPagas_Produto[0][1]}

            IF    ${houve_ajuste}
                Set Test Variable    ${Total_Comissao}

            END

            Should Be Equal As Numbers    ${queryComissoesPagas_Produto[0][1]}    ${Total_Comissao}

        ELSE

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
    Should Be Equal    ${Comissao_Paga_BD}    ${Total_Comissao}

    Check If Exists In Database    SELECT Sequencia, nDocumento, CodigoAbertura, ValorDocumento FROM caixamovimentos WHERE nDocumento = ${NDoc_Comissao}

    # Log To Console    \n\n[OK] Validações concluídas com sucesso!

Então visualizo os detalhes da comissao recem paga

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${GUIA_COMISSOES_PAGAS_AGENDADAS}    ${TEMPO_TELA}

    # Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda
    ${Cod_Com_String}    Convert To String    ${NDoc_Comissao}

    ${Quantidade_de_zeros_esquerda}    Get Length    ${Cod_Com_String}

    ${Quantidade_de_zeros_esquerda}    Evaluate    6 - ${Quantidade_de_zeros_esquerda}

    FOR    ${J}    IN RANGE    ${Quantidade_de_zeros_esquerda}

        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}

    END
    # Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda

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

E gero o relatório de comissões(${tipo})

    Informa o vendedor

    IF    '${tipo}' == 'Agendadas'

        SikuliLibrary.Click    ${RADIOBT_COMISSOES_AGENDADAS}

        Set Test Variable    ${COMISSOES_AGENDADAS}    ${True}
        
    ELSE IF    '${tipo}' == 'Pagas'

        Log To Console    Implementar posteriormente.

        Set Test Variable    ${COMISSOES_PAGAS}    ${True}

    ELSE IF    '${tipo}' == 'Pendentes'

        SikuliLibrary.Click    ${RADIOBT_COMISSOES_PENDENTES}
        
        Set Test Variable    ${COMISSOES_PENDENTES}    ${True}

    END

    Press Combination    KEY.ALT    KEY.O
    
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${LABEL_GERANDO_RELATORIO_AGUARDE}    ${TEMPO_TELA}

    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${RADIOBT_VISUALIZAR_IMPRESSAO}

    Press Combination    KEY.ALT    KEY.G

    Valida os dados do relatório de comissões

    IF    ${Teste_Cenario_Sem_Dados_Exibicao}

        Press Special Key    ENTER

        Log To Console    \n"Sem Dados Para Exibição" conforme esperado no Teste 18.
        
    ELSE IF    ${Teste_Cenario_Sem_Dados_Exibicao_Outras_Mov}

        Verifica se operação gerada não está vinculada a uma comissão pendente

        Log To Console    \nVenda vinculada a uma comissão pendente, conforme esperado no Teste 18.

    ELSE

        Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${TEMPO_TELA} 
        
        Press Special Key    ESC
        Wait Until Screen Not Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${SLEEP_ALTO}

    END

    Wait Until Screen Contain    ${TELA_RELATORIO_COMISSOES}    ${TEMPO_TELA}

    Press Special Key    ESC

    Wait Until Screen Not Contain    ${TELA_RELATORIO_COMISSOES}    ${TEMPO_TELA}

Informa o vendedor

    SikuliLibrary.Click    ${LABEL_COD_VENDEDOR_RELATORIO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB

Valida os dados do relatório de comissões

    IF    ${COMISSOES_PENDENTES}
        
        Validação de comissões pendentes        

    END

Validação de comissões pendentes
    
    Sleep    ${SLEEP_MEDIO}

    ${haDados}    Run Keyword And Return Status    Check If Exists In Database    SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;

    ${consultaRelatorio}    Query    SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} UNION ALL SELECT CAST(TotalPedido AS DECIMAL(15,2)) AS TotalPedido, CAST(ValorTotal AS DECIMAL(15,2)) AS ValorTotal, CAST(TotalServicos AS DECIMAL(15,2)) AS TotalServicos, CAST(ComissaoTotal AS DECIMAL(15,2)) AS ComissaoTotal, CAST(ComissaoTotalServico AS DECIMAL(15,2)) AS ComissaoTotalServico, CAST(TotalServFunc AS DECIMAL(15,2)) AS TotalServFunc, CAST(CalculoComissaoFunc AS DECIMAL(15,4)) AS CalculoComissaoFunc, CAST(vlrTotalProdutos AS DECIMAL(15,2)) AS vlrTotalProdutos, TipoVenda FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} ORDER BY TipoVenda ASC;

    IF    not ${haDados}
        
        Sleep    ${SLEEP_BAIXO}

        ${avisoSemDadosExibicao}    Exists    ${AVISO_SEM_DADOS_PARA_EXIBICAO}
        
        IF    ${avisoSemDadosExibicao}
            
            Set Test Variable    ${Teste_Cenario_Sem_Dados_Exibicao}    ${True}

        ELSE

            ${telaImpressaoRelatorio}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_VISUALIZACAO_IMPRESSAO}    ${SLEEP_ALTO}

            Set Test Variable    ${Teste_Cenario_Sem_Dados_Exibicao_Outras_Mov}    ${True}
            
        END
        
    END

    ${qtdeRegistro}    Query    SELECT COUNT(*) FROM (SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Vendas WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV} UNION ALL SELECT TotalPedido, ValorTotal, TotalServicos, ComissaoTotal, ComissaoTotalServico, TotalServFunc, CalculoComissaoFunc, TipoVenda, vlrTotalProdutos FROM Temp_rel_comissao_VsfCom_Servicos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV}) AS qtdeRegistro;

    FOR    ${i}    IN RANGE    ${qtdeRegistro[0][0]}
        
        ${VALOR_FINAL_OPERAÇÃO}    Evaluate    decimal.Decimal(str(${VALOR_FINAL_OPERAÇÃO}))    modules=decimal

        Should Be Equal As Numbers    ${consultaRelatorio[${i}][0]}    ${VALOR_FINAL_OPERAÇÃO}

        IF    '${consultaRelatorio[${i}][8]}' == 'OS'
        
            Should Be Equal As Numbers    ${consultaRelatorio[${i}][2]}    ${Valor_Total_Servicos}
            Should Be Equal As Numbers    ${consultaRelatorio[${i}][4]}    ${Total_Comissao_Servicos}
            
        END

        IF    '${consultaRelatorio[${i}][8]}' == 'VP'

            Should Be Equal As Numbers    ${consultaRelatorio[${i}][1]}    ${Valor_Total_Produtos}
            Should Be Equal As Numbers    ${consultaRelatorio[${i}][3]}    ${Total_Comissao_Produtos}

        END
        
    END

Verifica se operação gerada não está vinculada a uma comissão pendente

    SikuliLibrary.Click    ${BT_BINOCULO_PESQUISA_RELATORIO}

    Wait Until Screen Contain    ${TELA_PESQUISA_TEXTO_IMPRESSAO}    ${SLEEP_ALTO}
        
    ${codigo_operacao_formatado}    Formata código venda em texto para pesquisa    ${CODIGO_OPERACAO_MOV}

    Type    ${EMPTY}    ${codigo_operacao_formatado}
        
    Press Special Key    ENTER

    Sleep    ${SLEEP_BAIXO}
    ${avisoNaoEncontrouRegistro}    Exists    ${AVISO_PESQUISA_TEXTO_CONCLUIDA}

    IF    ${avisoNaoEncontrouRegistro}

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ESC

    ELSE

        Fail    Comissão da venda consta como pendente no relatório de comissões.

    END

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

    ${Total_Comissao_Produtos}    Calcula Comissao Linha Produto Unico
    ...    ${COD_PRODUTO}
    ...    ${CODIGO_OPERACAO_MOV}
    ...    ${Quantidade_Produto_Venda/Dev}
    ...    ${Total_Comissao_Produtos}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}    ${Total_Comissao_Produtos}

    Log To Console    [VENDA] Valor final da comissão (Linha): ${Total_Comissao_Produtos}

# Não testado ainda, apenas separei das demais operações. 
# VERIFICAR POSTERIORMENTE...
Calcula comissão por linha de produto - múltiplos produtos - Devolução

    Sleep    ${SLEEP_MEDIO}

    ${Total_Comissao_Produtos}    ${Total_Comissao}    ${PERCENT_COMISSAO}    Calcula Comissao Linha Produto Multiplos
    ...    ${Codigos_Produtos}
    ...    ${Quantidade_Produto_Devolucao}
    ...    ${DADOS_VENDA_DEVOLUÇÃO}
    ...    ${POSIÇÃO_VALOR}

    Set Test Variable    ${Total_Comissao_Produtos}
    Set Test Variable    ${Total_Comissao}
    Set Suite Variable    ${PERCENT_COMISSAO}