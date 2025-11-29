*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot

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
${TEMPO_TELA}                            20

# Telas
${TELA_ORDEM_DE_SERVICO}                 tela_OrdemDeServico.png
${TELA_ADICIONAR_ORDEM_DE_SERVICO}       tela_OrdemDeServicoAdicionar.png
${TELA_FATURAMENTO_OS}                   modal_OpcoesDeFaturamento.png
${TELA_IMPRIME_CARNE_OS}                 tela_ImprimeCarneOS.png
${TELA_VISUALIZA_VENDA}                  tela_VisualizaVenda.png
${TELA_EXCLUIR_PAGAMENTOS}               aviso_ExcluirPagOS.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${TELA_SIMULADOR_FORMA_PACELAMENTO}      tela_SimuladorFormaParcelamento.png
${TELA_CHECKLIST}                        tela_CheckList.png
${TELA_NFS-E}                            tela_NFSe.png
${TELA_OPCOES_FATURAMENTO}               tela_OpcoesFaturamento.png

# Telas Avisos
${AVISO_NFSE_REJEITADA}                  aviso_NFSeRejeitada.png
${AVISO_NFSE_COM_PROBLEMA}               aviso_NFSeComProblema.png
${AVISO_NFSE_PROCESSAMENTO}              aviso_NFSeProcessamento.png
${RETORNO_NFS}                           retornoNFS.png

# Botões
${BT_EXCLUIR_PAGAMENTOS}                 bt_ExcluirPag.png
${BT_SIMULADOR_FORMAS_PARCELAMENTO}      tela_SimulacaoRecebimentos.png

# Inputs
${INPUT_QUANTIDADE_PRODUTO}              input_QuantidadeProduto.png

# Labels
${LABEL_DESCRIÇÃO}                       lb_Descricao.png
${LABEL_AGUARDE_GERANDO_NFSE}            lb_AguardeGerandoNFSe.png
${LABEL_EMITIR_BOLETOS}                  lb_EmitirBoletos.png

# Rows
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png

# Outros
${FORMA_RECEBIMENTO_OUTROS}              Outros...
${Quantidade_Produto}                    ${1}
${OS_PossuiProduto}                      ${False}
${OS_PossuiServico}                      ${False}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de ordens de serviços
    
    ${FORMA_PADRAO}    Valida Configuracoes OS
    ${FORMA_PRAZO}     Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO} 

    Verifica parâmetros que interferem na venda

    Press Special Key    F3

    Valida lançamento de ordem de serviço em aberto

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar

    Press Combination    KEY.ALT    KEY.A
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    IF    ${Parametro_Local_Negociacao} 

        Valida local da negociação

    END

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END
    
    Sleep    ${SLEEP_MEDIO}
    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_ORDEM_SERVICO}    ${Consulta[0][0]}

E adiciono vendedor e cliente
    
    utils.Adicionar Vendedor e Cliente(OrdemDeServico)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando insiro um serviço
    
    IF    ${SelecionaServicoComLinha}

        utils.Seleciona servico com linha de comissao

    ELSE

        utils.Inserir serviço

    END

    Set Test Variable    ${OS_PossuiServico}    ${True}

E insiro um produto normal informando a quantidade(${Quantidade_Produto})
    
    IF     ${Parametro_VendaSemEstoqueOrdemDeServico}
        
        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END
    
    Informa a quantidade do produto(${Quantidade_Produto})

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
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento fim de semana(${FORMA_PADRAO[4]})

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto 

    END

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.F

    Valida check list

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'

        IF    ${Parametro_ControlaCredito}

            Press Special Key    TAB 
            Sleep    ${SLEEP_BAIXO}
            
            Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})

            IF    ${VendedorPossuiSenha}
        
                Valida solicitação de senha do usuário supervisor

            END

        END

    END

    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    IF    ${VendedorPossuiSenha}
        
        Valida solicitação de senha do usuário supervisor

    END

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'
        
        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Finalização com recebimento de duplicatas(${VALOR_FINAL_OS})

            END

        END

    END

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_ORDEM_SERVICO}

    Extrair dados da ordem de serviço gerada

Então visualizo a ordem de serviço
    
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${SLEEP_ALTO}

Quando clico em editar
    
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_BAIXO}

    validacaoAviso.Valida edição de ordem de serviço finalizada

    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}

E excluo os pagamentos lançados

    validacaoAviso.Valida cliente com vales compra disponíveis
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    SikuliLibrary.Click    ${BT_EXCLUIR_PAGAMENTOS}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PAGAMENTOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.S
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

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto

    END

    Valida vencimento fim de semana(${FORMA_PADRAO[4]})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.F

    IF    ${Parametro_ControlaCredito}
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}

        Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})

        IF    ${VendedorPossuiSenha}
        
            Valida solicitação de senha do usuário supervisor

        END

    END


    # Comentado aqui porque pode ser que, quando a forma de pagamento for à vista, ela apareça antes das duplicatas, mas ainda é necessário validar esse comportamento.
    IF    ${VendedorPossuiSenha}
        
        Valida solicitação de senha do usuário supervisor

    END

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_ORDEM_SERVICO}

Então clico em excluir

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.X
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitação de senha do usuário supervisor

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Exclusao de OS - Teste Automacao

    Press Special Key    TAB

    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    # Sleep    ${SLEEP_MEDIO}
    
    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_ORDEM_SERVICO} AND `Status` LIKE 'x'

Calcula valor final da OS
    
    ${somaValorTotalProdutos}    Evaluate    0

    IF    ${OS_PossuiProduto}

        ${OS_Produtos}     Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO} ORDER BY vp.Sequencia;
        
        ${qtdeProdutos}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};

        ${QUANTIDADE_PRODUTOS}    Set Variable    ${qtdeProdutos[0][0]}

        FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

            ${Produto_ValorUnitario}    Set Variable    ${OS_Produtos[${i}][1]}
            Log To Console    Produto_ValorUnitario: ${Produto_ValorUnitario}

            ${Produto_ValorTotal}       Set Variable    ${OS_Produtos[${i}][2]}
            Log To Console    Produto_ValorTotal: ${Produto_ValorTotal}
            
            ${calcValorTotalProduto}    Evaluate    round((${Quantidade_Produto} * ${Produto_ValorUnitario}), 2)
            Log To Console    calcValorTotalProduto: ${calcValorTotalProduto}

            Should Be Equal    ${Produto_ValorTotal}    ${calcValorTotalProduto}
            
            ${somaValorTotalProdutos}    Evaluate    (${somaValorTotalProdutos} + ${calcValorTotalProduto})
            Log To Console    somaValorTotalProdutos: ${somaValorTotalProdutos}
        
        END
    
    END
    
    ${somaValorTotalServicos}    Evaluate    0

    IF    ${OS_PossuiServico}

        ${OS_Servicos}     Query    SELECT vs.CodigoServico, vs.ValorUnitario, vs.ValorTotal FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO} ORDER BY vs.Sequencia;
        
        ${qtdeServicos}    Query    SELECT COUNT(*) FROM vendasservicos vs WHERE vs.CodigoVenda = ${COD_ORDEM_SERVICO};

        FOR    ${i}    IN RANGE    ${qtdeServicos[0][0]}
            
            ${Servico_ValorUnitario}    Set Variable    ${OS_Servicos[${i}][1]}
            Log To Console    Servico_ValorUnitario: ${Servico_ValorUnitario}

            ${Servico_ValorTotal}    Set Variable    ${OS_Servicos[${i}][2]}
            Log To Console    Servico_ValorTotal: ${Servico_ValorTotal}

            ${calcValorTotalServico}    Evaluate    round((1 * ${Servico_ValorUnitario}), 2)   # Tratar para a automação poder inseir quantidade do serviço e então usar aqui no cálculo. 
            Log To Console    calcValorTotalServico: ${calcValorTotalServico}

            Should Be Equal    ${Servico_ValorTotal}    ${calcValorTotalServico}

            ${somaValorTotalServicos}    Evaluate    (${somaValorTotalServicos} + ${calcValorTotalServico})
            Log To Console    somaValorTotalServicos: ${somaValorTotalServicos}
            
        END

    END

    ${calcValorTotalOS}    Evaluate    round((${somaValorTotalProdutos} + ${somaValorTotalServicos}), 2)
    Log To Console    calcValorTotalOS: ${calcValorTotalOS}

    ${ValorTotalOS}    Query    SELECT ROUND(IFNULL((SELECT SUM(vp.ValorTotal) FROM vendasprodutos vp WHERE vp.CodigoVenda = v.Codigo),0) + IFNULL((SELECT SUM(vs.ValorTotal) FROM vendasservicos vs WHERE vs.CodigoVenda = v.Codigo),0), 2) AS TotalGeral FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO};
    Log To Console    ValorTotalOS: ${ValorTotalOS[0][0]}

    Should Be Equal    ${calcValorTotalOS}    ${ValorTotalOS[0][0]}

    Set Test Variable    ${Valor_Total_Servicos_OS}    ${somaValorTotalServicos}
    Set Test Variable    ${Valor_Total_Produtos_OS}    ${somaValorTotalProdutos}

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
        Press Combination    KEY.ALT     Key.F 

    END

Valida impressao carne OS 

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRIME_CARNE_OS}    ${TEMPO_TELA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.N

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
                    
                    Input Text    ${EMPTY}    Descricao de automacao em check list
                    Sleep    ${SLEEP_BAIXO}

                END

            END

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

        Press Combination    KEY.ALT     Key.G
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
    Wait Until Screen Contain    ${LABEL_AGUARDE_GERANDO_NFSE}    ${SLEEP_ALTO}

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

    IF    ${Quantidade_Produto} != 1
        
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}