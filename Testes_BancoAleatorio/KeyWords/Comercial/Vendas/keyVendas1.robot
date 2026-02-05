*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/estoque.py
Library    Process
Library    Collections
Library    String
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                               ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                                ${config.IpServidor}
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root

# Sleep's
${SLEEP_BAIXO}                           0.7
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            25

# Telas
${TELA_INFO_CRÉDITOS}                    tela_InfoCreditos.png
${TELA_ALTERAR_NUMERO}                   aviso_DesejaAlterarNumero.png
${TELA_VENDAS}                           tela_VendasDeBalcao.png
${TELA_VENDAS_ADICIONAR}                 tela_VendaBalcaoAdicionar.png
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_EMISSAO_NFC}                      tela_EmissaoNFC.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_EMISSAO_NFC}                      tela_EmissaoNFC.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${TELA_VENDAS_ANTERIORES}                tela_ExibeAnteriores.png
${TELA_EXIBE_CLIENTE}                    tela_exibeCliente.png
${TELA_SELECIONA_TIPO_ENTREGA}           tela_SelecionaEntrega.png
${TELA_RECIBO_ENTRADA}                   tela_ReciboEntrada.png
${TELA_CONTRATO_VENDA}                   tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}              tela_EmisssaoPromissoria.png
${TELA_RECIBO_ENTRADA}                   tela_ReciboEntrada.png
${TELA_CONTRATO_VENDA}                   tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}              tela_EmisssaoPromissoria.png
${TELA_VISUALIZA_VENDA}                  tela_VisualizaVenda.png
${TELA_EXCLUIR_PAGAMENTOS}               aviso_ExcluirPag.png
${TELA_SIMULADOR_FORMA_PACELAMENTO}      tela_SimuladorFormaParcelamento.png
${TELA_OBSERVACAO_PRODUTO}               tela_ObservacaoProduto.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${MODAL_PERSONALIZACAO_PAGAMENTO}        modal_PersonalizacaoPagamento.png

# Telas Avisos
${AVISO_USAR_ESSE_VENDEDOR}              aviso_clienteOutroVendedor.png
${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}      aviso_ExigeSenhaVendedorDiferente.png
${AVISO_CONDICIONAL_ABERTO_VISUALIZA}    aviso_CondicionalEmAbertoVisualizar.png
${AVISO_NCM_INVALIDO}                    aviso_NCMInvalidoNFC.png
${AVISO_LIMITE_CRÉDITO_DESATUALIZADO}    aviso_ClienteLimiteCreditoDesatualizado.png
${ALERTA_CLIENTE}                        alertaCliente.png

# Botões
${BT_OK}                                 bt_Ok.png
${BT_EXCLUIR_PAGAMENTOS}                 bt_ExcluirPag.png
${BT_SIMULADOR_FORMAS_PARCELAMENTO}      tela_SimulacaoRecebimentos.png
${BT_ADICIONAR}                          bt_Adicionar.png
${BT_EDITAR}                             bt_Editar.png

# Inputs
${INPUT_VALOR_FINAL_VENDA}               inp_ValorDuplicatas.png
${INPUT_QUANTIDADE_PRODUTO}              input_QuantidadeProduto.png

# Labels
${LABEL_DESCRIÇÃO}                       lb_Descricao.png
${LABEL_DESCONTO_FINAL_VENDA}            lb_DescontoFinalVenda.png
${LABEL_FOCO_DESCONTO_FINAL_VENDA}       lb_FocoDescontoFinalVenda.png
${LABEL_QUANT_PARCELAS}                  lb_QuatParcelasPagPersonalizada.png
${LABEL_CRITERIO_CODIGO_VENDA}           label_CriterioCodigo_Venda.png
${LABEL_CODIGO_GRID}                     lb_Codigo_Grid.png
${LABEL_REGISTRO_ENCONTRADO}             lb_RegistroEncontrado.png

# Rows
${ROW_PROD_INCLUSO}                      row_ProdIncluso.png
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png

# Outros
${FORMA_RECEBIMENTO_OUTROS}              Outros...
${ERRO_FATURAR_NFC}                      erro_faturarNFC.png
${COMBOBOX_FORMA_RECEBIMENTO}            cb_FormaRecebimento.png
${Codigos_Produtos}                      ${None}
${AJUSTE_FOCO}                           bt_SetaUltimaVenda.png
${Quantidade_Produto}                    0
${QUANTIDADE_PRODUTOS}                   ${1}
${QTDE_BAIXA_PRODUTO}                    ${1}
${Desconto_Produto}                      ${None}
${List_Quantidades_Produto}              ${None}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Verifica formas de recebimento da venda

    ${FORMA_PADRAO}    validaParametros.Valida Configuracoes Venda
    ${FORMA_PRAZO}     validaParametros.Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO}

Dado que acesso a tela de vendas de balcão

    Verifica formas de recebimento da venda

    Press Special Key    F2

    Valida lançamento de venda em aberto

    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

Quando pressiono o atalho de adicionar

    SikuliLibrary.Click    ${BT_ADICIONAR}
    Sleep    ${SLEEP_BAIXO}

    Valida indicação de venda(${Parametro_IndicacaoVenda})

    Valida local de negociação da venda

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    
    Sleep    ${SLEEP_ALTO}

    Última venda feita/em aberto
    
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    # Seta a lista de produtos como None para dar certo em ambos os casos (venda com mais de um produto e com apenas 1 produto)
    Set Test Variable    ${Codigos_Produtos}

Última venda feita/em aberto

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

E adiciono vendedor e cliente

    utils.Adicionar Vendedor e Cliente(Venda)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando insiro mais de um produto normal(${QuantidadeDeProduto})

    ${Quantidade_Produto}    Set Variable    ${Parametro_QuantidadePadraoVenda}
    
    ${Codigos_Produtos}    Create List

    FOR    ${I}    IN RANGE    ${QuantidadeDeProduto}

        Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Produtos}
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QuantidadeDeProduto}

Informa a quantidade do produto(${Quantidade_Produto})

    IF    ${Quantidade_Produto} != ${Parametro_QuantidadePadraoVenda}
        
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

E acesso a aba pagamentos

    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT    Key.M

    Valida cliente com vales compra disponíveis

    Sleep    ${SLEEP_ALTO}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}
    
    ${EntradaIgualA_Outros}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto

    END

Então finalizo a venda

    Última venda feita/em aberto

    Verifica vendedor com senha

    Calcula valor final da venda

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

    Valida parâmetros/impressões pós venda

    # Para forçar o foco do sistema manter na tela de vendas, em cenários em que há mais de uma tela aberta.
    SikuliLibrary.Click    ${TELA_VENDAS}

    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

    keyVendas1.Valida baixa de estoque

Então finalizo a venda - Desconto(${PERCENT_DESCONTO})

    SikuliLibrary.Double Click    ${LABEL_DESCONTO_FINAL_VENDA}
    Wait Until Screen Contain    ${LABEL_FOCO_DESCONTO_FINAL_VENDA}    ${SLEEP_ALTO}

    Input Text    ${EMPTY}    ${PERCENT_DESCONTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    Verifica desconto ultrapassou o cadastro dos itens(${PERCENT_DESCONTO})

    Última venda feita/em aberto

    Verifica vendedor com senha

    Calcula valor final da venda com desconto(${PERCENT_DESCONTO})

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

    Valida desconto que não se encaixa em nenhuma escala de comissão

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

    Valida parâmetros/impressões pós venda

    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    keyVendas1.Valida baixa de estoque

Então visualizo a venda

    Dado que acesso a tela de vendas de balcão

    Press Combination    KEY.ALT     Key.V
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

E acesso a aba pagamentos - A Prazo

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M
    Sleep    ${SLEEP_ALTO}

Então finalizo a venda - A Prazo

    Verifica vendedor com senha

    Calcula valor final da venda
    
    # Essa validação é necessária, pois caso há grids personalizados, não funciona a pesquisa da forma de parcelamento pela sua descrição.
    utils.Remove os grids personalizados de simulação de parcelas
    
    SikuliLibrary.Click    ${BT_SIMULADOR_FORMAS_PARCELAMENTO}
    Wait Until Screen Contain    ${TELA_SIMULADOR_FORMA_PACELAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LABEL_DESCRIÇÃO}
    Sleep    ${SLEEP_BAIXO}

    ${FORMA_PRAZO}    Convert To String    ${FORMA_PRAZO}
    Type    ${EMPTY}    ${FORMA_PRAZO}

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

    Press Combination    KEY.AL    KEY.F

    IF    ${Parametro_ControlaCreditoVenda}

        Valida Controle de Credito - Liberação(${VALOR_FINAL_VENDA})

        Valida solicitação de senha do usuário supervisor

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    Valida solicitação de senha do usuário supervisor

    Valida parâmetros/impressões pós venda

    keyVendas1.Valida baixa de estoque

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_VENDA}

Quando clico em editar

    utils.Exclui ordem de entrega(${COD_VENDA})

    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_EDITAR}
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitação de senha do usuário supervisor

    Valida indicação de venda(${Parametro_IndicacaoVenda})

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}     ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E excluo os pagamentos lançados

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.M
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    SikuliLibrary.Click    ${BT_EXCLUIR_PAGAMENTOS}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PAGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

Então clico em excluir

    utils.Exclui ordem de entrega(${COD_VENDA})

    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.X
    Sleep    ${SLEEP_BAIXO}

    Valida solicitação de senha do usuário supervisor

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Type    ${EMPTY}    Exclusao de Venda - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER

    Wait Until Screen Not Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${venda_excluida}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_VENDA} AND Status = 'x' AND Cancelada = 1
    
    Should Be True    ${venda_excluida}    Venda não foi excluída corretamente.

Valida ncm invalido ao faturar nota

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_NCM_INVALIDO}

    IF    ${MSG}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_MEDIO}

        Log To Console    \n Script cancelou o faturamento por conter produtos com NCM inválido!\n

    END

Valida erro ao faturar NFC

    Sleep    ${SLEEP_BAIXO}
    ${ERRO}    Exists    ${ERRO_FATURAR_NFC}

    IF     ${ERRO}

        SikuliLibrary.Click    ${BT_OK}
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_MEDIO}

        Log To Console    \n Script cancelou o faturamento por conter erro!\n

    END

Calcula valor final da venda
    
    ${somaValorTotalProdutos}    Evaluate    0

    Sleep    ${SLEEP_MEDIO}
    ${consultaVendasProdutos}    Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA} ORDER BY vp.Sequencia;

    ${consultaQtdeProdutos}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA};

    ${QUANTIDADE_PRODUTOS}    Set Variable    ${consultaQtdeProdutos[0][0]}

    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

        IF    ${List_Quantidades_Produto} is not None

            ${Quantidade_Produto}    Set Variable    ${List_Quantidades_Produto[${i}]}
            
        END

        ${ProdutoValorUnitario}    Set Variable    ${consultaVendasProdutos[${i}][1]}
        ${ProdutoValorTotal}       Set Variable    ${consultaVendasProdutos[${i}][2]}
        
        ${calcValorTotalProduto}    Evaluate    round((${Quantidade_Produto} * ${ProdutoValorUnitario}), 2)

        Should Be Equal    ${ProdutoValorTotal}    ${calcValorTotalProduto}
        
        ${somaValorTotalProdutos}    Evaluate    round((${somaValorTotalProdutos} + ${calcValorTotalProduto}), 2)
        
    END
    
    Sleep    ${SLEEP_BAIXO}
    ${ValorTotalProdutosVenda}    Query    SELECT ROUND(SUM(ValorTotal), 2) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA}
    
    Should Be Equal    ${ValorTotalProdutosVenda[0][0]}    ${somaValorTotalProdutos}
    
    Set Test Variable    ${VALOR_FINAL_VENDA}    ${ValorTotalProdutosVenda[0][0]}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO[0][1]}    ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA}    Create List    ${COD_VENDA}    ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA_DEVOLUÇÃO}    Create List    ${DADOS_VENDA}

    Set Test Variable    ${Valor_Total_Produtos}    ${ValorTotalProdutosVenda[0][0]}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_VENDA}

Calcula valor final da venda com desconto(${PERCENT_DESCONTO})
    
    Sleep    ${SLEEP_MEDIO}
    ${ValorTotalProdutos}    Query    SELECT SUM(ValorTotal) FROM vendasprodutos WHERE CodigoVenda = ${CODIGO_OPERACAO_MOV}

    IF    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos}

        ${Valor_Final_Com_Desconto}    Calcula desconto final por produto(${PERCENT_DESCONTO})

    ELSE

        ${Valor_Final_Com_Desconto}    Evaluate    (${ValorTotalProdutos[0][0]} - (${ValorTotalProdutos[0][0]} * (${PERCENT_DESCONTO} / 100)))

    END

    Set Test Variable    ${VALOR_FINAL_VENDA}    ${Valor_Final_Com_Desconto}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO[0][1]}     ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA}    Create List    ${COD_VENDA}    ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA_DEVOLUÇÃO}    Create List    ${DADOS_VENDA}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO}

Calcula desconto final por produto(${PERCENT_DESCONTO})

    IF    ${Codigos_Produtos} is None

        ${Produto}    Query    SELECT p.VendaT1 ,p.DescontoMaximo FROM vendasprodutos AS vp INNER JOIN produtos AS p ON p.Codigo = vp.CodigoProduto WHERE vp.CodigoVenda = ${COD_VENDA} AND vp.CodigoProduto = ${COD_PRODUTO}

        IF    ${PERCENT_DESCONTO} > ${Produto[0][1]}

            ${Valor_Final_Atual}    Evaluate    round((${Produto[0][0]} - (${Produto[0][0]} * (${Produto[0][1]} / 100))),4)

            Log To Console    Desconto ultrapassou o máximo do produto, novo valor final: ${Valor_Final_Atual}

            ${Valor_Final_Atual}    Evaluate    round((${Valor_Final_Atual}),2)

        ELSE

            ${Valor_Final_Atual}    Evaluate    round((${Produto[0][0]} - (${Produto[0][0]} * (${PERCENT_DESCONTO} / 100))),4)

            Log To Console    Desconto está no limite do máximo do produto, novo valor final: ${Valor_Final_Atual}

            ${Valor_Final_Atual}    Evaluate    round((${Valor_Final_Atual}),2)

        END

        RETURN    ${Valor_Final_Atual}

    ELSE

        ${Valor_Final_Atual}    Evaluate    0

        FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}

            ${Produto}     Query    SELECT p.VendaT1 ,p.DescontoMaximo FROM vendasprodutos AS vp INNER JOIN produtos AS p ON p.Codigo = vp.CodigoProduto WHERE vp.CodigoVenda = ${COD_VENDA} AND vp.CodigoProduto = ${Codigos_Produtos[${I}]}

            IF    ${PERCENT_DESCONTO} > ${Produto[0][1]}

                ${Valor_Produto_Desconto}    Evaluate    round((${Produto[0][0]} - (${Produto[0][0]} * (${Produto[0][1]} / 100))),4)
                Log To Console    Desconto ultrapassou o máximo do produto, novo valor final: ${Valor_Produto_Desconto}

                ${Valor_Final_Atual}    Evaluate    ${Valor_Final_Atual} + ${Valor_Produto_Desconto}
                ${Valor_Final_Atual}    Evaluate    round((${Valor_Final_Atual}),2)

            ELSE

                ${Valor_Produto_Desconto}    Evaluate    round((${Produto[0][0]} - (${Produto[0][0]} * (${PERCENT_DESCONTO} / 100))),4)
                Log To Console    Desconto está no limite do máximo do produto, novo valor final: ${Valor_Produto_Desconto}

                ${Valor_Final_Atual}    Evaluate    ${Valor_Final_Atual} + ${Valor_Produto_Desconto}
                ${Valor_Final_Atual}    Evaluate    round((${Valor_Final_Atual}),2)

            END

        END

        RETURN    ${Valor_Final_Atual}

    END

Valida baixa de estoque

    Sleep    ${SLEEP_MEDIO}

    ${Teste_Condicional}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    condicional

    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        IF    ${Codigos_Produtos} is not None

            ${COD_PRODUTO}    Set Variable    ${Codigos_Produtos[${i}]}
            
        END

        IF    ${List_Quantidades_Produto} is not None

            ${QTDE_BAIXA_PRODUTO}    Set Variable    ${List_Quantidades_Produto[${i}]}

        END

        ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${CODIGO_OPERACAO_MOV}    ${QTDE_BAIXA_PRODUTO}

        IF    ${Baixa_De_Estoque}

            Log To Console    Baixou estoque corretamente do produto [${COD_PRODUTO}] na Venda de Balcão!

        ELSE

            IF    ${Teste_Condicional}

                Log To Console    Não baixou estoque na Venda de Balcão! (Correto para os Testes de Condicionais).

            ELSE

                Fail    Falha na baixa do estoque na Venda de Balcão! Verifique!

            END
        END
    END

Verifica desconto ultrapassou o cadastro dos itens(${PERCENT_DESCONTO})

    IF    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos} == False

        IF    ${Codigos_Produtos} is None

            ${Produto}    Query    SELECT p.VendaT1, p.DescontoMaximo FROM vendasprodutos AS vp INNER JOIN produtos AS p ON p.Codigo = vp.CodigoProduto WHERE vp.CodigoVenda = ${COD_VENDA} AND vp.CodigoProduto = ${COD_PRODUTO}

            IF    ${PERCENT_DESCONTO} > ${Produto[0][1]}

                Valida tela de liberação de desconto

            END

        ELSE

            ${Valor_Final_Atual}    Evaluate    0

            FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}

                ${Produto}    Query    SELECT p.VendaT1 ,p.DescontoMaximo FROM vendasprodutos AS vp INNER JOIN produtos AS p ON p.Codigo = vp.CodigoProduto WHERE vp.CodigoVenda = ${COD_VENDA} AND vp.CodigoProduto = ${Codigos_Produtos[${I}]}

                IF    ${PERCENT_DESCONTO} > ${Produto[0][1]}

                    Valida tela de liberação de desconto

                    BREAK

                END

            END

        END

    END

Quando insiro um produto já definido(${Produto})

    IF    ${Teste_Comissao_Linha}

        utils.Seleciona produto com linha cadastrada(${Parametro_RealizaVendaSemEstoque})

    ELSE

        utils.Inserir produto pré-definido(${Produto})

    END

    utils.Valida parametros após incluir produto

Então finalizo a venda personalizada com múltiplas parcelas(${qtdeParcelas})

    ${formaPersonalizada}    utils.Seleciona uma forma de parcelamento personalizável

    Verifica vendedor com senha

    Calcula valor final da venda

    # Essa validação é necessária, pois caso há grids personalizados, não funciona a pesquisa da forma de parcelamento pela sua descrição.
    utils.Remove os grids personalizados de simulação de parcelas

    SikuliLibrary.Click    ${BT_SIMULADOR_FORMAS_PARCELAMENTO}
    Wait Until Screen Contain    ${TELA_SIMULADOR_FORMA_PACELAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LABEL_DESCRIÇÃO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${formaPersonalizada}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${TEMPO_TELA}

    SikuliLibrary.Double Click    ${LABEL_QUANT_PARCELAS}

    Input Text    ${EMPTY}    ${qtdeParcelas}
    Sleep    ${SLEEP_BAIXO}
    
    Press Special Key    TAB

    Press Combination    KEY.ALT    KEY.G
    Wait Until Screen Not Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${TEMPO_TELA}
    Wait Until Screen Not Contain    ${TELA_SIMULADOR_FORMA_PACELAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.D

    # FOR    ${i}    IN RANGE    ${qtdeParcelas}
        
    #     validacaoAviso.Valida data de vencimento em feriados, sábados e domingos para pagamentos a prazo
        
    # END

    Valida vencimento em fins de semana e feriados(${qtdeParcelas})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.F

    IF    ${Parametro_ControlaCreditoVenda}

        Valida Controle de Credito - Liberação(${VALOR_FINAL_VENDA})

        Valida solicitação de senha do usuário supervisor

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    Valida solicitação de senha do usuário supervisor

    Valida parâmetros/impressões pós venda

    keyVendas1.Valida baixa de estoque

    Set Test Variable    ${QTDE_PARCELAS_PAG_PERSONALIZADA}    ${qtdeParcelas}

    Consulta valores das parcelas

    Consulta NDocumento das parcelas

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_VENDA}

Consulta valores das parcelas
    
    ${consulta}    Query    SELECT cr.Valor FROM contasareceber cr WHERE cr.CodigoVenda = ${COD_VENDA} ORDER BY cr.Npagamento;

    ${Valores_Parcelas}    Create List

    FOR    ${i}    IN RANGE    ${QTDE_PARCELAS_PAG_PERSONALIZADA}
        
        Append To List    ${Valores_Parcelas}    ${consulta[${i}][0]}
        
    END

    Set Test Variable    ${Valores_Parcelas}

Consulta NDocumento das parcelas

    ${consulta}    Query    SELECT cr.NDocumento FROM contasareceber cr WHERE cr.CodigoVenda = ${COD_VENDA} ORDER BY cr.Npagamento;
    
    ${N_Documento_Parcelas}    Create List

    FOR    ${i}    IN RANGE    ${QTDE_PARCELAS_PAG_PERSONALIZADA}

        Append To List    ${N_Documento_Parcelas}    ${consulta[${i}][0]}

    END

    Set Test Variable    ${N_Documento_Parcelas}

Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

    IF    ${Teste_Comissao_Linha}

        utils.Seleciona produto com linha cadastrada(${Parametro_RealizaVendaSemEstoque})

    ELSE

        IF     ${Parametro_RealizaVendaSemEstoque}

            utils.Inserir Produto normal - Permite sem estoque

        ELSE

            utils.Inserir Produto normal - Necessita de estoque

        END

    END

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

Quando insiro um produto normal informando a quantidade e desconto
    [Arguments]    ${Quantidade_Produto}    ${Desconto_Produto}

    IF    ${List_Quantidades_Produto} is None

        ${List_Quantidades_Produto}    Create List

        Set Test Variable    ${List_Quantidades_Produto}

    END

    IF    ${Teste_Comissao_Linha}

        utils.Seleciona produto com linha cadastrada(${Parametro_RealizaVendaSemEstoque})

    ELSE

        IF     ${Parametro_RealizaVendaSemEstoque}

            utils.Inserir Produto normal - Permite sem estoque
            
        ELSE

            utils.Inserir Produto normal - Necessita de estoque

        END

    END

    Informa a quantidade e desconto do produto    ${Quantidade_Produto}    ${Desconto_Produto}

    Append To List    ${List_Quantidades_Produto}    ${Quantidade_Produto}

    utils.Valida parametros após incluir produto

    Set Test Variable    ${List_Quantidades_Produto}

Informa a quantidade e desconto do produto
    [Arguments]    ${Quantidade_Produto}    ${Desconto_Produto}

    IF    ${Quantidade_Produto} != 1

        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Input Text    ${EMPTY}    ${Desconto_Produto}
    Press Special Key    TAB
    
    Set Test Variable    ${Quantidade_Produto}


E pesquiso pela venda gerada

    Sleep    ${SLEEP_BAIXO}
    ${criterioCodigo}    Exists    ${LABEL_CRITERIO_CODIGO_VENDA}
    
    IF    not ${criterioCodigo}

        SikuliLibrary.Click    ${LABEL_CODIGO_GRID}
        
    END

    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}
    
    ${codigo_venda}    Convert To String    ${COD_VENDA}

    Type    ${EMPTY}    ${codigo_venda}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER

    Wait Until Screen Contain    ${LABEL_REGISTRO_ENCONTRADO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${LABEL_REGISTRO_ENCONTRADO}