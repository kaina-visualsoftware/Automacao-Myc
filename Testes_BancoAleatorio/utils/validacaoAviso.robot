*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

Resource    ../utils/utils.robot

*** Variables ***
# Telas
${TELA_INFO_CRÉDITOS}                                  tela_InfoCreditos.png
${TELA_SENHA_SUPERVISOR}                               tela_SolicitaSenha.png
${TELA_EXIBE_CLIENTE}                                  tela_exibeCliente.png
${TELA_SELECIONA_TABELA_PRECO}                         tela_TabelasPreco.png
${TELA_VENDAS_ANTERIORES}                              tela_ExibeAnteriores.png
${TELA_INDICACAO_VENDA}                                tela_QuemIndicou.png
${TELA_LIBERAÇÃO_DESCONTO_SENHA}                       tela_liberacaoDesconto.png
${TELA_VENCIMENTO_FIM_DE_SEMANA}                       aviso_VencimentoFeriadoSabadoDomingo.png
${TELA_IMPRIMIR_ORDEM_ENTREGA}                         tela_ImprimirOrdemEntrega.png
${TELA_RECIBO_ENTRADA}                                 tela_ReciboEntrada.png
${TELA_CONTRATO_VENDA}                                 tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}                            tela_EmisssaoPromissoria.png
${TELA_IMPRESSAO_BOLETO}                               tela_impressaoBoleto.png
${TELA_IMPRESSAO_DUPLICATAS}                           tela_ImpressaoDuplicatas.png
${TELA_EMISSAO_NFC}                                    tela_EmissaoNFC.png
${TELA_FATURAMENTO_NF}                                 tela_FaturamentoDiretoNF.png
${TELA_CONFIRMAÇÃO_PAGAMENTO}                          tela_DataPagamento.png
${TELA_IMPRESSAO_ENTREGA}                              tela_ImpressaoEntrega.png
${TELA_ENTREGAS}                                       tela_Entregas.png
${TELA_ORDEM_DE_ENTREGA}                               tela_OrdemDeEntrega.png
${TELA_GUIA_CONFIGURACOES}                             tela_GuiaConfiguracoes.png
${TELA_ENDERECO_ENTREGA_VENDA}                         tela_EnderecoEntregaVenda.png
${TELA_CONSULTA_SCPC_SEM_CONSULTA_SALVA}               tela_ConsultaSCPC_SemConsultaSalva.png
${TELA_CONSULTA_SCPC_COM_CONSULTA_SALVA}               tela_ConsultaSCPC_ComConsultaSalva.png

# Telas Avisos
${AVISO_USAR_ESSE_VENDEDOR}                            aviso_clienteOutroVendedor.png
${AVISO_ALTERAR_VENDEDOR}                              aviso_DesejaAlterarVendedor.png
${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}                    aviso_ExigeSenhaVendedorDiferente.png
${AVISO_CONDICIONAL_ABERTO_VISUALIZA}                  aviso_CondicionalEmAbertoVisualizar.png
${AVISO_CONDICIONAL_ABERTO_COND}                       aviso_CondicionaisEmAberto_Condicional.png
${ALERTA_CLIENTE}                                      alertaCliente.png
${AVISO_VENCIMENTO_FERIADO_DOM_SAB}                    aviso_VencimentoFeriadoSabadoDomingo.png
${AVISO_NÃO_PERMITIDO_MULTIPLAS_VENDAS_POR_ENTREGA}    aviso_NaoPermitidoMultiplasVendasPorEntrega.png
${AVISO_SELECAO_COI_FATURAMENTO}                       aviso_SelecaoCoiFaturamento.png
${AVISO_CLIENTE_POSSUI_VALES_COMPRA}                   aviso_ClientePossuiValesCompra.png
${AVISO_INFORMATIVO_SAIBA_MAIS}                        aviso_InformativoSaibaMais.png
${AVISO_ENVIO_XML_CONTABILIDADE}                       aviso_EnvioXmlContabilidade.png
${AVISO_LANC_CONDICIONAL_EM_ABERTO}                    aviso_LancCondicionalEmAberto.png
${AVISO_LANC_DEVOLUCAO_EM_ABERTO}                      aviso_LancDevolucaoEmAberto.png
${AVISO_LANC_ORÇAMENTO_EM_ABERTO}                      aviso_LancOrçamentoEmAberto.png
${AVISO_LANC_OS_EM_ABERTO}                             aviso_LancOSEmAberto.png
${AVISO_LANC_VENDA_EM_ABERTO}                          aviso_LancVendaEmAberto.png
${AVISO_LANC_PRE_VENDA_EM_ABERTO}                      aviso_LancPreVendaEmAberto.png
${AVISO_DESC_ESCALA_COMISSAO}                          aviso_DescEscalaComissao.png
${AVISO_EDITAR_OS_FINALIZADA}                          aviso_EditarOSFinalizadaSupervisor.png
${AVISO_VENDEDOR_SEM_PERCENT_COMISSAO_VALE_COMPRA}     aviso_VendedorSemPercentualComissaoValeCompra.png
${AVISO_CLIENTE_MENOR_DE_IDADE}                        aviso_ClienteMenorDeIdade.png
${AVISO_ATUALIZAR_NUMERO_CADASTRO_PRICIPAL}            aviso_AtualizarNumeroCadastroPrincipal.png

# Botões
${BT_NAO}                                              bt_Nao.png
${BT_FECHAR_X}                                         bt_FecharX.png
${BT_SIM_AVISO_VENCIMENTO_FERIADO}                     bt_SimAvisoVencimentoFeriado.png
${BT_OK}                                               bt_OK_sem_atalho.png

# Inputs
${INPUT_DESCRICAO_ENTREGA_PREENCHIDO}                  input_DescricaoEntregaPreenchido.png

# Labels
${LABEL_LIBERAÇÃO_SUPERVISOR}                          label_PasseOCartaoDeLiberacao.png
${LABEL_COI_NFE}                                       lb_CoiNFe.png
${LABEL_GUIA_CONFIGURACOES}                            lb_GuiaConfiguracoes.png
${LABEL_VALES_COMPRA_DISPONIVEIS}                      lb_ValesCompraDisponiveis.png

# Outros
${EXPANDIR_COMBOBOX}                                   expandir_combobox.png
${FORMA_PARC_A_VISTA}                                  forma_parc_à_vista.png
${VENDA_A_PRAZO_CLIENTE_1_CONSUMIDOR}                  venda_a_prazo_cliente_1_consumidor.png
${Edicao_Condicional}                                  ${False}

# Flags booleanas — parâmetros do sistema (inicializados em runtime via Set Global Variable)
${Aviso_ProdutoSemEstoque}                             ${False}
${Caixa_Baixas_Automatica}                             ${False}
${Parametro_AvisarVendedorDiferenteDoCadastro}         ${False}
${Parametro_BaixaAutomatico}                           ${False}
${Parametro_BaixaCentralizada}                         ${False}
${Parametro_BaixaEstoquePreVenda}                      ${False}
${Parametro_BloqueiaGeracaoVendaParcial}               ${False}
${Parametro_BloqueiaOrcamentoSemEstoque}               ${False}
${Parametro_BloquearCampoNpedPreVenda}                 ${False}
${Parametro_CaixaControladoPorUsuario}                 ${False}
${Parametro_ComissaoVendedorEExecutorServico}          ${False}
${Parametro_ConsideraDoacoes}                          ${False}
${Parametro_ConsultaSCPCVenda}                         ${False}
${Parametro_Controla_Entrega}                          ${False}
${Parametro_ControlaCreditoCondicional}                ${False}
${Parametro_ControlaCreditoDescontaChequePreEmMaos}    ${False}
${Parametro_ControlaCreditoDevTroca}                   ${False}
${Parametro_ControlaCreditoGerarPreVendaOrcamento}     ${False}
${Parametro_ControlaCreditoOrcamento}                  ${False}
${Parametro_ControlaCreditoOS}                         ${False}
${Parametro_ControlaCreditoPreSeparacaoPreVenda}       ${False}
${Parametro_ControlaCreditoPreVenda}                   ${False}
${Parametro_ControlaCreditoPreVendaAuditoria}          ${False}
${Parametro_ControlaCreditoVenda}                      ${False}
${Parametro_Desabilita_Servico_Orcamento}              ${False}
${Parametro_DescontoFinalRespeitaMaximoDosProdutos}    ${False}
${Parametro_DevolucaoAvulsa}                           ${False}
${Parametro_DevolucaoExigeOBS}                         ${False}
${Parametro_DevolucaoPermiteAberta}                    ${False}
${Parametro_Exibe_Foto_Cliente}                        ${False}
${Parametro_ExibeVendasAnteriores}                     ${False}
${Parametro_ExibirCampoNpedVenda}                      ${False}
${Parametro_ExigeSenhaCancelarVenda}                   ${False}
${Parametro_ExigeSenhaMultiplo}                        ${False}
${Parametro_ExigeSenhaOutroVendedor}                   ${False}
${Parametro_Fatura_OS}                                 ${False}
${Parametro_FaturamentoAoFinalizarOS}                  ${False}
${Parametro_FaturaVendaDireto}                         ${False}
${Parametro_FocoCampoCliente}                          ${False}
${Parametro_Impre_Ordem_de_Entrega}                    ${False}
${Parametro_Imprime_Carne_OS}                          ${False}
${Parametro_Imprime_OrdemEntrega}                      ${False}
${Parametro_Imprime_OS}                                ${False}
${Parametro_ImprimeCondicional}                        ${False}
${Parametro_ImprimeNFCeDireto}                         ${False}
${Parametro_ImpressaoDiretaPreVenda}                   ${False}
${Parametro_ImpressaoAposGerarEntrega}                 ${False}
${Parametro_ImprimirBoletoAoFinalizarVenda}            ${False}
${Parametro_ImprimirContratoAoFinalizarVenda}          ${False}
${Parametro_ImprimirDuplicatasAoFinalizarVenda}        ${False}
${Parametro_ImprimirPreVendaAoFinalizarPreVenda}       ${False}
${Parametro_ImprimirPromissoriaAoFinalizarVenda}       ${False}
${Parametro_ImprimirReciboEntradaAoFinalizarVenda}     ${False}
${Parametro_ImprimirVendaAoFinalizarVenda}             ${False}
${Parametro_IncluiDireto}                              ${False}
${Parametro_IndicacaoOrcamento}                        ${False}
${Parametro_IndicacaoOS}                               ${False}
${Parametro_IndicacaoPreVenda}                         ${False}
${Parametro_IndicacaoVenda}                            ${False}
${Parametro_InfoCreditoClienteOrcamento}               ${False}
${Parametro_InfoCreditoClientePreVenda}                ${False}
${Parametro_InfoCreditoClienteVenda}                   ${False}
${Parametro_Local_Negociacao}                          ${False}
${Parametro_NaoDeduzirISSQNComissaoOS}                 ${False}
${Parametro_ObrigaMotivoDevolucao}                     ${False}
${Parametro_Permite_Varias_Tabelas}                    ${False}
${Parametro_PesquisaCodigoCodFabricaReferencia}        ${False}
${Parametro_RealizaPreVendaSemEstoque}                 ${False}
${Parametro_RealizaVendaSemEstoque}                    ${False}
${Parametro_Seleciona_Funcionario_Comissao_Servico}    ${False}
${Parametro_Suprime_Objetos_OS_Orcamento}              ${False}
${Parametro_TrazerDescricaoAutomaticaEntrega}          ${False}
${Parametro_UmaEntregaPorVenda}                        ${False}
${Parametro_ValeCompra_Dev_Menor0}                     ${False}
${Parametro_Venda_Padrao_Entregue}                     ${False}
${Parametro_VendaSemEstoqueOrdemDeServico}             ${False}
${Parametro_VendeSemEstoque}                           ${False}
${Parametro_VendeSemEstoqueCondicional}                ${False}
${Parametro_VinculaProdutoDevolvidoEntrega}            ${False}

# Parâmetros escalares (inicializados em runtime via Set Global Variable)
${Parametro_DiasInativoSCPC}                           None
${Parametro_EmitirBoletosAcimaDeValorMinimo}           None
${Parametro_QuantidadePadraoProduto}                   None
${Parametro_TelasQtdePadraoProduto}                    None

# Variáveis internas (Set Test Variable)
${Check_List_Objeto}                                   ${False}
${Codigo_CheckList}                                    ${None}
${Parametro_GerarEntregaStatusConcluido}               ${False}

***Keywords***
Verifica se cliente possui condicional em aberto(${Codigo_Cliente})

    Sleep    ${SLEEP_MEDIO}

    ${aviso_cond_aberto_tela_cond}    Exists    ${AVISO_CONDICIONAL_ABERTO_COND}
    ${aviso_cond_outras_telas}        Exists    ${AVISO_CONDICIONAL_ABERTO_VISUALIZA}

    IF    not ${aviso_cond_aberto_tela_cond} and not ${aviso_cond_outras_telas}
        Return From Keyword
    END

    IF    ${aviso_cond_aberto_tela_cond}
        ${query}    Set Variable    SELECT c.Codigo FROM condicionais c WHERE c.CodigoCliente = ${Codigo_Cliente} AND c.Status = 'f'
    ELSE
        ${query}    Set Variable    SELECT c.Codigo FROM condicionais c WHERE c.CodigoCliente = ${Codigo_Cliente} AND c.Status IN ('f','e')
    END

    ${cliente_tem_condicional_emAberto}    Run Keyword And Return Status    Check If Exists In Database    ${query}

    Sleep    ${SLEEP_BAIXO}

    IF    not ${cliente_tem_condicional_emAberto}
        Fail    Aviso exibido mas sem condicional em aberto no BD para o cliente ${Codigo_Cliente}.
    END

    IF    ${aviso_cond_aberto_tela_cond}
        Processa aviso de condicional em aberto    CONDICIONAL    ${cliente_tem_condicional_emAberto}
    ELSE
        Processa aviso de condicional em aberto    OUTRAS    ${cliente_tem_condicional_emAberto}
    END

Processa aviso de condicional em aberto
    [Arguments]    ${tela}    ${possui_cond_emAberto}
    
    Sleep    ${SLEEP_BAIXO}

    IF    not ${possui_cond_emAberto}
        Fail    Aviso exibido mas sem condicional no BD.
    END
    
    IF    '${tela}' == 'CONDICIONAL'

        Press Special Key    ENTER

    ELSE IF    '${tela}' == 'OUTRAS'

        Press Combination    KEY.ALT    KEY.N
        
    END

Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

    ${ExisteAvisoInfoCreditoCliente}    Set Variable    ${False}

    ${Observacao_existe}    Run Keyword And Return Status    Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente};

    Set Test Variable    ${Observacao_existe}

    Valida cadastro padrão de endereço
    
    IF    ${Observacao_existe}

        Valida observaco cliente

    END

    IF    ${Parametro_ExigeSenhaOutroVendedor}

        Valida aviso exige senha para outro vendedor

    END
    
    IF    '${TELA}' != 'NFeSaidasManual'
        
        # Na edição da condicional, é exibido outra mensagem de alteração de vendedor, a mesma que exibe em pré-vendas.
        IF    ${Edicao_Condicional}

            Valida aviso de alteração de vendedor na pré-venda

        ELSE IF    ${Parametro_AvisarVendedorDiferenteDoCadastro}

            Valida aviso para usar o vendedor vinculado ao cliente

        END

    END
    
    Valida cliente menor de idade

    Valida aviso atualizar número no cadastro principal

    Verifica se cliente possui condicional em aberto(${Codigo_Cliente})

    # IF    ${Parametro_ConsultaSCPCVenda}

    #     Valida consulta SCPC
        
    # END

    IF    '${TELA}' == 'Orçamento'

        IF    ${Parametro_InfoCreditoClienteOrcamento}

            ${ExisteAvisoInfoCreditoCliente}    Set Variable    ${True}
            
        END

    ELSE
        
        IF    ${Parametro_InfoCreditoClienteVenda}

            ${ExisteAvisoInfoCreditoCliente}    Set Variable    ${True}
            
        END
        
    END

    IF    ${ExisteAvisoInfoCreditoCliente}

        Valida informações de crédito

    END

    IF    ${Parametro_ExibeVendasAnteriores}

        Valida vendas anteriores

    END

    IF     ${Parametro_Exibe_Foto_Cliente}

        Valida exibe cliente

    END

    Verifica se cliente possui objeto vinculado

Carregar parâmetros do sistema

    ${Lista_de_Parametros}    ${TelasQtdePadraoProduto}    ${QuantidadePadraoVenda}    ${DiasInativoSCPC}    ${ValorMinimoBoleto}    Valida Parametros Config
    ${Config_Empresas}        Valida Config Empresa

    # Adiciona no campo Vendedor o usuário logado e o no campo cliente o CONSUMIDOR (CÓDIGO 1)
    ${Parametro_VendaRapida}                               Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Venda_Rapida
    ${Parametro_IncluiDireto}                              Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    IncluiDireto
    ${Aviso_ProdutoSemEstoque}                             Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Aviso_Sem_Est
    ${Parametro_IndicacaoVenda}                            Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    IndicacaoVenda
    ${Parametro_VendeSemEstoque}                           Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Vende_Sem_Estoque
    ${Parametro_ControlaCreditoVenda}                      Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoClientes
    ${Parametro_Controla_Entrega}                          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaEntregaPrevista
    ${Parametro_Local_Negociacao}                          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    LocalNegociacao
    ${Parametro_ExigeSenhaMultiplo}                        Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Senha_supervisor_multiplo
    ${Parametro_Exibe_Foto_Cliente}                        Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ExibeFotoCli
    ${Parametro_Imprime_OrdemEntrega}                      Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimirOrdemEntrega
    ${Parametro_ExibeVendasAnteriores}                     Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    PVexibeAnteriores
    ${Parametro_Permite_Varias_Tabelas}                    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    PermiteVariasTabelas
    ${Parametro_Impre_Ordem_de_Entrega}                    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimirOrdemEntrega
    ${Parametro_Suprime_Objetos_OS_Orcamento}              Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    SuprimirOS
    ${Parametro_Desabilita_Servico_Orcamento}              Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Orc_DesabilitaServico
    ${Parametro_Seleciona_Funcionario_Comissao_Servico}    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    SelecionaFunc_OS
    ${Parametro_Fatura_OS}                                 Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    FaturarOS
    ${Parametro_Imprime_Carne_OS}                          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimirCarneOS
    ${Parametro_Imprime_OS}                                Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimirOS
    ${Parametro_VendeSemEstoqueCondicional}                Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Vende_Sem_Estoque_Condicional
    ${Parametro_ImprimeCondicional}                        Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimiCondicional
    ${Parametro_VendaSemEstoqueOrdemDeServico}             Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    RealizaVendaSemEstoque_OS
    ${Parametro_DevolucaoAvulsa}                           Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    DevolucaoAvulsa
    ${Parametro_DevolucaoExigeOBS}                         Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ExigeObsTroca
    ${Parametro_DevolucaoPermiteAberta}                    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Dev_PermiteAberta
    ${Parametro_RealizaPreVendaSemEstoque}                 Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    RealizaVendaSemEstoque_PreVenda
    ${Parametro_RealizaVendaSemEstoque}                    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    RealizaVendaSemEstoque_Venda
    ${Parametro_ExigeSenhaCancelarVenda}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ExigeSenhaCancelarVenda
    ${Parametro_BloqueiaGeracaoVendaParcial}               Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    PrevendaBloqueioVendaParcial
    ${Parametro_CaixaControladoPorUsuario}                 Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    CaixaUsuario
    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos}    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    DescontoFinalIgualmente
    ${Parametro_ImprimeNFCeDireto}                         Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Venda_ImprimeCupom
    ${Parametro_ImprimirVendaAoFinalizarVenda}             Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirVenda_FinalizarVenda
    ${Parametro_ImprimirDuplicatasAoFinalizarVenda}        Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirDup_FinalizarVenda
    ${Parametro_BaixaCentralizada}                         Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaCentralizada
    ${Parametro_BaixaAutomatico}                           Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaAutomatico
    ${Caixa_Baixas_Automatica}                             Run Keyword And Return Status    Should Contain    ${Config_Empresas}    CodigoCX
    ${Parametro_ImprimirReciboEntradaAoFinalizarVenda}     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpRecEnt_FinalizarVenda
    ${Parametro_ImprimirContratoAoFinalizarVenda}          Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirContrato_FinalizarVenda
    ${Parametro_ImprimirPromissoriaAoFinalizarVenda}       Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpPromissoria_FinalizarVenda
    ${Parametro_ImprimirBoletoAoFinalizarVenda}            Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirBol_FinalizarVenda
    ${Parametro_ValeCompra_Dev_Menor0}                     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Dev_Ativa_Vale
    ${Parametro_FaturaVendaDireto}                         Run Keyword And Return Status    Should Contain    ${Config_Empresas}    FaturaVendaDireto
    ${Parametro_BloqueiaOrcamentoSemEstoque}               Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    OrcamentoComEstoque_Bloq
    ${Parametro_BaixaEstoquePreVenda}                      Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    BaixaEstoquePreVenda
    ${Parametro_ImpressaoAposGerarEntrega}                 Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_ImpressaoEntrega
    ${Parametro_UmaEntregaPorVenda}                        Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_UmaEntregaPorVenda
    ${Parametro_ConsideraDoacoes}                          Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_ConsideraDoacoes
    ${Parametro_Venda_Padrao_Entregue}                     Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Venda_Padrao_Entregue
    ${Parametro_TrazerDescricaoAutomaticaEntrega}          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    TrazerDescricaoAutomaticaEntrega
    ${Parametro_FaturamentoAoFinalizarOS}                  Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    FaturarOS
    ${Parametro_ComissaoVendedorEExecutorServico}          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    OS_ComVendedorEexecutor
    ${Parametro_NaoDeduzirISSQNComissaoOS}                 Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    NaoDeduzirISSQNComissao
    ${Parametro_PesquisaCodigoCodFabricaReferencia}        Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    BuscaReferencia
    ${Parametro_ConsultaSCPCVenda}                         Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ConsultaSCPCVenda
    ${Parametro_FocoCampoCliente}                          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    FocoClienteVenda
    ${Parametro_IndicacaoPreVenda}                         Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    IndicacaoPreVenda
    ${Parametro_ControlaCreditoOrcamento}                  Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoORC
    ${Parametro_ControlaCreditoCondicional}                Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoCond
    ${Parametro_ControlaCreditoGerarPreVendaOrcamento}     Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoGeraPreOrcamento
    ${Parametro_ControlaCreditoOS}                         Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoOS
    ${Parametro_ControlaCreditoDevTroca}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoDevTroca
    ${Parametro_ControlaCreditoPreVenda}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCreditoPRE
    ${Parametro_ControlaCreditoPreSeparacaoPreVenda}       Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ControlaCredPreSepPreVenda
    ${Parametro_ControlaCreditoDescontaChequePreEmMaos}    Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    DescontaChPre_CreditoCliente
    ${Parametro_ControlaCreditoPreVendaAuditoria}          Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    AuditoriaControlaCreditoPre
    ${Parametro_VinculaProdutoDevolvidoEntrega}            Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    VinculaDevolucaoEntrega
    ${Parametro_ObrigaMotivoDevolucao}                     Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ObrigarMotivoDevolucao
    ${Parametro_AvisarVendedorDiferenteDoCadastro}         Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    AvisoVendedor
    ${Parametro_IndicacaoOrcamento}                        Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    IndicacaoOrcamento
    ${Parametro_IndicacaoOS}                               Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    IndicacaoOS
    ${Parametro_InfoCreditoClienteVenda}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Aviso_Info_Financeiro
    ${Parametro_InfoCreditoClienteOrcamento}               Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Aviso_Info_Financeiro_Orc
    ${Parametro_InfoCreditoClientePreVenda}                Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Aviso_Info_Financeiro_Prev
    ${Parametro_ExigeSenhaOutroVendedor}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ExigeSenhaMudarVendedorVenda
    ${Parametro_ImprimirPreVendaAoFinalizarPreVenda}       Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    ImprimirPreVenda_FinalizarPreVenda
    ${Parametro_ImpressaoDiretaPreVenda}                   Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    PrevendaDireto
    ${Parametro_ExibirCampoNpedVenda}                      Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    Exibir_Campo_Nped_Venda
    ${Parametro_BloquearCampoNpedPreVenda}                 Run Keyword And Return Status    Should Contain    ${Lista_de_Parametros}    pula_foco_npedido

    IF    ${Parametro_VendaRapida}

        Log To Console    \n\nO parâmetro "Venda_Rapida" interfere diretamente no processo de venda. Teste sendo finalizado.${\n}Caminho do parâmetro: ADM Sistema → +Config → Geral → Mais → Trazer vendedor e cliente padrão...\n
        Terminate Process

    END

    #Sim, essa redundância inútil existe no MyCommerce, em cada tela é validado se primeiro o Parametro de venda sem estoque está marcado
    #Para depois ver se o parametro especifico da tela está marcado para ai sim ver se vai ser incluido ou não.

    IF    ${Parametro_VendeSemEstoque} == ${False}

        # Como o parâmetro 'Vende sem estoque' está configurado como falso, os demais também serão considerados falsos.

        Set Global Variable    ${Parametro_RealizaPreVendaSemEstoque}    ${False}

        Set Global Variable    ${Parametro_RealizaVendaSemEstoque}    ${False}

        Set Global Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}    ${False}

        Set Global Variable    ${Parametro_VendeSemEstoque}    ${False}

    ELSE

        Set Global Variable    ${Parametro_RealizaPreVendaSemEstoque}

        Set Global Variable    ${Parametro_RealizaVendaSemEstoque}

        Set Global Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}

        Set Global Variable    ${Parametro_VendeSemEstoque}

    END

    Set Global Variable    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos}

    Set Global Variable    ${Parametro_CaixaControladoPorUsuario}

    Set Global Variable    ${Parametro_FaturaVendaDireto}

    Set Global Variable    ${Parametro_BloqueiaGeracaoVendaParcial}

    Set Global Variable    ${Parametro_ExigeSenhaCancelarVenda}

    Set Global Variable    ${Parametro_DevolucaoPermiteAberta}

    Set Global Variable    ${Parametro_DevolucaoExigeOBS}

    Set Global Variable    ${Parametro_ValeCompra_Dev_Menor0}

    Set Global Variable    ${Parametro_DevolucaoAvulsa}

    Set Global Variable    ${Parametro_Fatura_OS}

    Set Global Variable    ${Parametro_Imprime_Carne_OS}

    Set Global Variable    ${Parametro_Imprime_OS}

    Set Global Variable    ${Parametro_Seleciona_Funcionario_Comissao_Servico}

    Set Global Variable    ${Parametro_Suprime_Objetos_OS_Orcamento}

    Set Global Variable    ${Parametro_Desabilita_Servico_Orcamento}

    Set Global Variable    ${Parametro_ImprimirBoletoAoFinalizarVenda}

    Set Global Variable    ${Parametro_ImprimirPromissoriaAoFinalizarVenda}

    Set Global Variable    ${Parametro_ImprimirContratoAoFinalizarVenda}

    Set Global Variable    ${Parametro_ImprimirReciboEntradaAoFinalizarVenda}

    Set Global Variable    ${Parametro_Impre_Ordem_de_Entrega}

    Set Global Variable    ${Parametro_ControlaCreditoVenda}

    Set Global Variable    ${Parametro_IndicacaoVenda}

    Set Global Variable    ${Parametro_IncluiDireto}

    Set Global Variable    ${Aviso_ProdutoSemEstoque}

    Set Global Variable    ${Parametro_ImprimeNFCeDireto}

    Set Global Variable    ${Parametro_ImprimirVendaAoFinalizarVenda}

    Set Global Variable    ${Parametro_ImprimirDuplicatasAoFinalizarVenda}

    Set Global Variable    ${Parametro_ExibeVendasAnteriores}

    Set Global Variable    ${Parametro_ExigeSenhaMultiplo}

    Set Global Variable    ${Parametro_BaixaCentralizada}

    Set Global Variable    ${Parametro_BaixaAutomatico}

    Set Global Variable    ${Caixa_Baixas_Automatica}

    Set Global Variable    ${Parametro_Exibe_Foto_Cliente}

    Set Global Variable    ${Parametro_Controla_Entrega}

    Set Global Variable    ${Parametro_Local_Negociacao}

    Set Global Variable    ${Parametro_Imprime_OrdemEntrega}

    Set Global Variable    ${Parametro_Permite_Varias_Tabelas}

    Set Global Variable    ${Parametro_VendeSemEstoqueCondicional}

    Set Global Variable    ${Parametro_ImprimeCondicional}

    Set Global Variable    ${Parametro_BloqueiaOrcamentoSemEstoque}

    Set Global Variable    ${Parametro_BaixaEstoquePreVenda}

    Set Global Variable    ${Parametro_ImpressaoAposGerarEntrega}

    Set Global Variable    ${Parametro_UmaEntregaPorVenda}

    Set Global Variable    ${Parametro_ConsideraDoacoes}

    Set Global Variable    ${Parametro_Venda_Padrao_Entregue}

    Set Global Variable    ${Parametro_TrazerDescricaoAutomaticaEntrega}

    Set Global Variable    ${Parametro_FaturamentoAoFinalizarOS}

    Set Global Variable    ${Parametro_ComissaoVendedorEExecutorServico}

    Set Global Variable    ${Parametro_NaoDeduzirISSQNComissaoOS}

    Set Global Variable    ${Parametro_PesquisaCodigoCodFabricaReferencia}

    Set Global Variable    ${Parametro_ConsultaSCPCVenda}

    Set Global Variable    ${Parametro_FocoCampoCliente}

    Set Global Variable    ${Parametro_IndicacaoPreVenda}

    Set Global Variable    ${Parametro_TelasQtdePadraoProduto}    ${TelasQtdePadraoProduto}

    Set Global Variable    ${Parametro_QuantidadePadraoProduto}    ${QuantidadePadraoVenda}

    Set Global Variable    ${Parametro_DiasInativoSCPC}    ${DiasInativoSCPC}

    Set Global Variable    ${Parametro_ControlaCreditoOrcamento}

    Set Global Variable    ${Parametro_ControlaCreditoCondicional}

    Set Global Variable    ${Parametro_ControlaCreditoGerarPreVendaOrcamento}

    Set Global Variable    ${Parametro_ControlaCreditoOS}

    Set Global Variable    ${Parametro_ControlaCreditoDevTroca}

    Set Global Variable    ${Parametro_ControlaCreditoPreVenda}

    Set Global Variable    ${Parametro_ControlaCreditoPreSeparacaoPreVenda}

    Set Global Variable    ${Parametro_ControlaCreditoDescontaChequePreEmMaos}

    Set Global Variable    ${Parametro_ControlaCreditoPreVendaAuditoria}

    Set Global Variable    ${Parametro_VinculaProdutoDevolvidoEntrega}

    Set Global Variable    ${Parametro_ObrigaMotivoDevolucao}

    Set Global Variable    ${Parametro_AvisarVendedorDiferenteDoCadastro}

    Set Global Variable    ${Parametro_IndicacaoOrcamento}

    Set Global Variable    ${Parametro_IndicacaoOS}

    Set Global Variable    ${Parametro_InfoCreditoClienteVenda}

    Set Global Variable    ${Parametro_InfoCreditoClienteOrcamento}

    Set Global Variable    ${Parametro_InfoCreditoClientePreVenda}

    Set Global Variable    ${Parametro_ExigeSenhaOutroVendedor}

    Set Global Variable    ${Parametro_ImprimirPreVendaAoFinalizarPreVenda}

    Set Global Variable    ${Parametro_ImpressaoDiretaPreVenda}

    Set Global Variable    ${Parametro_EmitirBoletosAcimaDeValorMinimo}    ${ValorMinimoBoleto}

    Set Global Variable    ${Parametro_ExibirCampoNpedVenda}

    Set Global Variable    ${Parametro_BloquearCampoNpedPreVenda}

Valida aviso exige senha para outro vendedor

    ${aviso}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}    ${SLEEP_ALTO}

    IF    ${aviso}

        Press Special Key    ENTER
        Wait Until Screen Contain    ${TELA_SENHA_SUPERVISOR}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso para usar o vendedor vinculado ao cliente
    
    Sleep    ${SLEEP_BAIXO}
    ${vinculoVendedorCliente}    Query    SELECT c.CodigoVendedor FROM clientes AS c WHERE c.Codigo = ${Codigo_Cliente}

    IF    $vinculoVendedorCliente[0][0] is not None

        ${VendedorVinculoCliente}    Convert To Integer    ${vinculoVendedorCliente[0][0]}
        ${VendedorDaOperacao}        Convert To Integer    ${Codigo_Vendedor}

        IF    ${VendedorVinculoCliente} != ${VendedorDaOperacao}

            Wait Until Screen Contain    ${AVISO_USAR_ESSE_VENDEDOR}    ${TEMPO_TELA}
            
            Sleep    ${SLEEP_BAIXO}
            Press Combination    KEY.ALT    KEY.N

            Wait Until Screen Not Contain    ${AVISO_USAR_ESSE_VENDEDOR}    ${SLEEP_ALTO}
            
        END
        
    END

Valida informações de crédito

    IF    '${TELA}' != 'NFeSaidasManual'

        Sleep    ${SLEEP_BAIXO}
        ${query_duplicatasNaoQuitadas}    Run Keyword And Return Status    Check If Exists In Database    SELECT Sequencia, Descricao, DataQuitacao, DataLancamento, CodigoVenda, NDocumento, NPagamento, Vencimento, Valor, ValorPendente, Empresa, TipoCR FROM ContasAReceber WHERE Codigo = ${Codigo_Cliente} AND Quitado = 0 AND ISNULL(Cancelada) AND SEQUENCIA NOT IN(SELECT valecompra.SeqCR FROM valecompra WHERE valecompra.SeqCR = SEQUENCIA);

        IF    ${query_duplicatasNaoQuitadas}

            ${tela}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INFO_CRÉDITOS}    ${TEMPO_TELA}

            IF    ${tela}

                Press Special Key    ESC
                
                Wait Until Screen Not Contain    ${TELA_INFO_CRÉDITOS}    ${SLEEP_ALTO}

            END
            
        END

    END

Valida condicional aberto
    
    Sleep    ${SLEEP_BAIXO}
    ${Test_Condicional}    Run Keyword And Return Status    Should Contain    ${SUITE_NAME}    Condicional

    Sleep    ${SLEEP_BAIXO}

    IF    ${Test_Condicional}
        
        ${aviso}    Exists    ${AVISO_CONDICIONAL_ABERTO_COND}

        IF    ${aviso}

            Press Special Key    ENTER
        
        ELSE
            Fail    Erro ao identificar a mensagem.
        END
        
    ELSE
        
        ${aviso}    Exists    ${AVISO_CONDICIONAL_ABERTO_VISUALIZA}

        IF    ${aviso}

            Press Combination    KEY.ALT    KEY.N
            
        ELSE
            Fail    Erro ao identificar a mensagem.
        END

    END

Valida observaco cliente

    ${consulta}     Query    SELECT Observacao FROM clientes WHERE Codigo = ${Codigo_Cliente}
    ${Observacao}    Set Variable    ${consulta[0][0]}

    IF    $Observacao

        Sleep    ${SLEEP_MEDIO}
        ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${ALERTA_CLIENTE}    ${SLEEP_ALTO}

        IF    ${MSG}

            Press Combination    KEY.ALT    KEY.O
            Sleep    ${SLEEP_MEDIO}

        END

    END

Valida vendas anteriores

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_VENDAS_ANTERIORES}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida exibe cliente

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_EXIBE_CLIENTE}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida a tela de preços & prazos de pagamentos

    Sleep    ${SLEEP_ALTO}
    ${tela}    Exists    ${TELA_SELECIONA_TABELA_PRECO}

    IF    ${tela}

        ${eh_tab_preco_escalonada}    Evaluate    $Cenario_Comissao_Tabela_Preco == 'PROD__TAB_PRECO_ESCALONADA__COM_DESC'

        IF    '${Tipo_Comissao_Linha}' == 'Tabela de Preco Geral' or ${eh_tab_preco_escalonada}

            Seleciona tabela de preço na tela de preços e prazos de pagamentos    ${Id_Tabela_Preco_Selecionada}

        ELSE

            Press Special Key    ENTER
            Sleep    ${SLEEP_MEDIO}

        END

    END

Valida indicação venda

    IF    ${Parametro_IndicacaoVenda}

        ${telaQuemIndicou}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INDICACAO_VENDA}    ${TEMPO_TELA}

        IF    ${telaQuemIndicou}

            Press Special Key    ESC
            Sleep    ${SLEEP_BAIXO}

        END
        
    END

Valida tela de liberação de desconto

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_LIBERAÇÃO_DESCONTO_SENHA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida parâmetros/impressões pós venda
    
    IF    ${Parametro_FaturaVendaDireto}

        Valida faturamento nf

    END

    Valida impressao direta de venda(${Parametro_ImprimirVendaAoFinalizarVenda})

    IF    ${Parametro_ImprimirBoletoAoFinalizarVenda}

        Valida impressão de boleto

    END

    IF    ${Parametro_ImprimirReciboEntradaAoFinalizarVenda}

        Valida impressão de entrada

    END

    IF    ${Parametro_ImprimeNFCeDireto}

        Cancelando Faturando a NFC-e

    END

    IF    ${Parametro_ImprimirContratoAoFinalizarVenda}

        Valida impressão do contrato de venda

    END

    IF    ${Parametro_Imprime_OrdemEntrega}

        Valida impressão de ordem de entrega

    END

    IF    ${Parametro_ImprimirDuplicatasAoFinalizarVenda}

        Valida Impressao de duplicatas

    END
    
    IF    ${Parametro_ImprimirPromissoriaAoFinalizarVenda}

        Valida impressão de promissória

    END

Valida impressão de ordem de entrega

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRIMIR_ORDEM_ENTREGA}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de entrada

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_RECIBO_ENTRADA}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão do contrato de venda

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_CONTRATO_VENDA}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de promissória

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_EMISSAO_PROMISSÓRIA}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de boleto

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_BOLETO}

    IF    ${MSG}

        SikuliLibrary.Click    ${BT_NAO}
        Sleep    ${SLEEP_MEDIO}

    END

Valida vencimento em fins de semana e feriados(${N_Pagamentos})

    FOR    ${i}    IN RANGE    ${N_Pagamentos}
        
        Sleep    ${SLEEP_MEDIO}
        ${aviso}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_VENCIMENTO_FIM_DE_SEMANA}    ${SLEEP_ALTO}

        IF    ${aviso}
            
            SikuliLibrary.Click    ${BT_SIM_AVISO_VENCIMENTO_FERIADO}
            # Press Combination    KEY.ALT    KEY.S
            Sleep    ${SLEEP_BAIXO}

        END

    END

Valida Impressao de duplicatas

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_DUPLICATAS}

    IF    ${MSG}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_MEDIO}

    END

Cancelando Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.C


Valida faturamento nf

    ${FaturaDireto}    Run Keyword And Return Status    Wait Until Screen Contain     ${TELA_FATURAMENTO_NF}    ${TEMPO_TELA}

    IF    ${FaturaDireto}

        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_MEDIO}

    END

Verifica se cliente possui objeto vinculado

    ${Test_OS}        Run Keyword And Return Status    Should Contain    ${SUITE_NAME}    servico
    ${Test_Com_OS}    Run Keyword And Return Status    Should Contain    ${TEST_NAME}    servico

    Set Test Variable    ${Check_List_Objeto}    ${False}

    IF    ${Test_OS} or ${Test_Com_OS}

        ${Objeto_Cliente}    Query    SELECT NumeroSerie, Categoria FROM objetos WHERE CodigoCliente = ${Codigo_Cliente}

        IF    len($Objeto_Cliente) > 0

            ${Check_List_Objeto}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM checklist WHERE Objeto LIKE '${Objeto_Cliente[0][1]}' AND `Status` LIKE 'g'

            IF    ${Check_List_Objeto}

                ${Codigo_Check}    Query    SELECT Codigo FROM checklist WHERE Objeto LIKE '${Objeto_Cliente[0][1]}' AND `Status` LIKE 'g'
                Set Test Variable    ${Codigo_CheckList}    ${Codigo_Check[0][0]}

            END

            Set Test Variable    ${Check_List_Objeto}

        ELSE

            Set Test Variable    ${Check_List_Objeto}    ${False}

        END

    END

Valida tela de confirmação data - caixa

    ${Existe_Form}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_PAGAMENTO}    ${SLEEP_ALTO}

    IF    ${Existe_Form}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER

    END

Valida data de vencimento em feriados, sábados e domingos para pagamentos a prazo

    Sleep    ${SLEEP_BAIXO}
    ${AVISO}    Exists    ${AVISO_VENCIMENTO_FERIADO_DOM_SAB}

    IF    ${AVISO}

        Press Combination    KEY.Alt    KEY.s
        Sleep    ${SLEEP_BAIXO}

    END

Valida telas/avisos presentes ao gerar ordem de entrega

    ${lista_avisos_telas}    valida_Config_Empresa

    ${Parametro_GerarEntregaStatusConcluido}    Run Keyword And Return Status    Should Contain    ${lista_avisos_telas}    Entrega_StatusConcluido

    Set Test Variable    ${Parametro_GerarEntregaStatusConcluido}

    IF    ${Parametro_ImpressaoAposGerarEntrega} or ${Parametro_GerarEntregaStatusConcluido}

        Valida impressão após gerar entrega

    END

Valida impressão após gerar entrega

    ${telaImpressaoEntrega}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRESSAO_ENTREGA}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

Valida a geração de entregas com apenas uma venda por entrega

    ${aviso}    Set Variable    False

    IF    ${Parametro_UmaEntregaPorVenda}

        ${aviso}    Exists    ${AVISO_NÃO_PERMITIDO_MULTIPLAS_VENDAS_POR_ENTREGA}

        IF    ${aviso}

            Press Special Key    ENTER
            Sleep    ${SLEEP_BAIXO}

        END

    END
    
    RETURN    ${aviso}

Valida considerar lançamento de ordem de entrega de doações

    IF    not ${Parametro_ConsideraDoacoes}

        Fail   Não habilitado para considerar lançamentos de doações.\nParâmetro: Considerar Lançamentos de Doações: ${Parametro_ConsideraDoacoes}

    END

Valida descricao automatica de ordem de entrega

    IF    not ${Parametro_TrazerDescricaoAutomaticaEntrega}

        ${aux}    Exists    ${INPUT_DESCRICAO_ENTREGA_PREENCHIDO}

        IF    not ${aux}

            Press Special Key    TAB

            Type    ${EMPTY}    Entrega - Teste Automacao

        END

    END

Valida cadastro padrão de endereço

    Sleep    ${SLEEP_MEDIO}
    ${msgTela}    Exists    ${TELA_ENDERECO_ENTREGA_VENDA}

    IF    ${msgTela}

        Press Special Key    ESC
        Sleep    ${SLEEP_BAIXO}

    END

Valida seleção de coi para faturamento

    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_SELECAO_COI_FATURAMENTO}
    ${salvar}    Set Variable    ${False}

    IF    ${aviso}

        Press Special Key    ENTER

        Acessa a guia de configurações do MyMonitor
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Double Click    ${LABEL_COI_NFE}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    DOWN
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        ${salvar}    Set Variable    ${True}

    END

    RETURN    ${salvar}

Acessa a guia de configurações do MyMonitor

    SikuliLibrary.Click    ${LABEL_GUIA_CONFIGURACOES}
    Wait Until Screen Contain    ${TELA_GUIA_CONFIGURACOES}    ${TEMPO_TELA}

Valida cliente com vales compra disponíveis
    
    Sleep    ${SLEEP_ALTO}
    ${aviso}    Exists    ${AVISO_CLIENTE_POSSUI_VALES_COMPRA}

    IF    ${aviso}
        
        Sleep    ${SLEEP_BAIXO}
        SikuliLibrary.Click    ${BT_OK}

        Wait Until Screen Contain    ${LABEL_VALES_COMPRA_DISPONIVEIS}    ${TEMPO_TELA}
        
    END

Valida mensagem informativa não lida

    ${informativo}    Run Keyword And Return Status    	Check If Not Exists In Database    SELECT il.* FROM (SELECT * FROM informativos WHERE DataLimite > CURDATE() AND Titulo <> 'Curso Gratuito do MyMilk' ORDER BY ID DESC LIMIT 1) AS i LEFT JOIN informativos_lidos il ON il.IDInformativo = i.ID WHERE il.Usuario = 'Visual';
    # A validação [AND i.Titulo <> 'Curso Gratuito do MyMilk'] foi adicionada porque possui [DataLimite] muito distante (até 2050) e a mensagem nunca é exibida.

    IF    ${informativo}

        Sleep    ${SLEEP_BAIXO}
        ${msg}    Exists    ${AVISO_INFORMATIVO_SAIBA_MAIS}

        IF    ${msg}

            SikuliLibrary.Click    ${BT_FECHAR_X}
                        
        END
        
    END

Valida envio de xml à contabilidade

    ${aviso}    Exists    ${AVISO_ENVIO_XML_CONTABILIDADE}

    IF    ${aviso}
        
        SikuliLibrary.Click    ${AVISO_ENVIO_XML_CONTABILIDADE}

        Press Special Key    ESC

    END

Valida lançamento de condicional em aberto
    
    Sleep    ${SLEEP_BAIXO}
    ${condicionalEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT c.Codigo FROM condicionais AS c WHERE c.`Status` IN ('a', 'e') AND c.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND c.Cancelada IS NULL ORDER BY c.Codigo DESC LIMIT 1;

    Log To Console    \ncondicionalEmAberto: ${condicionalEmAberto}

    IF    ${condicionalEmAberto}
        
        Sleep    ${SLEEP_MEDIO}
        ${aviso}    Exists    ${AVISO_LANC_CONDICIONAL_EM_ABERTO}

        IF    ${aviso}

            # Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}
            SikuliLibrary.Click    ${BT_NAO}
            Sleep    ${SLEEP_BAIXO}
        
        END
        
    END

Valida lançamento de devolução em aberto

    Sleep    ${SLEEP_BAIXO}
    ${devolucaoEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT v.Codigo FROM vendas AS v WHERE v.`Status` = 'a' AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND v.Cancelada IS NULL AND v.Tipo = 'DV' ORDER BY v.Codigo DESC LIMIT 1;

    IF    ${devolucaoEmAberto}

        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_LANC_DEVOLUCAO_EM_ABERTO}

        IF    ${aviso}

            Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}
            
        END
        
    END

Valida lançamento de orçamento em aberto

    Sleep    ${SLEEP_BAIXO}
    ${orcamentoEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT o.Codigo FROM orcamentos AS o WHERE o.`Status` IN ('a', 'e') AND o.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND o.Cancelada IS NULL AND TIMESTAMP(o.`Data`, o.Hora) <= NOW() - INTERVAL 5 MINUTE ORDER BY o.Codigo DESC LIMIT 1;

    IF    ${orcamentoEmAberto}

        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_LANC_ORÇAMENTO_EM_ABERTO}

        IF    ${aviso}
            
            Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}

        END
        
    END

Valida lançamento de ordem de serviço em aberto

    Sleep    ${SLEEP_MEDIO}
    ${OSEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT v.Codigo FROM vendas AS v WHERE v.`Status` IN ('a', 'e') AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND v.Cancelada IS NULL AND v.Tipo = 'OS' ORDER BY v.Codigo DESC LIMIT 1;

    IF    ${OSEmAberto}

        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_LANC_OS_EM_ABERTO}

        IF    ${aviso}

            Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}
            
        END
        
    END

Valida lançamento de venda em aberto

    Sleep    ${SLEEP_BAIXO}
    ${VendaEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT v.Codigo FROM vendas AS v WHERE v.`Status` IN ('a', 'e') AND v.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND v.Cancelada IS NULL AND v.Tipo = 'VP' AND TIMESTAMP(v.`Data`, v.Hora) <= NOW() - INTERVAL 5 MINUTE ORDER BY v.Codigo DESC LIMIT 1;

    IF    ${VendaEmAberto}

        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_LANC_VENDA_EM_ABERTO}

        IF    ${aviso}

            Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}
            
        END
        
    END

Valida lançamento de pré-venda em aberto
    
    Sleep    ${SLEEP_BAIXO}
    ${PreVendaEmAberto}    Run Keyword And Return Status    Check If Exists In Database    SELECT pv.Codigo FROM pedidosvenda AS pv WHERE pv.`Status` IN ('a', 'e') AND pv.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) AND pv.Cancelada IS NULL ORDER BY pv.Codigo DESC LIMIT 1;

    IF    ${PreVendaEmAberto}

        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_LANC_PRE_VENDA_EM_ABERTO}

        IF    ${aviso}

            Press Combination    KEY.ALT    KEY.N
            Sleep    ${SLEEP_BAIXO}
            
        END
        
    END

Valida desconto que não se encaixa em nenhuma escala de comissão
    
    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        Sleep    ${SLEEP_BAIXO}
        ${aviso}    Exists    ${AVISO_DESC_ESCALA_COMISSAO}

        IF    ${aviso}

            Press Special Key    ENTER
            Sleep    ${SLEEP_BAIXO}
            
        END
         
    END

Valida edição de ordem de serviço finalizada
    
    Sleep    ${SLEEP_MEDIO}
    ${aviso}    Exists    ${AVISO_EDITAR_OS_FINALIZADA}

    IF    ${aviso}

        ${senhaUsuarioCriptografada}    Query    SELECT us.Password FROM usuarios_supervisores us INNER JOIN clientes c ON c.Codigo = us.CodigoFuncionario WHERE c.Ativo = -1 LIMIT 1;
        ${senhaUsuarioDescriptografada}    Evaluate   int(${senhaUsuarioCriptografada[0][0]} / 4)

        Input Text    ${EMPTY}    ${senhaUsuarioDescriptografada}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}
        
    END

Valida consulta SCPC
    
    Sleep    ${SLEEP_BAIXO}
    ${FisicaJuridica}    Query    SELECT c.FisicaJuridica FROM clientes c WHERE c.Codigo = ${Codigo_Cliente}

    IF    '${FisicaJuridica[0][0]}' != 'F'
        RETURN
    END

    ${NaoPossuiVendas}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT v.Codigo FROM vendas v WHERE v.CodigoCliente = ${Codigo_Cliente} AND v.Cancelada IS NULL AND v.`Data` >= DATE_SUB(CURDATE(), INTERVAL ${Parametro_DiasInativoSCPC} DAY) LIMIT 1

    IF    not ${NaoPossuiVendas}
        RETURN
    END

    ${ExisteRegistroSCPC}    Run Keyword And Return Status    Check If Exists In Database    SELECT cspc.CNPJCPF FROM consultaspc cspc WHERE cspc.CodigoCliente = ${Codigo_Cliente} ORDER BY cspc.ID DESC LIMIT 1

    IF    not ${ExisteRegistroSCPC}

        Wait Until Screen Contain    ${TELA_CONSULTA_SCPC_SEM_CONSULTA_SALVA}    ${TEMPO_TELA}

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ESC

        Wait Until Screen Not Contain    ${TELA_CONSULTA_SCPC_SEM_CONSULTA_SALVA}    ${SLEEP_ALTO}

    ELSE

        ${ConsultaSCPC}    Query    SELECT cspc.CNPJCPF FROM consultaspc cspc WHERE cspc.CodigoCliente = ${Codigo_Cliente} ORDER BY cspc.ID DESC LIMIT 1
    
        IF    $ConsultaSCPC[0][0] is None

            Wait Until Screen Contain    ${TELA_CONSULTA_SCPC_SEM_CONSULTA_SALVA}    ${TEMPO_TELA}

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ESC

            Wait Until Screen Not Contain    ${TELA_CONSULTA_SCPC_SEM_CONSULTA_SALVA}    ${SLEEP_ALTO}

        ELSE

            Wait Until Screen Contain    ${TELA_CONSULTA_SCPC_COM_CONSULTA_SALVA}    ${TEMPO_TELA}

            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ESC

            Wait Until Screen Not Contain    ${TELA_CONSULTA_SCPC_COM_CONSULTA_SALVA}    ${SLEEP_ALTO}
         
        END

    END

Valida indicação pré-venda

    IF    ${Parametro_IndicacaoPreVenda}

        ${telaQuemIndicou}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INDICACAO_VENDA}    ${TEMPO_TELA}

        IF    ${telaQuemIndicou}

            Press Special Key    ESC
            Sleep    ${SLEEP_BAIXO}

        END

    END

Valida indicação de venda(${parametro})

    IF    ${parametro}

        ${telaQuemIndicou}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INDICACAO_VENDA}    ${TEMPO_TELA}

        IF    ${telaQuemIndicou}
            
            Sleep    ${SLEEP_BAIXO}
            Press Special Key    ESC

        END
        
    END

Valida vendedor sem percentual de comissão para operações com vale compra
    
    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_VENDEDOR_SEM_PERCENT_COMISSAO_VALE_COMPRA}

    IF    ${aviso}

        Press Special Key    ENTER
        
    END

Valida cliente menor de idade
    
    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_CLIENTE_MENOR_DE_IDADE}

    IF    ${aviso}

        Press Combination    KEY.ALT    KEY.S

        Wait Until Screen Not Contain    ${AVISO_CLIENTE_MENOR_DE_IDADE}    ${SLEEP_ALTO}
        
    END

Valida aviso de alteração de vendedor na pré-venda

    Sleep    ${SLEEP_BAIXO}
    ${vinculoVendedorCliente}    Run Keyword And Return Status    Check If Exists In Database    SELECT c.Codigo FROM clientes c WHERE c.Codigo = ${Codigo_Cliente} AND (c.CodigoVendedor IS NULL OR ${Codigo_Vendedor} IN (c.CodigoVendedor, c.CodVend2));

    IF    not ${vinculoVendedorCliente}

        Wait Until Screen Contain    ${AVISO_ALTERAR_VENDEDOR}    ${SLEEP_ALTO}

        Press Combination    KEY.ALT    KEY.N

        Wait Until Screen Not Contain    ${AVISO_ALTERAR_VENDEDOR}    ${SLEEP_ALTO}
        
    END

Valida aviso atualizar número no cadastro principal

    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_ATUALIZAR_NUMERO_CADASTRO_PRICIPAL}

    IF    ${aviso}

        Press Combination    KEY.ALT    KEY.N
        
    END

Valida parâmetros/impressões pós pré-venda
    
    IF    ${Parametro_ImprimirPreVendaAoFinalizarPreVenda}

        Valida impressão pré-venda ao finalizar pré-venda
        
    END