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
${SLEEP_BAIXO}                           0.7
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20

# Telas
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${TELA_SOLICITACAO_SENHA_USUARIO}        tela_SolicitaSenha.png
${TELA_OBSERVACAO_PRODUTO}               tela_ObservacaoProduto.png
${TELA_SELECIONA_TIPO_ENTREGA}           tela_SelecionaEntrega.png
${TELA_SOLICITACAO_CREDITO}              tela_SolicitaLiberacaoCredito.png
${TELA_CONTROLE_CRÉDITO}                 tela_ControleDeCredito.png
${TELA_CONFIRMA_LIBERACAO_CREDITO}       tela_ConfirmaLiberacao.png
${TELA_DETALHAMENTO_SERVIÇO}             tela_DetalhamentoServico.png
${TELA_FUNCIONARIO_COMISSIONADO}         modal_FuncionarioComissionadoServico.png
${TELA_PERSONALIZACAO_PAGAMENTO}         modal_PersonalizacaoPagamento.png
${TELA_RECEBIMENTO_CARTAO}               tela_RecebimentoCartaoCreditoDebito.png
${TELA_MOVIMENTACAO_CONTA_CORRENTE}      tela_MovimentacaoContaCorrente.png
${TELA_CONS_FINAL}                       tela_cons_final.png
${TELA_TRANSP_FAT_NF}                    tela_TranspFatNotaFiscal.png
${MODAL_LOCAL_NEGOCIACAO}                tela_LocalNegociacao.png

# Telas Avisos
${AVISO_SEM_ESTOQUE}                     aviso_QuantidadeSemEstoque.png
${AVISO_JA_INCLUIU_PRODUTO_NO_GRID}      aviso_JaIncluiuProdutoNoGrid.png
${AVISO_USAR_ESSE_VENDEDOR}              aviso_UsarEsseVendedor.png
${AVISO_EST_INSUFICIENTE_CONTINUAR}      aviso_EstoqueInsuficienteContinuar.png

# Botões
${BT_CONFIRMA_CANAL_NEGOCIACAO}          bt_ConfirmarCanal.png
${BT_SOLICITAR_CRÉDITO}                  bt_SolicitarCredito.png
${BT_OK_LIBERACAO_CRÉDITO}               bt_OkLiberacaoCredito.png
${BT_SETA_DIREITA}                       bt_SetaDireita.png
${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}      bt_IncluirProdutoNFeSaidaManual.png

# Outros
${INPUT_COD_CLIENTE}                     lb_CodCliente.png
${INPUT_COD_CLIENTE_VENDA}               lb_CodClienteVenda.png
${INPUT_COD_CLIENTE_ORDEM_DE_SERVICO}    lb_CodClienteOS.png
${INPUT_COD_CLIENTE_CONDICIONAL}         lb_CodClienteCondicional.png
${INPUT_CODIGO_CLIENTE_DEVOLUCAO}        lb_CodClienteDevolucao.png
${ROW_PROD_INCLUSO}                      row_ProdIncluso.png
${CORRIGE_FOCO}                          corrigeFoco.png
${LABEL_AVISO_CREDITO_LIBERADO}          lb_CreditoLiberado.png
${LABEL_AVISO_CREDITO_LIBERADO2}         lb_CreditoLiberado2.png
${MODAL_CANCELAR_VENDA}                  modal_SenhaDoSupervisor.png
${SelecionaProdutoComLinha}              ${False}
${Vendedor_Selecionada_Escalonada}       ${False}
${INPUT_COD_BENEFICIADO_DOACAO}          lb_CodBeneficiadoDoacao.png
${INPUT_COD_CLIENTE_NFE_SAIDA_MANUAL}    input_CodCliente.png
${LABEL_REF_PRODUTO}                     label_RefProduto.png

*** Keywords ***
Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA})

    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
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

        IF    ${Vendedor_Selecionada_Escalonada} != $True

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

    ${Teste_Comissao_Escalonada}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Escalonada
    ${Teste_Comissao_Total_Venda}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Total Venda
    ${Teste_Comissao_Linha}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Linha
    ${Teste_Comissao_Forma_Parcelamento}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    Forma

    IF    ${Test_Comissao}
        
        ${Tipo_Comissao}    Query    SELECT ComissaoDiferenciadapor, ComissaoPercentualProdutos FROM clientes WHERE Codigo = ${Codigo_Vendedor}

        IF    ${Teste_Comissao_Escalonada}
                       
            IF    '${Tipo_Comissao[0][0]}' != 'D'

                Seleciona vendedor comissionado('D')

            END

            Set Test Variable    ${Vendedor_Selecionada_Escalonada}    ${True}

            Log To Console    Teste sobre comissão escalonada${\n}Selecionar vendedor por tipo D

        ELSE IF    ${Teste_Comissao_Total_Venda}           
        
            IF    '${Tipo_Comissao[0][1]}' != 'None' and '${Tipo_Comissao[0][1]}' > '0.0'
                    
                Set Test Variable    ${PercentualComissao}    ${Tipo_Comissao[0][1]}

            ELSE
                    
                Seleciona vendedor comissionado('T')

            END

            Log To Console    Comissao por total de vendas

        ELSE IF    ${Teste_Comissao_Linha}

            IF     '${Tipo_Comissao[0][0]}' != 'L'
                
                Seleciona vendedor comissionado('L')

            END

            Set Test Variable    ${SelecionaProdutoComLinha}    ${True}

            Log To Console    Comissao por linha
        
        ELSE IF    ${Teste_Comissao_Forma_Parcelamento}

            IF     '${Tipo_Comissao[0][0]}' != 'F'

                Seleciona vendedor comissionado('F')

            END

            Log To Console    Comissao do tipo sobre forma de parcelamento - SEM CASOS DE TESTE POR ENQUANTO


        END
    
    END

Seleciona vendedor comissionado(${Tipo_Selecionar})

    IF    ${Tipo_Selecionar} == 'T'

        ${codVendedor_Comissionado}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND (ComissaoPercentualProdutos > 0) AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;

    ELSE

        ${codVendedor_Comissionado}    Query    SELECT codigo, ComissaoPercentualProdutos, ComissaoDiferenciadapor FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND (ComissaoDiferenciadapor LIKE ${Tipo_Selecionar}) AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;

    END

    IF    ${codVendedor_Comissionado} != 'None'
        
        Set Test Variable    ${Codigo_Vendedor}    ${codVendedor_Comissionado[0][0]}

        Set Test Variable    ${PercentualComissao}    ${codVendedor_Comissionado[0][1]}

        Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${True}

        Log To Console    Código do vendedor comissionado: ${Codigo_Vendedor}\n Tipo de comissão: ${Tipo_Selecionar}

        IF    '${codVendedor_Comissionado[0][2]}' == 'L'

            Set Test Variable    ${SelecionaProdutoComLinha}    ${True}

        END

    END

Valida vendedor padrao
    
    ${VENDEDOR_PADRAO}    Run Keyword And Return Status    Check If Exists In Database    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente} AND c.CodigoVendedor IS NOT NULL;
    
    IF     ${VENDEDOR_PADRAO}

        ${NOVO_VENDEDOR}    Query    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente};

        Set Test Variable    ${codVendedor}    ${NOVO_VENDEDOR}
    
    END

Inserir serviço 

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    ${codServico}    Query    SELECT codigo, Detalha FROM servicos WHERE STATUS LIKE 'g' AND Ativo = 1 AND Inativo = 0 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    SELECT codigo, Detalha FROM servicos WHERE STATUS LIKE 'g' AND Ativo = 1 AND Inativo = 0 ORDER BY RAND() LIMIT 1;

    IF    ${condicao}
    
        Input Text    ${EMPTY}    ${codServico[0][0]} 
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0 
            
            Insere detalhamento no serviço

        END

        IF    ${Parametro_IncluiDireto} != ${True}
            
            Press Combination    KEY.ALT     Key.n
            Sleep    ${SLEEP_BAIXO}

        END

        Wait Until Screen Contain    ${TELA_FUNCIONARIO_COMISSIONADO}    ${SLEEP_ALTO}

        IF    ${Parametro_Seleciona_Funcionario_Comissao_Servico}
            
            Press Special Key    DOWN

            #Validação temporária pra ver se precisa informar horas
            Press Special Key    TAB
            Input Text    ${EMPTY}    1
            
        ELSE
            
            Input Text    ${EMPTY}    ${Codigo_Vendedor}

        END

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    key.I
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT     key.S
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

        Set Test Variable    ${COD_SERVICO}    ${codServico[0][0]} 

    ELSE

        Log To Console    Cliente sem serviços ou serviço inativo, OS sem serviço.
        
    END

Seleciona servico com linha de comissao
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    ${codServico}    Query    SELECT codigo, Detalha FROM servicos s WHERE STATUS LIKE 'g' AND Ativo = 1 AND Inativo = 0 and s.TabelaComissao in (select Codigo from comissaoporlinha where Tipo like 'N' and Aliquota > 0)ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    
    ${condicao}    Run Keyword And Return Status    Check If Exists In Database    SELECT codigo, Detalha FROM servicos WHERE STATUS LIKE 'g' AND Ativo = 1 AND Inativo = 0 ORDER BY RAND() LIMIT 1;

    IF    ${condicao}
    
        Input Text    ${EMPTY}    ${codServico[0][0]} 
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        IF    ${codServico[0][1]} > 0 
            
            Insere detalhamento no serviço

        END

        IF    ${Parametro_IncluiDireto} != ${True}
            
            Press Combination    KEY.ALT     Key.n
            Sleep    ${SLEEP_BAIXO}

        END

        Wait Until Screen Contain    ${TELA_FUNCIONARIO_COMISSIONADO}    ${SLEEP_ALTO}

        IF    ${Parametro_Seleciona_Funcionario_Comissao_Servico}
            
            Press Special Key    DOWN

            #Validação temporária pra ver se precisa informar horas
            Press Special Key    TAB
            Input Text    ${EMPTY}    1
            
        ELSE
            
            Input Text    ${EMPTY}    ${Codigo_Vendedor}

        END

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    key.I
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT     key.S
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

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
    
        Valida solicitacao de senha do usuário
    
    END

    IF    ${Parametro_IncluiDireto} != ${True}
        
        IF    '${TELA}' == 'NFeSaidasManual'
            
            SikuliLibrary.Click    ${BT_INCLUIR_PROD_NFE_SAIDA_MANUAL}
            Sleep    ${SLEEP_BAIXO}

        ELSE

            Press Combination    KEY.ALT     Key.I
            Sleep    ${SLEEP_BAIXO}
            
        END

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

Valida solicitacao de senha do usuário

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

        Press Combination    KEY.ALT     Key.C 
        Sleep    ${SLEEP_BAIXO}

    END

Exclui ordem de entrega(${COD_OPERACAO})
    
    Execute Sql String    DELETE FROM produtos_entregues WHERE IDEntrega = (SELECT ID FROM entregas WHERE CodigoVenda = ${COD_OPERACAO});
    Execute Sql String    DELETE FROM entregas WHERE CodigoVenda = ${COD_OPERACAO};
    # Log To Console    Apagou a ordem de entrega(Velha) e produtos entregues da operação de Código: ${COD_OPERACAO}

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
        
            ${codProduto}    Query    SELECT p.Codigo AS codigoProduto FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto AND pe.Estoque > 1 WHERE p.ModalidadeControle LIKE 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND (SELECT SUM(Quantidade - QtdeGerada) AS QuantidadeEmPedidos FROM pedidosvendaprodutos WHERE CodigoProduto = codigoProduto AND Cancelada IS NULL) < pe.Estoque AND p.CodigoComissao IN (SELECT Codigo FROM comissaoporlinha WHERE Tipo LIKE 'N' AND Aliquota > 0) ORDER BY RAND() LIMIT 1;
    
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

    ${vendedorPadrao} =    Exists    ${AVISO_USAR_ESSE_VENDEDOR}

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