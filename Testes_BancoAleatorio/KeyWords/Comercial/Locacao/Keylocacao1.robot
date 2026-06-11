*** Settings ***

Documentation    Testes em Banco Aleatório

Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/validaParametros.py
Library    Process
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/verificacoesExtras.py
Variables  ${EXECDIR}/Testes_BancoAleatorio/libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***

# =============================================================
# REPOSITÓRIO DE IMAGENS
# =============================================================
${IMAGENS}                                     ./testes_bancoAleatorio/images

# =============================================================
# CONEXÃO COM O BANCO DE DADOS
# =============================================================
${DBHost}                                      ${config.IpServidor}
${DBName}                                      ${config.Database}
${DBPass}                                      vssql
${DBPort}                                      ${config.Porta}
${DBUser}                                      root

# =============================================================
# SLEEP'S
# =============================================================
${SLEEP_BAIXO}                                 0.7
${SLEEP_MEDIO}                                 1.7
${SLEEP_ALTO}                                  3
${TEMPO_TELA}                                  20

# Telas
${TELA_ORC_ADICIONAR}                 tela_OrcamentoAdicionar.png
${TELA_LANCAMENTO_LOCACAO}            tela_LancamentoLocacao.png

# Botões
${BT_GERAR_PRE_VEN}                   bt_GerarPreVen.png

# Telas Avisos
${AVISO_DESEJA_EXCLUIR}               aviso_DesejaExcluir.png

# Icones
${ICONE_PASTA_STATUS}                 icone_PastaStatusOrcamento.png

# Inputs
${INPUT_QUANTIDADE_SERVICO}           input_QuantidadeServico.png

# Labels
${LABEL_CRITERIO_CODIGO_ORC}          label_CriterioCodigo_Orcamento.png

# Abas
${ABA_PAGAMENTOS}                     aba_Pagamentos.png

# Outros
${GRID_REGISTRO_STATUS_AUTOMACAO}     grid_RegistroStatusAutomacaoOrcamento.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
 #${COD_ORCAMENTO}                      None
 #${Codigos_Servicos}                   ${None}

*** Keywords ***

Dado que acesso a tela lançamento de locação

    Press Combination    KEY.ALT   KEY.P
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    LO
    Wait Until Screen Contain    ${TELA_LANCAMENTO_LOCACAO}    ${TEMPO_TELA}