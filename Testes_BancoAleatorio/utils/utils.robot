*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Library    Collections

Resource    ./validacaoAviso.robot
*** Variables ***
# Sleep's    
${SLEEP_BAIXO}                             0.7
${SLEEP_MEDIO}                             1.5
${SLEEP_ALTO}                              3
${TEMPO_TELA}                              20

# Telas
${TELA_RECB_DUPLICATAS}                    tela_RecebimentoDuplicatas.png
${TELA_IMPRESSAO}                          tela_Impressao.png
${TELA_SOLICITACAO_SENHA_USUARIO}          tela_SolicitaSenha.png
${TELA_OBSERVACAO_PRODUTO}                 tela_ObservacaoProduto.png
${TELA_SELECIONA_TIPO_ENTREGA}             tela_SelecionaEntrega.png
${TELA_SOLICITACAO_CREDITO}                tela_SolicitaLiberacaoCredito.png
${TELA_CONTROLE_CRÉDITO}                   tela_ControleDeCredito.png
${TELA_CONFIRMA_LIBERACAO_CREDITO}         tela_ConfirmaLiberacao.png
${TELA_DETALHAMENTO_SERVIÇO}               tela_DetalhamentoServico.png
${TELA_FUNCIONARIO_COMISSIONADO}           modal_FuncionarioComissionadoServico.png
${TELA_PERSONALIZACAO_PAGAMENTO}           modal_PersonalizacaoPagamento.png
${TELA_RECEBIMENTO_CARTAO}                 tela_RecebimentoCartaoCreditoDebito.png
${TELA_MOVIMENTACAO_CONTA_CORRENTE}        tela_MovimentacaoContaCorrente.png
${TELA_CONS_FINAL}                         tela_cons_final.png
${TELA_TRANSP_FAT_NF}                      tela_TranspFatNotaFiscal.png
${MODAL_LOCAL_NEGOCIACAO}                  tela_LocalNegociacao.png
${TELA_CONDICIONAIS}                       tela_Condicionais.png
${TELA_DEVOLUÇÕES}                         tela_Devolucoes.png
${TELA_ORCAMENTO}                          tela_Orcamento.png
${TELA_ORDEM_DE_SERVICO}                   tela_OrdemDeServico.png
${TELA_VENDAS}                             tela_VendasDeBalcao.png
${TELA_PEDIDOS}                            tela_Pedidos.png
${TELA_CONTAS_A_PAGAR_AVULSA}              tela_CadastroContasAPagar.png
${TELA_NOTA_FISCAL_MANUAL}                 tela_NotaFiscalPreenchimentoManual.png
${TELA_COMISSOES}                          tela_Comissoes.png
${CAIXA_PRINCIPAL}                         tela_CaixaPrinicipal.png
${TELA_LIBERACAO_DESCONTO_MAXIMO}          tela_liberacaoDesconto.png
${MODAL_CANCELAR_VENDA}                    modal_SenhaDoSupervisor.png

# Telas Avisos
${AVISO_SEM_ESTOQUE}                       aviso_QuantidadeSemEstoque.png
${AVISO_JA_INCLUIU_PRODUTO_NO_GRID}        aviso_JaIncluiuProdutoNoGrid.png
${AVISO_USAR_ESSE_VENDEDOR}                aviso_UsarEsseVendedor.png
${AVISO_EST_INSUFICIENTE_CONTINUAR}        aviso_EstoqueInsuficienteContinuar.png
${AVISO_PRODUTO_JA_INCLUSO}                aviso_ProdutoJaIncluso.png

# Botões
${BT_CONFIRMA_CANAL_NEGOCIACAO}            bt_ConfirmarCanal.png
${BT_SOLICITAR_CRÉDITO}                    bt_SolicitarCredito.png
${BT_OK_LIBERACAO_CRÉDITO}                 bt_OkLiberacaoCredito.png
${BT_SETA_DIREITA}                         bt_SetaDireita.png
${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}        bt_IncluirProdutoNFeSaidaManual.png

# Inputs
${INPUT_COD_CLIENTE}                       lb_CodCliente.png
${INPUT_COD_CLIENTE_VENDA}                 lb_CodClienteVenda.png
${INPUT_COD_CLIENTE_ORDEM_DE_SERVICO}      lb_CodClienteOS.png
${INPUT_COD_CLIENTE_CONDICIONAL}           lb_CodClienteCondicional.png
${INPUT_CODIGO_CLIENTE_DEVOLUCAO}          lb_CodClienteDevolucao.png
${INPUT_COD_BENEFICIADO_DOACAO}            lb_CodBeneficiadoDoacao.png
${INPUT_COD_CLIENTE_NFE_SAIDA_MANUAL}      input_CodCliente.png

# Labels
${LABEL_AVISO_CREDITO_LIBERADO}            lb_CreditoLiberado.png
${LABEL_AVISO_CREDITO_LIBERADO2}           lb_CreditoLiberado2.png
${LABEL_REF_PRODUTO}                       label_RefProduto.png

# Rows
${ROW_PROD_INCLUSO}                        row_ProdIncluso.png
${ROW_FUNCIONARIO_INCLUSO_SERVICO_OS}      row_FuncComissionadoInclusoServicoOS.png

# Outros
${CORRIGE_FOCO}                            corrigeFoco.png
${Teste_Comissao_Linha_Servico}            ${False}
${Vendedor_Selecionada_Escalonada}         ${False}
${Valores_Parcelas}                        ${None}
${AJUSTE_FOCO}                             bt_SetaUltimaVenda.png
${AJUSTE_FOCO_DEVOLUCAO}                   ajusteFocoDevolucao.png
${QUANTIDADE_PRODUTOS}                     1
${POSICAO_PARCELA}                         ${None}
${Teste_Comissao_Escalonada}               ${False}
${Teste_Comissao_Total_Venda}              ${False}
${Teste_Comissao_Linha}                    ${False}
${Teste_Comissao_Forma_Parcelamento}       ${False}
${PercentualComissaoTotalVenda_Servico}    ${None}
${OS_Vendedor_E_Tecnico_Diferentes}        ${False}

*** Keywords ***
Finalização com recebimento de duplicatas(${VALOR_FINAL_OPERAÇÃO})

    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}

    IF    ${Valores_Parcelas} is not None

        Input Text    ${EMPTY}    ${Valores_Parcelas[${POSICAO_PARCELA}]}
        
    ELSE
    
        Input Text    ${EMPTY}    ${VALOR_FINAL_OPERAÇÃO}

    END
    Sleep    ${SLEEP_MEDIO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.C

Finalização com recebimento de cartão de crédito/débito
    
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_CARTAO}    ${TEMPO_TELA}

    Press Special Key    ENTER

    Input Text    ${EMPTY}    1

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    1

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Press Combination    KEY.ALT     Key.S

    Wait Until Screen Not Contain    ${TELA_RECEBIMENTO_CARTAO}    ${TEMPO_TELA}

Finalização com o tipo bancaria 
    
    Wait Until Screen Contain    ${TELA_MOVIMENTACAO_CONTA_CORRENTE}    ${TEMPO_TELA}

    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT     Key.G

Personalização de Pagamentos
    
    ${msg}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

    IF    ${msg}

        FOR    ${I}    IN RANGE    3

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
        
        END

        Press Combination    KEY.ALT     Key.G
        Sleep    ${SLEEP_BAIXO}
        
    END

Adicionar Vendedor e Cliente(${TELA})

    IF    '${TELA}' != 'NFeSaidasManual'

        IF    '${Vendedor_Selecionada_Escalonada}' != 'True'

            Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${False}
            Sleep    ${SLEEP_BAIXO}

            ${codVendedor}    Seleciona vendedor

            Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

            # Valida se o teste será de comissão.
            Valida teste de comissão

        END

        Valida vendedor padrao

        Input Text    ${EMPTY}    ${Codigo_Vendedor}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        Verifica seleção de tabela de preço(${TELA})
        
    END

    ${codCliente}    Seleciona cliente
    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    IF    '${TELA}' == 'Orcamento'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE}
        
    ELSE IF     '${TELA}' == 'Venda'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}

    ELSE IF     '${TELA}' == 'OrdemDeServico'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_ORDEM_DE_SERVICO}
        Sleep    ${SLEEP_MEDIO}

    ELSE IF     '${TELA}' == 'Condicional'
        
        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_CONDICIONAL}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE IF     '${TELA}' == 'Devolução'
        
        SikuliLibrary.Double Click    ${INPUT_CODIGO_CLIENTE_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}

    ELSE IF     '${TELA}' == 'Pedido'

        SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE IF    '${TELA}' == 'Doação'

        SikuliLibrary.Click    ${INPUT_COD_BENEFICIADO_DOACAO}
        Sleep    ${SLEEP_BAIXO}

    ELSE IF    '${TELA}' == 'NFeSaidasManual'

        SikuliLibrary.Click    ${INPUT_COD_CLIENTE_NFE_SAIDA_MANUAL}
        Sleep    ${SLEEP_BAIXO}

    END
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}
    
    Altera para vendedor vinculado ao cliente

    # Reaproveitando a tela que está para validar apenas na inserção de produto que precisa de estoque o estoque em Pedidos.
    Set Test Variable    ${TELA}

    ${Forma_Padrao_Cliente}    valida_Forma_Parcelamento_Cliente    ${Codigo_Cliente}

    IF    '${Forma_Padrao_Cliente}' != 'False'
        
        Log To Console    Possui forma padrão no cliente: ${Forma_Padrao_Cliente}

        Set Test Variable    ${FORMA_PADRAO}    ${Forma_Padrao_Cliente}

    END

Seleciona vendedor
    
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codVendedor[0][0]}

Seleciona cliente 
    
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codCliente[0][0]}

Seleciona plano de contas - Débito

    ${Plano_de_Contas}    Query    SELECT ID FROM plano_subcontas WHERE IDConta IN (SELECT ID FROM plano_contas WHERE Tipo = 'D') AND Excluido IS NULL ORDER BY RAND() LIMIT 1;

    RETURN    ${Plano_de_Contas[0][0]}

Seleciona plano de contas - Crédito
    
    ${Plano_de_Contas}    Query    SELECT ID FROM plano_subcontas WHERE IDConta IN (SELECT ID FROM plano_contas WHERE Tipo LIKE 'R') ORDER BY RAND() LIMIT 1;

    RETURN    ${Plano_de_Contas[0][0]}

Seleciona modalidade de cobrança 
    
    ${Modalidade_de_Cobranca}    Query    SELECT Codigo FROM modalidadecb WHERE Cancelado IS NULL ORDER BY RAND() LIMIT 1;

    RETURN    ${Modalidade_de_Cobranca[0][0]}

#Essa Keyword é necessária para que não seja preciso duplicar o código de seleção de vendedor e cliente e nem criar um outro montador de cenário
#Ela simplesmente valida o nome do teste em execução e se for de comissão, irá selecionar um funcionário que seja comissionado 
Valida teste de comissão
        
    ${Test_Comissao}    Run Keyword And Return Status    Should Contain    ${SUITE_NAME}    Comissoes

    ${Teste_Comissao_Escalonada}            Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Escalonada
    ${Teste_Comissao_Total_Venda}           Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Total Venda
    ${Teste_Comissao_Linha}                 Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha
    ${Teste_Comissao_Forma_Parcelamento}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Forma Parcelamento
    ${Teste_Comissao_Servico}               Run Keyword And Return Status    Should Contain    ${TEST_NAME}    serviço

    Set Test Variable    ${Teste_Comissao_Escalonada}
    Set Test Variable    ${Teste_Comissao_Total_Venda}
    Set Test Variable    ${Teste_Comissao_Linha}
    Set Test Variable    ${Teste_Comissao_Forma_Parcelamento}
    Set Test Variable    ${Teste_Comissao_Servico}

    IF    ${Test_Comissao}

        ${Dados_Vendedor}    Query    SELECT ComissaoDiferenciadapor, ComissaoPercentualProdutos, ComissaoServicos, ComissaoPercentualServicos, ComissaoVendaProdutos, Codigo, RazaoSocial FROM clientes WHERE Codigo = ${Codigo_Vendedor}

        ${Tipo_Comissao}    Set Variable    ${Dados_Vendedor[0][0]}

        IF    ${Teste_Comissao_Escalonada}

            # IF    '${Tipo_Comissao[0][0]}' != '1'

            #     Seleciona vendedor comissionado('D')
                
            # END
                       
            # IF    '${Tipo_Comissao[0][0]}' != 'D'

            #     Seleciona vendedor comissionado('D')

            # END

            # Set Test Variable    ${Vendedor_Selecionada_Escalonada}    ${True}

            Log To Console    Comissão escalonada${\n}Selecionar vendedor por tipo D

        ELSE IF    ${Teste_Comissao_Total_Venda}
            
            ${SelecionarVendedor}    Set Variable    ${False}
            
            IF    $Tipo_Comissao != 'T' or ('${Teste_Comissao_Servico}' == 'True' and ${Dados_Vendedor[0][2]} != '1')

                ${SelecionarVendedor}    Set Variable    ${True}

            ELSE

                IF    ${Dados_Vendedor[0][1]} != None and ${Dados_Vendedor[0][1]} > 0

                    Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${Dados_Vendedor[0][1]}

                ELSE

                    ${SelecionarVendedor}    Set Variable    ${True}

                END
                
                IF    ${Teste_Comissao_Servico}

                    IF    ${Dados_Vendedor[0][3]} != None and ${Dados_Vendedor[0][3]} > 0

                        Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

                    ELSE

                        ${SelecionarVendedor}    Set Variable    ${True}

                    END

                END

            END

            IF    ${SelecionarVendedor}

                Seleciona vendedor comissionado('T')

            END

            Log To Console    Comissão sobre total da venda.

        ELSE IF    ${Teste_Comissao_Linha}

            ${SelecionarVendedor}    Set Variable    ${False}

            IF    $Tipo_Comissao != 'L' or '${Dados_Vendedor[0][4]}' != '1'

                ${SelecionarVendedor}    Set Variable    ${True}

            ELSE IF    '${Teste_Comissao_Servico}' == 'True' and (${Dados_Vendedor[0][2]} == None or '${Dados_Vendedor[0][2]}' != '1')

                ${SelecionarVendedor}    Set Variable    ${True}

            END

            IF    ${SelecionarVendedor}

                Seleciona vendedor comissionado('L')

            END

            IF    ${Teste_Comissao_Servico}

                Set Test Variable    ${Teste_Comissao_Linha_Servico}    ${True}
                    
            END

            Log To Console    Comissão por linha.
        
        ELSE IF    ${Teste_Comissao_Forma_Parcelamento}
            
            ${SelecionarVendedor}    Set Variable    ${False}

            # Necessário para os cenários de comissões por forma de parcelamento.
            Set Test Variable    ${FORMA_PRAZO}

            IF    $Tipo_Comissao != 'F' or '${Dados_Vendedor[0][4]}' != '1'

                ${SelecionarVendedor}    Set Variable    ${True}

            END

            IF    ${SelecionarVendedor}

                Seleciona vendedor comissionado('F')

            END
    
            IF    ${FORMA_PRAZO[5]} == 0

                ${FORMA_PRAZO}    validaParametros.Seleciona Forma Prazo Com Comissao
                                
            END

            Set Test Variable    ${PercentualComissaoFormaParcParcela_Produto}    ${FORMA_PRAZO[5]}
            Set Test Variable    ${FORMA_PRAZO}
            Set Test Variable    ${FORMA_PADRAO}    ${FORMA_PRAZO}

            Log To Console    Comissão sobre formas de parcelamento.

        END
    
    END

Seleciona vendedor comissionado(${Tipo_Comissao_Selecionar})

    IF    ${Tipo_Comissao_Selecionar} == 'T'

        IF    ${Teste_Comissao_Servico}

            ${consultaVendedor}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor, ComissaoPercentualServicos FROM clientes WHERE ComissaoServicos = 1 AND ComissaoPercentualServicos > 0 AND ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

            ${vendComissServicoTotalVenda}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

            IF    not ${vendComissServicoTotalVenda}
                
                Fail    Não há cadastro de vendedor comissionado por serviço sobre o total da venda.
                
            END

            ${Dados_Vendedor}    Query    ${consultaVendedor}

            Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

        ELSE

            ${Dados_Vendedor}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' ORDER BY RAND() LIMIT 1;

        END

    ELSE

        IF    ${Teste_Comissao_Servico}

            ${consultaVendedor}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoServicos = 1 AND ComissaoVendaProdutos = 1 ORDER BY RAND() LIMIT 1;

            ${vendComissServico}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedor}

            IF    not ${vendComissServico}

                Fail    Não há cadastro de vendedor comissionado por serviço para o tipo de comissão ${Tipo_Comissao_Selecionar}.
                
            END

            ${Dados_Vendedor}    Query    ${consultaVendedor}

        ELSE
         
            ${Dados_Vendedor}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoVendaProdutos = 1 ORDER BY RAND() LIMIT 1;

        END

    END

    IF    ${Dados_Vendedor} != 'None'
    
        Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${True}
        Set Test Variable    ${Codigo_Vendedor}    ${Dados_Vendedor[0][0]}

        IF    ${Teste_Comissao_Total_Venda}

            Set Test Variable    ${PercentualComissaoTotalVenda_Produto}    ${Dados_Vendedor[0][1]}

        END

    END

Valida vendedor padrao
    
    ${VENDEDOR_PADRAO}    Run Keyword And Return Status    Check If Exists In Database    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente} AND c.CodigoVendedor IS NOT NULL;
    
    IF     ${VENDEDOR_PADRAO}

        ${NOVO_VENDEDOR}    Query    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente};

        Set Test Variable    ${codVendedor}    ${NOVO_VENDEDOR}
    
    END

Inserir serviço

    ${consultaServico}    Set Variable    SELECT codigo, Detalha FROM servicos WHERE STATUS LIKE 'g' AND Ativo = 1 AND Inativo = 0 AND TabelaComissao IS NULL ORDER BY RAND() LIMIT 1;

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.S

    Sleep    ${SLEEP_BAIXO}
    ${codServico}    Query    ${consultaServico}

    Sleep    ${SLEEP_MEDIO}
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    ${consultaServico}

    IF    ${condicao}
    
        Input Text    ${EMPTY}    ${codServico[0][0]}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0
            
            Insere detalhamento no serviço

        END

        Set Test Variable    ${COD_SERVICO}    ${codServico[0][0]} 

    ELSE

        Log To Console    Cliente sem serviços ou serviço inativo, OS sem serviço.
        
    END

Seleciona serviço com linha de comissão

    ${consultaServico}    Set Variable    SELECT s.Codigo, s.Detalha FROM servicos AS s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 and s.TabelaComissao IN (SELECT cl.Codigo FROM comissaoporlinha AS cl WHERE cl.Tipo LIKE 'N' AND cl.Aliquota > 0) ORDER BY RAND() LIMIT 1;
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.S

    Sleep    ${SLEEP_BAIXO}
    ${codServico}    Query    ${consultaServico}

    Sleep    ${SLEEP_MEDIO}
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    ${consultaServico}

    IF    ${condicao}
    
        Input Text    ${EMPTY}    ${codServico[0][0]}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0 
            
            Insere detalhamento no serviço

        END

        Set Test Variable    ${COD_SERVICO}    ${codServico[0][0]} 

    ELSE

        Log To Console    Cliente sem serviços ou serviço inativo, OS sem serviço.
        
    END

Inserir Produto normal - Necessita de estoque

    IF    '${TELA}' == 'NFeSaidasManual'

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_SETA_DIREITA}
        Sleep    ${SLEEP_BAIXO}
        
        Type With Modifiers    P    SHIFT
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

    END

    IF    '${TELA}' == 'Pedido'
        
        ${codProduto}    Query    SELECT p.Codigo AS codigoProduto FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto LEFT JOIN (SELECT CodigoProduto, Empresa, SUM(Quantidade - QtdeGerada) AS QuantidadePendente FROM pedidosvendaprodutos WHERE Cancelada IS NULL AND Quantidade > QtdeGerada GROUP BY CodigoProduto, Empresa) AS pendente ON p.Codigo = pendente.CodigoProduto AND pe.Empresa = pendente.Empresa WHERE p.ModalidadeControle LIKE 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND pe.Estoque > 1 AND pe.Estoque > COALESCE(pendente.QuantidadePendente, 0) ORDER BY RAND() LIMIT 1;

    ELSE

        ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque > 1 WHERE p.ModalidadeControle LIKE 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;
    
    END
    
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

    # IF    ${TesteUtilizaDescontoMaximoProduto}

    #     Altera o desconto máximo do produto
        
    # END

Inserir Produto normal - Permite sem estoque

    IF    '${TELA}' == 'NFeSaidasManual'

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${BT_SETA_DIREITA}
        Sleep    ${SLEEP_BAIXO}
        
        Type With Modifiers    P    SHIFT
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

    END

    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

    # IF    ${TesteUtilizaDescontoMaximoProduto}

    #     Altera o desconto máximo do produto
        
    # END
    
Inserir produto pré-definido(${Produto})
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Produto} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

Valida parametros após incluir produto 
    
    IF     ${Parametro_Permite_Varias_Tabelas}

        Valida tabela de preco

    END

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    IF     ${Parametro_ExigeSenhaMultiplo}
    
        Valida solicitação de senha do usuário supervisor
    
    END

    IF    ${Parametro_IncluiDireto} != ${True}
        
        IF    '${TELA}' == 'NFeSaidasManual'
            
            SikuliLibrary.Click    ${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}
            Sleep    ${SLEEP_BAIXO}

        ELSE

            Press Combination    KEY.ALT    Key.I
            Sleep    ${SLEEP_BAIXO}
            
        END

        Valida produto já incluso

    END

    IF    ${Parametro_RealizaVendaSemEstoque}

        ${avisoProdEstoqueInsuficiente}    Exists    ${AVISO_EST_INSUFICIENTE_CONTINUAR}

       IF    ${avisoProdEstoqueInsuficiente}
           
            Press Combination    KEY.ALT    KEY.S
            Sleep    ${SLEEP_BAIXO}

       END
        
    END

    Valida a inserção do mesmo produto várias vezes no grid

    IF    ${Aviso_ProdutoSemEstoque}
        
        Aviso produto sem estoque 

    END

    Verifica observacao do produto 

    IF    ${Parametro_BloqueiaOrcamentoSemEstoque}
        
        validacaoAviso.Valida aviso de quantidade não existente em estoque - Orçamento

        IF    ${AVISO_SEM_ESTOQUE}

            Inserir Produto normal - Necessita de estoque
            Valida parametros após incluir produto

        END
    END

    IF    ${Parametro_Controla_Entrega}

        Valida controle de entrega

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

Valida local da negociação

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${MODAL_LOCAL_NEGOCIACAO} 

    IF    ${MSG}  
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN

        SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}

    END

Valida impressao direta de venda(${Parametro})
    
    IF    ${Parametro}
        
        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_BAIXO}

    END

Valida solicitação de senha do usuário supervisor

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Verifica observacao do produto 
    
    ${ObservaçãoProduto}    Run Keyword And Return Status    Check If Exists In Database    SELECT ObservaVenda FROM produtos WHERE Codigo = ${COD_PRODUTO} AND ObservaVenda <> 0 AND ObservaVenda IS NOT NULL

    IF    ${ObservaçãoProduto}
        
        Sleep    ${SLEEP_ALTO}
        ${MSG}    Exists    ${TELA_OBSERVACAO_PRODUTO}

        IF    ${MSG}  
            
            Input Text    ${EMPTY}    Obs Produto Teste

            Press Combination    KEY.ALT     Key.O
            Sleep    ${SLEEP_MEDIO}

        END

    END

Valida controle de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TIPO_ENTREGA}

    IF    ${MSG}  
        
        Input Text    ${EMPTY}    S
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT     Key.G
        Sleep    ${SLEEP_MEDIO}

    END

Aviso produto sem estoque 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Verifica vendedor com senha

    ${VendedorComSenha} =     Run Keyword And Return Status     Check If Exists In Database    SELECT SenhaVendedor FROM clientes WHERE Codigo = ${Codigo_Vendedor} AND SenhaVendedor IS NOT NULL AND SenhaVendedor NOT LIKE ''
    
    Set Test Variable    ${VendedorPossuiSenha}    ${False}

    IF    ${VendedorComSenha}
        
        Execute Sql String    UPDATE clientes SET SenhaVendedor = 'W' WHERE Codigo = ${Codigo_Vendedor}
        Set Test Variable    ${VendedorPossuiSenha}    ${True}

    ELSE

        Set Test Variable    ${VendedorPossuiSenha}    ${False}

    END

Valida Controle de Credito - Liberação(${VALOR_FINAL})

    ${VALOR_CREDITO}    Query    SELECT ValorCredito FROM clientes WHERE Codigo = ${Codigo_Cliente}

    IF    ${VALOR_FINAL} > ${VALOR_CREDITO[0][0]}
        
        SikuliLibrary.Click    ${CORRIGE_FOCO}

        Sleep    ${SLEEP_BAIXO}
        ${MSG}    Exists    ${TELA_SOLICITACAO_CREDITO}

        IF    ${MSG}  
            
            SikuliLibrary.Click    ${BT_SOLICITAR_CRÉDITO}
            Wait Until Screen Contain    ${TELA_CONTROLE_CRÉDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

            Press Combination    KEY.ALT    Key.L
            Wait Until Screen Contain    ${TELA_CONFIRMA_LIBERACAO_CREDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}

            Press Combination    KEY.ALT    Key.o
            
            #Valida o status = Liberado e a label Crédito liberado, por que na OS não existe o status = Liberado
            ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${LABEL_AVISO_CREDITO_LIBERADO}    ${SLEEP_ALTO}
            ${MSG2}    Run Keyword And Return Status    Wait Until Screen Contain    ${LABEL_AVISO_CREDITO_LIBERADO2}    ${SLEEP_ALTO}

            IF    ${MSG} or ${MSG2}
                
                Sleep    ${SLEEP_MEDIO}
                Press Combination    KEY.ALT    Key.o
                
                #Correção temporária até a correção da tarefa: 144920
                SikuliLibrary.Click    ${BT_OK_LIBERACAO_CRÉDITO}
                Sleep    ${SLEEP_MEDIO}

                Press Combination    KEY.ALT    Key.F
                Sleep    ${SLEEP_BAIXO}

            END 

        END

    END

Insere detalhamento no serviço
    
    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVIÇO}    ${SLEEP_ALTO}

    IF    ${MSG}
        
        Input Text    ${EMPTY}    Detalhamento de Servico - Teste de Automacao
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.C 
        Sleep    ${SLEEP_BAIXO}

    END

Exclui ordem de entrega(${COD_OPERACAO})
    
    Execute Sql String    DELETE FROM produtos_entregues WHERE IDEntrega = (SELECT ID FROM entregas WHERE CodigoVenda = ${COD_OPERACAO});
    Execute Sql String    DELETE FROM entregas WHERE CodigoVenda = ${COD_OPERACAO};

Cancela venda com senha 
    
    #${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${MODAL_CANCELAR_VENDA}    ${SLEEP_ALTO}
    #Sistema não reconhece a imagem do modal de jeito nenhum, então deixei dessa maneira, já que se estiver com o parametro marcado irá aparecer de certeza

    Sleep    ${SLEEP_ALTO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.O
    Sleep    ${SLEEP_BAIXO}

Seleciona produto com linha cadastrada(${Paremtro_Operação_Sem_Estoque})
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    IF     ${Paremtro_Operação_Sem_Estoque}

        ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 AND CodigoComissao IN (SELECT Codigo FROM comissaoporlinha WHERE Tipo LIKE 'N' AND Aliquota > 0) ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_MEDIO}

    ELSE
        
        IF    '${TELA}' == 'Pedido'
            
            ${codProduto}    Query    SELECT p.Codigo AS codigoProduto FROM produtos AS p INNER JOIN produtosestoque AS pe ON pe.CodigoProduto = p.Codigo WHERE pe.Estoque > 1 AND p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND COALESCE((SELECT SUM(pvp.Quantidade - pvp.QtdeGerada) FROM pedidosvendaprodutos AS pvp WHERE pvp.CodigoProduto = p.Codigo AND pvp.Cancelada IS NULL), 0) < pe.Estoque AND p.CodigoComissao IN (SELECT cpl.Codigo FROM comissaoporlinha AS cpl WHERE cpl.Tipo = 'N' AND cpl.Aliquota > 0) ORDER BY RAND() LIMIT 1;
    
        ELSE

            ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque > 1 WHERE p.ModalidadeControle LIKE 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND p.CodigoComissao IN (SELECT Codigo FROM comissaoporlinha WHERE Tipo LIKE 'N' AND Aliquota > 0) ORDER BY RAND() LIMIT 1;
        
        END

    END
    
    Input Text    ${EMPTY}    ${codProduto[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

Pesquisa comissões por escalonamento
    
    ${Descontos_Comissoes}    Query    SELECT Ate, Comissao FROM comissao_escalonadaprod LIMIT 2

    RETURN    ${Descontos_Comissoes}

Valida a inserção do mesmo produto várias vezes no grid

    ${AVISO}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_JA_INCLUIU_PRODUTO_NO_GRID}    ${SLEEP_ALTO}

    IF    ${AVISO}
        
        Press Combination    KEY.Alt    KEY.s

    END

Valida tela de transportadora/faturamento nota fiscal

    ${TELA_TRANSP}    Exists    ${TELA_TRANSP_FAT_NF}

    IF    ${TELA_TRANSP}
        
        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_BAIXO}

    END

Verifica seleção de tabela de preço(${TELA})
    
    Sleep    ${SLEEP_MEDIO}
    ${tabelaPadrao}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT * FROM tabelas AS t WHERE t.Cancelada IS NULL AND t.Padrao = 1;

    Sleep    ${SLEEP_MEDIO}
    ${tabelaVendedor}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT * FROM tabelas_vendedores tb WHERE tb.idVendedor = ${Codigo_Vendedor} AND tb.MyCommerce = 1 AND tb.Excluido = 0;

    # Validação por conta que, nas telas 'OrdemDeServico', 'Condicional', 'Devolução' e 'Doação' ao informar o vendedor, o sistema não seleciona no combobox a primeira tabela de preço 
    # da listagem, conforme ocorre nas outras telas, quando o cenário das sql's acima.
    IF    '${TELA}' == 'OrdemDeServico' or '${TELA}' == 'Condicional' or '${TELA}' == 'Devolução' or '${TELA}' == 'Doação'

        Sleep    ${SLEEP_BAIXO}
        Run Keyword If    ${tabelaPadrao} or ${tabelaVendedor}    Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}

    END

Altera para vendedor vinculado ao cliente

    ${vendedorPadrao}    Exists    ${AVISO_USAR_ESSE_VENDEDOR}

    IF    ${vendedorPadrao}

        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

    END

Quando informo um produto normal

    ${Codigos_Produtos}    Create List
    ${numeroDeProdutos}    Evaluate    random.randint(1, 3)

    Set Global Variable    ${valorTotalNota}    0

    FOR    ${I}    IN RANGE    ${numeroDeProdutos}
        
        Selecionar produto

        Valida parametros após incluir produto

        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Produtos}
    
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${numeroDeProdutos}
    
Selecionar produto

    ${campoRefProd}    Exists    ${LABEL_REF_PRODUTO}

    IF    '${TELA}' == 'NFeSaidasManual'

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

        IF    ${campoRefProd}
            
            SikuliLibrary.Click    ${BT_SETA_DIREITA}
            Sleep    ${SLEEP_BAIXO}

        END

        Type With Modifiers    P    SHIFT
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}

    END

    ${produto}    Query    SELECT Codigo, VendaT1 FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${produto[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${produto[0][0]}
    
    ${qtdeProduto}    Evaluate    random.randint(1, 3)

    Input Text    ${EMPTY}    ${qtdeProduto}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${valorUnitario}    Set Variable    ${produto[0][1]}
    
    ${valorTotalProduto}    Evaluate    ${qtdeProduto} * ${valorUnitario}

    ${valorTotalNota}    Evaluate    (${valorTotalProduto} + ${valorTotalNota})

    Set Global Variable    ${valorTotalNota}
    
    Set Test Variable    ${VALOR_TOTAL}    ${valorTotalNota}

Valida quantidade de empresas

    ${qtdeEmpresa}    Query    SELECT COUNT(*) FROM empresas e WHERE e.`Status` = 'ATIVA' AND e.Ativo = 1;

    RETURN    ${qtdeEmpresa[0][0]}

Desativa avisos de inicialização nas permissões de usuário
    
    Execute Sql String    UPDATE usuarios AS u SET u.MenuInicializacao = 0, u.Avisos_menu = 0, u.AvisoChequeCompensar = 0, u.AvisoChequesCompensarVencidos = 0, u.ContaAvisoTodas = 0, u.AvisoCortes = 0, u.Crm_Notify = 0, u.prod_EstAviso = 0, u.AvisoNcmCest = 0, u.Entrega_Aviso = 0, u.AvisoVendaAberta = 0, u.AvisoProdutosLoteValidade = 0, u.AvisoAniversariantes = 0, u.AvisoClienteSemCompra = 0, u.ContaAviso = 0, u.AvisoNFCPendente = 0 WHERE u.UserName = 'Visual';
    
    Sleep    ${SLEEP_BAIXO}

    Execute Sql String    UPDATE usuarios_auxiliar AS uax JOIN usuarios AS u ON u.Codigo = uax.uau_codigo_usuario SET uax.uau_avisa_ferias = 0, uax.Uau_Cons_Avisos_Manutencoes_Inicializar = 0, uax.Uau_Cons_Avisos_TransfRecusadas_Inicializar = 0, uax.Uau_Avisos_Cotacao_Moeda = 0, uax.Uau_Importa_Produtos = 0 WHERE u.UserName = 'Visual';

E saio da tela(${TELA})

    IF    '${TELA}' == 'Condicional'
            
        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}
    
    ELSE IF    '${TELA}' == 'Devolução'
        
        SikuliLibrary.Click    ${AJUSTE_FOCO_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Orçamento'

        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'OrdemDeServico'

        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Venda'
        
        SikuliLibrary.Double Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Pedido'
        
        SikuliLibrary.Click    ${TELA_PEDIDOS}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'ContasAPagar'

        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${TELA_CONTAS_A_PAGAR_AVULSA}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'nfManual'

        Press Special Key    ESC
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Press Special Key    ESC
        Wait Until Screen Not Contain    ${TELA_NOTA_FISCAL_MANUAL}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'Comissoes'
        
        SikuliLibrary.Click    ${TELA_COMISSOES}

        Press Combination    KEY.ALT    KEY.F
        Wait Until Screen Not Contain    ${TELA_COMISSOES}    ${TEMPO_TELA}

    ELSE IF    '${TELA}' == 'CaixaPrincipal'
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.S
        Wait Until Screen Not Contain    ${CAIXA_PRINCIPAL}    ${TEMPO_TELA}

    END

Valida teste que utiliza o desconto máximo do produto

    ${TesteUtilizaDescontoMaximoProduto}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    desconto máximo do produto

    IF    ${TesteUtilizaDescontoMaximoProduto}

        Altera o desconto máximo do produto
        
    END
    
    Set Test Variable    ${TesteUtilizaDescontoMaximoProduto}

Altera o desconto máximo do produto

    Execute Sql String    UPDATE produtos p SET p.DescontoMaximo = 10 WHERE p.Codigo = ${COD_PRODUTO}

Valida solicitação de senha do usuário supervisor para liberação de desconto

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Seleciona uma forma de parcelamento personalizável

    ${formaParc}    Query    SELECT fp.Descricao FROM formaparcelamento fp WHERE fp.Personalizavel = 1 AND fp.Cancelado IS NULL LIMIT 1

    RETURN    ${formaParc[0][0]}

Remove os grids personalizados de simulação de parcelas

    Execute Sql String    DELETE FROM usuariogridflex WHERE FormName = 'frmSimulacaodeParcelas';

Remove os grids personalizados do caixa

    Execute Sql String    DELETE FROM usuariogridflex WHERE FormName = 'frmCaixa';

Verifica regime tributário da empresa

    ${regimeTributario}    Query    SELECT e.Codigo, e.RegimeFiscalSimples, e.TipoLucro, e.AliquotaISS FROM empresas e WHERE e.Codigo = (SELECT ua.ua_empresa FROM usuario_acesso AS ua WHERE ua.ua_data = CURDATE() ORDER BY ua.ua_id DESC LIMIT 1);

    RETURN    ${regimeTributario}

Seleciona técnico executor comissionado diferente do vendedor da OS(${Tipo_Comissao_Selecionar})

    IF    ${Tipo_Comissao_Selecionar} == 'T'

        ${consultaVendedorTecnicoServico}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor, ComissaoPercentualServicos FROM clientes WHERE ComissaoServicos = 1 AND ComissaoPercentualServicos > 0 AND ComissaoVendaProdutos = 1 AND ComissaoPercentualProdutos > 0 AND Tipo IN ('D','V') AND Ativo = -1 AND Status = 'ATIVA' AND Tecnico = 1 AND clientes.Codigo <> ${Codigo_Vendedor} ORDER BY RAND() LIMIT 1;

        ${tecnicoComissServicoTotalVenda}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedorTecnicoServico}

        IF    not ${tecnicoComissServicoTotalVenda}
                
            Fail    Nenhum vendedor técnico executor, diferente do vendedor da OS, possui comissão por serviço sobre o total da venda.
                
        END

        ${Dados_Vendedor}    Query    ${consultaVendedorTecnicoServico}

        #Set Test Variable    ${PercentualComissaoTotalVenda_Servico_TecnicoExec}    ${Dados_Vendedor[0][3]}
        Set Test Variable    ${PercentualComissaoTotalVenda_Servico}    ${Dados_Vendedor[0][3]}

    ELSE

        ${consultaVendedorTecnicoServico}    Set Variable    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE Tipo IN ('D','V') AND ComissaoDiferenciadapor = ${Tipo_Comissao_Selecionar} AND Ativo = -1 AND Status = 'ATIVA' AND ComissaoServicos = 1 AND ComissaoVendaProdutos = 1 AND Tecnico = 1 AND clientes.Codigo <> ${Codigo_Vendedor} ORDER BY RAND() LIMIT 1;

        ${tecnicoComissServico}    Run Keyword And Return Status    Check If Exists In Database    ${consultaVendedorTecnicoServico}

        IF    not ${tecnicoComissServico}

            Fail    Não foi encontrado vendedor técnico executor, diferente do vendedor da OS, com comissão por serviço para o tipo de comissão ${Tipo_Comissao_Selecionar}.
            
        END

        ${Dados_Vendedor}    Query    ${consultaVendedorTecnicoServico}

    END

    IF    ${Dados_Vendedor} != 'None'

        Set Test Variable    ${Codigo_Tecnico_Servico}    ${Dados_Vendedor[0][0]}

    END

Validação após incluir serviço

    FOR    ${i}    IN RANGE    2

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    IF    not ${Parametro_IncluiDireto}
            
        Press Combination    KEY.ALT    KEY.N

    END

Insere funcionários comissionados por serviço

    Wait Until Screen Contain    ${TELA_FUNCIONARIO_COMISSIONADO}    ${TEMPO_TELA}

    IF    ${Parametro_Seleciona_Funcionario_Comissao_Servico}
            
        Press Special Key    DOWN

    ELSE
            
        IF    ${OS_Vendedor_E_Tecnico_Diferentes}

            Input Text    ${EMPTY}    ${Codigo_Tecnico_Servico}
            
        ELSE

            Input Text    ${EMPTY}    ${Codigo_Vendedor}

        END
                
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

    Press Combination    KEY.ALT    KEY.I
    Wait Until Screen Contain    ${ROW_FUNCIONARIO_INCLUSO_SERVICO_OS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Valida o abatimento dos tributos no valor do serviço

Valida o abatimento dos tributos no valor do serviço

    ${aliqISSEmpresa}            Evaluate    0
    ${Total_Tributos_Servico}    Evaluate    0

    IF    not ${Parametro_NaoDeduzirISSQNComissaoOS}

        ${regimeTributarioEmp}    Verifica regime tributário da empresa
        
        ${aliqISSEmpresa}         Set Variable    ${regimeTributarioEmp[0][3]}

        IF    '${regimeTributarioEmp[0][1]}' == '1'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis, 0) + COALESCE(sae.AliqCofins, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};

        ELSE IF    '${regimeTributarioEmp[0][2]}' == 'LP'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis_presumido, 0) + COALESCE(sae.AliqCofins_presumido, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};

        ELSE IF    '${regimeTributarioEmp[0][2]}' == 'LR'

            ${aliqPisCofins}    Query    SELECT SUM(COALESCE(sae.AliqPis_real, 0) + COALESCE(sae.AliqCofins_real, 0)) FROM servico_aliquota_empresa sae WHERE sae.CodigoServico = ${COD_SERVICO};
        END

        ${Total_Tributos_Servico}    Evaluate    ${aliqISSEmpresa} + ${aliqPisCofins[0][0]}

    END

    Set Test Variable    ${Total_Tributos_Servico}