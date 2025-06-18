*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

Resource    ./utils.robot
Resource    ../KeyWords/MyMonitorFaturamento/KeyMyMonitorFaturamento1.robot

*** Variables ***
#Sleep's    
${SLEEP_BAIXO}                                         0.7
${SLEEP_MEDIO}                                         1.5
${SLEEP_ALTO}                                          3
${TEMPO_TELA}                                          20
#Imagens Tela
${AVISO_CLIENTE_OUTRO_VE}                              aviso_clienteOutroVendedor.png  
${AVISO_ALTERAR_VENDEDOR}                              aviso_DesejaAlterarVendedor.png
${TELA_INFO_CRÉDITOS}                                  tela_InfoCreditos.png 
${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}                    aviso_ExigeSenhaVendedorDiferente.png
${AVISO_CONDICIONAL_ABERTO}                            aviso_CondicionalAbertoVenda.png
${AVISO_CONDICIONAL_ABERTO_COND}                       aviso_CondicionalAberto.png
${ALERTA_CLIENTE}                                      alertaCliente.png
${TELA_SENHA_SUPERVISOR}                               tela_SolicitaSenha.png
${TELA_EXIBE_CLIENTE}                                  tela_exibeCliente.png
${TELA_SELECIONA_TABELA_PRECO}                         tela_TabelasPreco.png
${TELA_VENDAS_ANTERIORES}                              tela_ExibeAnteriores.png
${TELA_INDICACAO_VENDA}                                tela_QuemIndicou.png
${TELA_LIBERAÇÃO_DESCONTO_SENHA}                       tela_liberacaoDesconto.png
${TELA_VENCIMENTO_FIM_DE_SEMANA}                       tela_VencimentoFimDeSemana.png
${BT_NÃO}                                              bt_Nao.png
${TELA_IMPRIMIR_ORDEM_ENTREGA}                         tela_ImprimirOrdemEntrega.png
${TELA_RECIBO_ENTRADA}                                 tela_ReciboEntrada.png 
${TELA_CONTRATO_VENDA}                                 tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}                            tela_EmisssaoPromissoria.png 
${TELA_IMPRESSAO_BOLETO}                               tela_impressaoBoleto.png
${TELA_IMPRESSAO_DUPLICATAS}                           tela_ImpressaoDuplicatas.png
${TELA_EMISSAO_NFC}                                    tela_EmissaoNFC.png 
${TELA_FATURAMENTO_NF}                                 tela_FaturamentoDiretoNF.png  
${TELA_CONFIRMAÇÃO_PAGAMENTO}                          tela_DataPagamento.png
${LABEL_LIBERAÇÃO_SUPERVISOR}                          label_PasseOCartaoDeLiberacao.png
${AVISO_QTDE_SEM_ESTOQUE_ORCAMENTO}                    aviso_qtde_sem_estoque_orcamento.png
${VENDA_A_PRAZO_CLIENTE_1_CONSUMIDOR}                  venda_a_prazo_cliente_1_consumidor.png
${EXPANDIR_COMBOBOX}                                   expandir_combobox.png
${FORMA_PARC_A_VISTA}                                  forma_parc_à_vista.png
${AVISO_VENCIMENTO_FERIADO_DOM_SAB}                    aviso_VencimentoFeriadoSabadoDomingo.png
${TELA_IMPRESSAO_ENTREGA}                              tela_ImpressaoEntrega.png
${AVISO_NÃO_PERMITIDO_MULTIPLAS_VENDAS_POR_ENTREGA}    aviso_NaoPermitidoMultiplasVendasPorEntrega.png
${TELA_ENTREGAS}                                       tela_Entregas.png
${TELA_ORDEM_DE_ENTREGA}                               tela_OrdemDeEntrega.png
${INPUT_DESCRICAO_ENTREGA_PREENCHIDO}                  input_DescricaoEntregaPreenchido.png
${TELA_ENDERECO_ENTREGA_VENDA}                         tela_EnderecoEntregaVenda.png
${AVISO_SELECAO_COI_FATURAMENTO}                       aviso_SelecaoCoiFaturamento.png
${LABEL_COI_NFE}                                       lb_CoiNFe.png

***Keywords***
Verifica se condicional existe(${Codigo_Cliente})

    ${Condicional_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT * FROM condicionais WHERE CodigoCliente = ${Codigo_Cliente} AND `Status` IN ('f','e','a');
    
    IF    ${Condicional_existe}  
        
        Valida condicional aberto

    END

Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})
    
    ${Lista_de_avisos}    Valida Pametros Config

    ${Aviso_vendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    AvisoVendedor
    ${Aviso_infoCredito_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    Aviso_Info_Financeiro
    ${Aviso_ExigeSenhaOutroVendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    ExigeSenhaMudarVendedorVenda

    ${Observacao_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente};

    Set Test Variable    ${Aviso_vendedor_existe}

    Set Test Variable    ${Observacao_existe}

    Valida cadastro padrão de endereço

    IF    ${Observacao_existe}  
            
        Valida observaco cliente

    END

    IF    ${Aviso_ExigeSenhaOutroVendedor_existe}  
        
        Valida aviso exige senha para outro vendedor

    END

    IF    '${TELA}' != 'NFeSaidasManual'

        IF    ${Aviso_Vendedor_Existe_Comissao}  

            Valida aviso cliente outro vendedor

        END
        
    END

    # IF    ${Aviso_Vendedor_Existe_Comissao}  

    #     Valida aviso cliente outro vendedor

    # END

    Verifica se condicional existe(${Codigo_Cliente})

    IF    ${Aviso_infoCredito_existe}  
        
        Valida informações de crédito

    END

    IF    ${Parametro_ExibeVendasAnteriores}

        Valida vendas anteriores 

    END

    IF     ${Parametro_Exibe_Foto_Cliente}

        Valida exibe cliente

    END

    Verifica se cliente possui objeto vinculado

Verifica parametros que interferem na venda
    
    ${Lista_de_pametros}    Valida Pametros Config
    ${Config_Empresas}    Valida Config Empresa

    #Adiciona no campo Vendedor o usuário logado e o no campo cliente o CONSUMIDOR (CÓDIGO 1)
    ${Parametro_VendaRapida} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Venda_Rapida 
    ${Parametro_IncluiDireto} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IncluiDireto
    ${Aviso_ProdutoSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Aviso_Sem_Est
    ${Parametro_IndicacaoVenda} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IndicacaoVenda
    ${Parametro_VendeSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Vende_Sem_Estoque
    ${Parametro_ControlaCredito} =      Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaCreditoClientes
    ${Parametro_Controla_Entrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaEntregaPrevista
    ${Parametro_Local_Negociacao} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    LocalNegociacao
    ${Parametro_ExigeSenhaMultiplo} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Senha_supervisor_multiplo
    ${Parametro_Exibe_Foto_Cliente} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExibeFotoCli
    ${Parametro_Imprime_OrdemEntrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOrdemEntrega
    ${Parametro_ExibeVendasAnteriores} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PVexibeAnteriores
    ${Parametro_Permite_Varias_Tabelas} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PermiteVariasTabelas
    ${Parametro_Impre_Ordem_de_Entrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOrdemEntrega
    ${Parametro_Suprime_Objetos_OS_Orcamento} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    SuprimirOS
    ${Parametro_Desabilita_Servico_Orcamento} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Orc_DesabilitaServico
    ${Parametro_Seleciona_Funcionario_Comissao_Servico} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    SelecionaFunc_OS
    ${Parametro_Fatura_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    FaturarOS
    ${Parametro_Imprime_Carne_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirCarneOS
    ${Parametro_Imprime_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOS
    ${Parametro_VendeSemEstoqueCondicional} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Vende_Sem_Estoque_Condicional
    ${Parametro_ImprimeCondicional} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimiCondicional
    ${Parametro_VendaSemEstoqueOrdemDeServico} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_OS
    ${Parametro_DevolucaoAvulsa} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    DevolucaoAvulsa
    ${Parametro_DevolucaoExigeOBS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExigeObsTroca
    ${Parametro_DevolucaoPermiteAberta} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Dev_PermiteAberta
    ${Parametro_RealizaPreVendaSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_PreVenda
    ${Parametro_RealizaVendaSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_Venda
    ${Parametro_ExigeSenhaCancelarVenda} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExigeSenhaCancelarVenda
    ${Parametro_BloqueiaGeracaoVendaParcial} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PrevendaBloqueioVendaParcial
    ${Parametro_CaixaControladoPorUsuario} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    CaixaUsuario
    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    DescontoFinalIgualmente
    ${Parametro_ImprimeNFCeDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Venda_ImprimeCupom
    ${Parametro_ImprimeVendaDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirVenda_FinalizarVenda
    ${Parametro_ImprimeDuplicataVenda} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirDup_FinalizarVenda
    ${Parametro_BaixaCentralizada} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaCentralizada
    ${Parametro_BaixaAutomatico} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaAutomatico
    ${Caixa_Baixas_Automatica} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    CodigoCX
    ${Parametro_Imprime_Entrada} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpRecEnt_FinalizarVenda
    ${Parametro_Imprime_Contrato_Venda} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirContrato_FinalizarVenda
    ${Parametro_Imprime_Promissoria} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpPromissoria_FinalizarVenda
    ${Parametro_Imprime_Boleto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirBol_FinalizarVenda
    ${Parametro_ValeCompra_Dev_Menor0} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Dev_Ativa_Vale
    ${Parametro_FaturaVendaDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    FaturaVendaDireto
    ${Parametro_BloqueiaOrcamentoSemEstoque} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    OrcamentoComEstoque_Bloq
    ${Parametro_BaixaEstoquePreVenda} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    BaixaEstoquePreVenda
    ${Parametro_ImpressaoAposGerarEntrega} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_ImpressaoEntrega
    ${Parametro_UmaEntregaPorVenda} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_UmaEntregaPorVenda
    ${Parametro_ConsideraDoacoes} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Entrega_ConsideraDoacoes
    ${Parametro_Venda_Padrao_Entregue} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Venda_Padrao_Entregue
    ${Parametro_TrazerDescricaoAutomaticaEntrega} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    TrazerDescricaoAutomaticaEntrega
    ${Parametro_FaturamentoAoFinalizarOS} =    Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    FaturarOS


    IF    ${Parametro_VendaRapida}
            
        Log To Console    \nParametro Venda_Rapida interfere diretamente na venda\nTeste sendo finalizado${\n}Caminho do parametro: ADM Sistema >> +Config >> Geral >> Mais - Trazer vendedor e cliente padrão...
        Terminate Process

    END

    #Sim, essa redundância inútil existe no MyCommerce, em cada tela é validado se primeiro o Parametro de venda sem estoque está marcado
    #Para depois ver se o parametro especifico da tela está marcado para ai sim ver se vai ser incluido ou não.

    IF    ${Parametro_VendeSemEstoque} == ${False}
        
        Log To Console     Parametro de vende sem estoque é falso, logo todos os outros serão falsos

        Set Test Variable    ${Parametro_RealizaPreVendaSemEstoque}    ${False}

        Set Test Variable    ${Parametro_RealizaVendaSemEstoque}    ${False}

        Set Test Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}    ${False}

        Set Test Variable    ${Parametro_VendeSemEstoque}    ${False}
    
    ELSE

        Set Test Variable    ${Parametro_RealizaPreVendaSemEstoque}

        Set Test Variable    ${Parametro_RealizaVendaSemEstoque}

        Set Test Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}
        
        Set Test Variable    ${Parametro_VendeSemEstoque}

    END

    Set Test Variable    ${Parametro_DescontoFinalRespeitaMaximoDosProdutos}

    Set Test Variable    ${Parametro_CaixaControladoPorUsuario}

    Set Test Variable    ${Parametro_FaturaVendaDireto}

    Set Test Variable    ${Parametro_BloqueiaGeracaoVendaParcial}

    Set Test Variable    ${Parametro_ExigeSenhaCancelarVenda}

    Set Test Variable    ${Parametro_DevolucaoPermiteAberta}

    Set Test Variable    ${Parametro_DevolucaoExigeOBS}

    Set Test Variable    ${Parametro_ValeCompra_Dev_Menor0}

    Set Test Variable    ${Parametro_DevolucaoAvulsa}

    Set Test Variable    ${Parametro_Fatura_OS}
    
    Set Test Variable    ${Parametro_Imprime_Carne_OS}

    Set Test Variable    ${Parametro_Imprime_OS}

    Set Test Variable    ${Parametro_Seleciona_Funcionario_Comissao_Servico}

    Set Test Variable    ${Parametro_Suprime_Objetos_OS_Orcamento}

    Set Test Variable    ${Parametro_Desabilita_Servico_Orcamento}

    Set Test Variable    ${Parametro_Imprime_Boleto}

    Set Test Variable    ${Parametro_Imprime_Promissoria}

    Set Test Variable    ${Parametro_Imprime_Contrato_Venda}

    Set Test Variable    ${Parametro_Imprime_Entrada}

    Set Test Variable    ${Parametro_Impre_Ordem_de_Entrega}

    Set Test Variable    ${Parametro_ControlaCredito}

    Set Test Variable    ${Parametro_IndicacaoVenda}

    Set Test Variable    ${Parametro_IncluiDireto}

    Set Test Variable    ${Aviso_ProdutoSemEstoque}

    Set Test Variable    ${Parametro_ImprimeNFCeDireto}

    Set Test Variable    ${Parametro_IndicacaoVenda}

    Set Test Variable    ${Parametro_ImprimeVendaDireto}

    Set Test Variable    ${Parametro_ImprimeDuplicataVenda}

    Set Test Variable    ${Parametro_ExibeVendasAnteriores}

    Set Test Variable    ${Parametro_ExigeSenhaMultiplo}

    Set Test Variable    ${Parametro_BaixaCentralizada}

    Set Test Variable    ${Parametro_BaixaAutomatico}

    Set Test Variable    ${Caixa_Baixas_Automatica}

    Set Test Variable    ${Parametro_Exibe_Foto_Cliente}

    Set Test Variable    ${Parametro_Controla_Entrega}

    Set Test Variable    ${Parametro_Local_Negociacao}

    Set Test Variable    ${Parametro_Imprime_OrdemEntrega}

    Set Test Variable    ${Parametro_Permite_Varias_Tabelas}

    Set Test Variable    ${Parametro_VendeSemEstoqueCondicional}

    Set Test Variable    ${Parametro_ImprimeCondicional}

    Set Test Variable    ${Parametro_BloqueiaOrcamentoSemEstoque}

    Set Test Variable    ${Parametro_BaixaEstoquePreVenda}

    Set Test Variable    ${Parametro_ImpressaoAposGerarEntrega}

    Set Test Variable    ${Parametro_UmaEntregaPorVenda}

    Set Test Variable    ${Parametro_ConsideraDoacoes}

    Set Test Variable    ${Parametro_Venda_Padrao_Entregue}

    Set Test Variable    ${Parametro_TrazerDescricaoAutomaticaEntrega}

    Set Test Variable    ${Parametro_FaturamentoAoFinalizarOS}

Valida aviso exige senha para outro vendedor

    # Sleep    ${SLEEP_MEDIO}
    # ${MSG}    Exists    ${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}
    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}    ${SLEEP_ALTO}

    IF    ${MSG}  
        
        Press Special Key    ENTER

        Wait Until Screen Contain    ${TELA_SENHA_SUPERVISOR}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}
    ${MSG2}    Exists    ${AVISO_ALTERAR_VENDEDOR}

    #Não altera mais para o vendedor padrão por conta dos testes de comissão

    IF    ${MSG} or ${MSG2}

        # ${NOVO_VENDEDOR}     Query    SELECT c.CodigoVendedor FROM clientes AS c WHERE Codigo = ${Codigo_Cliente};

        # Set Test Variable    ${Codigo_Vendedor}    ${NOVO_VENDEDOR[0][0]}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

        # Log To Console    Alterou para o vendedor padrão do cliente - Vendedor Código: ${Codigo_Vendedor}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG}  

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida condicional aberto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_CONDICIONAL_ABERTO}

    ${MSG2}    Exists    ${AVISO_CONDICIONAL_ABERTO_COND}

    IF    ${MSG}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_BAIXO}

    ELSE IF     ${MSG2}

       Press Special Key    ENTER
       Sleep    ${SLEEP_BAIXO}

    END
    
Valida observaco cliente

    ${consulta}     Query    SELECT Observacao FROM clientes WHERE Codigo = ${Codigo_Cliente}
    ${Observacao} =    Set Variable    ${consulta[0][0]}
    
    IF    '${Observacao}' != 'None'

        Sleep    ${SLEEP_MEDIO}
        ${MSG} =     Run Keyword And Return Status    Wait Until Screen Contain    ${ALERTA_CLIENTE}    ${SLEEP_ALTO}
        
        IF    ${MSG}  
        
            Press Combination    KEY.ALT     Key.O
            Sleep    ${SLEEP_MEDIO}

        END

    END


Valida vendas anteriores 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_VENDAS_ANTERIORES}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida exibe cliente

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_EXIBE_CLIENTE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida tabela de preco

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TABELA_PRECO} 

    IF    ${MSG}  
        
        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida indicacao Venda 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_INDICACAO_VENDA}

    IF    ${MSG}  
        
        Press Special Key    ESC 
        Sleep    ${SLEEP_MEDIO}

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

Valida Parametros/Impressões pós venda

    IF    ${Parametro_FaturaVendaDireto}

        Valida faturamento nf
        
    END

    Valida impressao direta de venda(${Parametro_ImprimeVendaDireto})
    
    IF     ${Parametro_Imprime_Boleto}

        Valida impressão de boleto
    
    END

    IF     ${Parametro_Imprime_Entrada}

        Valida impressão de entrada

    END

    IF    ${Parametro_ImprimeNFCeDireto}  
        
        Cancelando Faturando a NFC-e

    END

    IF     ${Parametro_Imprime_Contrato_Venda}

        Valida impressão do contrato de venda

    END

    IF     ${Parametro_Imprime_OrdemEntrega}

        Valida impressão de ordem de entrega

    END

    IF    ${Parametro_ImprimeDuplicataVenda}
        
        Valida Impressao de duplicatas

    END

    IF     ${Parametro_Imprime_Promissoria}

        Valida impressão de Promissórioa

    END

Valida impressão de ordem de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRIMIR_ORDEM_ENTREGA}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de entrada 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_RECIBO_ENTRADA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão do contrato de venda 
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_CONTRATO_VENDA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de Promissórioa 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_EMISSAO_PROMISSÓRIA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de boleto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_BOLETO}

    IF    ${MSG}  

        SikuliLibrary.Click    ${BT_NÃO}
        Sleep    ${SLEEP_MEDIO}

    END

Valida vencimento fim de semana(${VALOR_I})

    FOR    ${I}    IN RANGE    ${VALOR_I}
        
        ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_VENCIMENTO_FIM_DE_SEMANA}    ${SLEEP_MEDIO}

        IF    ${MSG}  

            Press Combination    KEY.ALT     Key.S
            Sleep    ${SLEEP_BAIXO}

        END
        
    END

Valida Impressao de duplicatas 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_DUPLICATAS}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Cancelando Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C


Valida faturamento nf 
    
    ${FaturaDireto} =    Run Keyword And Return Status    Wait Until Screen Contain     ${TELA_FATURAMENTO_NF}    ${TEMPO_TELA}

    IF    ${FaturaDireto}
        
        Press Combination    KEY.ALT     Key.C
        Sleep    ${SLEEP_MEDIO}

    END

Verifica se cliente possui objeto vinculado

    ${Test_OS} =     Run Keyword And Return Status    Should Contain    ${SUITE_NAME}    servico

    ${Test_Com_OS} =     Run Keyword And Return Status    Should Contain    ${TEST_NAME}    servico

    Log To Console    Suite_name: ${SUITE_NAME}

    Set Test Variable    ${Check_List_Objeto}    ${False}

    IF    ${Test_OS} or ${Test_Com_OS}

        ${Objeto_Cliente}    Query    SELECT NumeroSerie, Categoria FROM objetos WHERE CodigoCliente = ${Codigo_Cliente}

        Log To Console    ${Objeto_Cliente}
        
        IF    "${Objeto_Cliente}" != "None"

            ${Check_List_Objeto}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM checklist WHERE Objeto LIKE '${Objeto_Cliente[0][1]}' AND `Status` LIKE 'g'
            
            Log To Console    Possui Check List para o objeto? ${Check_List_Objeto}
            
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

    ${Existe_Form} =     Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_PAGAMENTO}    ${SLEEP_ALTO}
    
    IF    ${Existe_Form}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

    END
    
Valida aviso de quantidade não existente em estoque - Orçamento

    ${Existe_MSG} =    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_QTDE_SEM_ESTOQUE_ORCAMENTO}    ${SLEEP_BAIXO}
    Set Test Variable    ${AVISO_SEM_ESTOQUE}    ${Existe_MSG}

   IF    ${Existe_MSG}
       
        Sleep    ${SLEEP_BAIXO}       
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    BACKSPACE

   END

Valida data de vencimento em feriados, sábados e domingos para pagamentos a prazo

    ${AVISO}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_VENCIMENTO_FERIADO_DOM_SAB}    ${SLEEP_ALTO}

    IF    ${AVISO}
        
        Press Combination    KEY.Alt   KEY.s
        Sleep    ${SLEEP_BAIXO}

    END

Valida telas/avisos presentes ao gerar ordem de entrega

    ${lista_avisos_telas}    valida_Config_Empresa

    ${Parametro_GerarEntregaStatusConcluido} =    Run Keyword And Return Status    Should Contain    ${lista_avisos_telas}    Entrega_StatusConcluido

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
    
    IF    ${Parametro_UmaEntregaPorVenda}

        ${MSG}    Exists    ${AVISO_NÃO_PERMITIDO_MULTIPLAS_VENDAS_POR_ENTREGA}

        IF    ${MSG}

            Press Special Key    ENTER
            Sleep    ${SLEEP_BAIXO}
            
        END

    END

Valida considerar lançamento de ordem de entrega de doações

    IF    '${Parametro_ConsideraDoacoes}' == 'False'
        
        Fail   \nNão habilitado para considerar lançamentos de doações.\nParâmetro: Considerar Lançamentos de Doações: ${Parametro_ConsideraDoacoes}
    
    END

Valida descricao automatica de ordem de entrega

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    IF    '${Parametro_TrazerDescricaoAutomaticaEntrega}' == 'False'

        ${aux} =    Exists    ${INPUT_DESCRICAO_ENTREGA_PREENCHIDO}

        IF    '${aux}' == 'False'

            Input Text    ${EMPTY}    Entrega - Teste Automacao
            Press Special Key    TAB

        ELSE

            Press Special Key    TAB

        END
        
    END

Valida cadastro padrão de endereço
    
    Sleep    ${SLEEP_MEDIO}
    ${msgTela} =    Exists    ${TELA_ENDERECO_ENTREGA_VENDA}

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
        KeyMyMonitorFaturamento1.E acesso a guia 'Configurações'
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Double Click    ${LABEL_COI_NFE}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    DOWN
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        ${salvar}    Set Variable    ${True}
        
    END

    RETURN    ${salvar}