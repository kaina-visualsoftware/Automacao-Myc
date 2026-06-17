*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    DateTime
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/estoque.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Telas
${ABA_A_PAGAR}                                aba_contasAPagar.png
${ABA_A_RECEBER}                              aba_contasAReceber.png
${TELA_CONTAS_A_PAGAR}                        tela_ContasPagar.png
${TELA_RECEBIMENTO_PAGAMENTO}                 caixa_FinalizacaoRecebimentoPagamento.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}          tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                      tela_CaixaPrinicipalCarregando.png
${TELA_CONTAS_A_RECEBER}                      tela_ContasReceber.png
${TELA_RECEBIMENTO_DUPLICATAS}                tela_RecebimentoDuplicatas.png
${TELA_REGISTROS_ESTORNOS}                    tela_RegistrosDeEstornos.png
${TELA_ADIANTAMENTOS}                         tela_Adiantamenos_Caixa.png
${TELA_REC_PAG_RÁPIDO}                        tela_RecPagRápido.png
${TELA_FECHAMENTO_CAIXA}                      tela_FechamentoCaixa.png
${TELA_CAIXA_PRINCIPAL}                       tela_CaixaPrincipal.png

# Telas Avisos
${AVISO_REALMENTE_EFETUAR_BAIXA}              aviso_PerguntaQualquer.png
${AVISO_CONFIRMAÇÃO_BAIXA_CONTA}              aviso_confirmacaoBaixaConta.png

# Botões
${BT_ESTORNAR}                                bt_Estornar.png
${BT_SIM}                                     bt_Sim.png
${BT_SETA_DIREITA_DATAS}                      bt_SetaDireitaDatas.png
${BT_FECHAR_CAIXA}                            bt_FecharCaixa.png

# Outros
${INPUT_NUMERO_DOCUMENTO}                     caixa_PesquisaPorNDoc.png
${INPUT_RAZAO/NOME_VAZIO}                     campo_RazaoSocialNomeVazio.png
${INPUT_NUMERO_VENDA}                         caixa_PesquisaPorNVendac.png
${LABEL_NENHUMA_CONTA_RECEBER}                lb_NenhumaContaPendente.png
${LABEL_APENAS_A_RECEBER}                     label_ApenasAReceber.png
${CHECK_BOX_MARCADO}                          checkBox_Marcado.png
${CHECK_BOX_CONTA_PAGA}                       checkBox_ContaPaga.png
${LABEL_APENAS_A_PAGAR}                       label_ApenasAPagar.png
${CHECK_BOX_CONTAS_PAGA}                      checkBox_Marcado_Selecionado.png
${INPUT_NUMERO_NFS}                           input_NumeroNFS.png
${LABEL_DATA_LANCAMENTO}                      lb_CaixaDataLancamento.png
${INPUT_DATA_LANCAMENTO_A_RECEBER}            input_DataLancamentoAReceber.png
${INPUT_DATA_LANCAMENTO_A_PAGAR}              input_DataLancamentoAPagar.png
${CHECKBOX_CONTA_A_PAGAR}                     checkBox_CaixaContaAPagar.png
${LABEL_STATUS_ABERTO}                        lb_StatusAbertoCaixa.png
${Total_Recebido_Venda}                       ${0}
${LABEL_APENAS_A_RECEBER_HABILITADO}          label_ApenasAReceberHabilitado.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${Forma_Recebimento}                          None
${Forma_Pagamento}                            None
${Codigo_Cliente}                             None
${CODIGO_OPERACAO_MOV}                        None
${VALOR_FINAL_OPERAÇÃO}                       None
${CODIGO_CAIXA}                               None
${Sequencia_Caixa_Abertura}                   None
${COD_DEVOLUCAO}                              None
${Valor_Pago_Parcela}                         None
${N_Documento_Parcelas}                       ${None}
${Controle_Pag_Rec_Diario}                    ${None}
${valor_adiantamento}                         ${None}
${VALOR_RECEBIMENTO_ATUAL}                    ${None}

*** Keywords ***

Dado que acesso a tela do caixa aberto

    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    Wait Until Screen Contain    ${LABEL_STATUS_ABERTO}    ${TEMPO_TELA}

E clico em fechar caixa
    
    SikuliLibrary.Click    ${BT_FECHAR_CAIXA}
    Wait Until Screen Contain   ${TELA_FECHAMENTO_CAIXA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então cancelo o fechamento do caixa

    Press Combination    KEY.ALT    KEY.C
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    Wait Until Screen Contain    ${LABEL_STATUS_ABERTO}    ${TEMPO_TELA}

E fecho a tela do caixa principal

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Not Contain   ${TELA_CAIXA_PRINCIPAL}    ${TEMPO_TELA}