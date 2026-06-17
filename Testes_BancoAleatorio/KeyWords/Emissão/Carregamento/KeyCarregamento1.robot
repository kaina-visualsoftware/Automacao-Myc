*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/validaParametros.py
Library    Process
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/verificacoesExtras.py
Variables    ${EXECDIR}/Testes_BancoAleatorio/libs/leituraConfig.py

Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Pré-Venda/Geracao Venda/KeyGeracaoDeVenda1.robot


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

# =============================================================
# TELAS PRINCIPAIS
# =============================================================
${MENU_EMISSÃO}                                menu_Emissão.png
${SUBMENU_CARREGAMENTO}                 subMenu_Carregamento.png
${TELA_GERACAO_VENDAS}                         tela_GeracaoVenda.png
${TELA_CARREGAMENTOS}                          tela_Carregamentos.png
${TELA_CADASTRO_CARREGAMENTO}                  tela_CadastroCarregamento.png
${TELA_INCLUSAO_ROTAS}                         tela_InclusaoRotas.png
${TELA_IMPRESSAO}                              tela_Impressao.png
${TELA_PEDIDOS_ROTA}                           tela_Pedidosrota.png

${TELA_CARREGAMENTO_ADICIONAR}          tela_CarregamentoAdicionar.png
${TELA_CONTAS_A_RECEBER_CARREGAMENTO}   tela_ContasReceberCarregamento.png
${TELA_GERACAO_LOTE_COBRANCA_CARREGAMENTO}    tela_GeracaoLoteCobrancaCarregamento.png
${TELA_EMBARQUE}                        tela_EmbarqueDesembarqueCargas.png
${AVISO_CLIENTE_NAO_CADASTRADO}         aviso_ClienteNaoCadastrado.png

# =============================================================
# TELAS DE AVISOS
# =============================================================
${AVISO_EXCLUSAO_STATUS_FECHADO}               aviso_ExclusaoStatusFechado.png
${AVISO_CARGA_MONTADA}                         aviso_CargaMontada.png
${AVISO_EXCLUIR_CARREGAMENTO}                  aviso_ExcluirCarregamento.png
${AVISO_CANCELAR_CARREGAMENTO}                 aviso_CancelarCarregamento.png
${AVISO_FECHAR_SEM_MONTAR_MAPA}                aviso_FecharSemMontarMapa.png
${AVISO_EXCLUSAO_STATUS_MONTANDO}              aviso_ExclusaoStatusMontando.png
${AVISO_DESCRICAO_OBRIGATORIA}                 aviso_DescricaoObrigatoriaCarga.png
${AVISO_PERGUNTA_QUALQUER}                     aviso_PerguntaQualquer.png
${AVISO_EXCLUIR_CARREGAMENTO_FECHADO}   aviso_ExcluirCarregamentoFechado.png

# =============================================================
# GRIDS
# =============================================================
${GRID_ROTA_CARREGAMENTO}                      grid_RotaCarregamento.png
${GRID_CARREGAMENTO_INCLUIDO}                  grid_CarregamentoIncluido.png
${GRID_PEDIDO_INCLUIDO}                        grid_Pedidoincluido.png

# =============================================================
# BOTÕES
# =============================================================
${BT_SETA_INCLUIR_PRODUTO_ENTREGA}             bt_SetaIncluirProdutoEntrega.png
${BT_ADICIONAR_CARREGAMENTO}                   bt_AdicionarCarregamento.png
${BT_INCLUIR_ROTAS}                            bt_IncluirRotas.png
${BT_SETA_INCLUSÃO_ROTAS_CARREGAMENTO}         bt_SetaIncluirRotasCarregamento.png
${BT_MONTAR_CARGA}                             bt_MontarCarga.png
${BT_FECHAR_CARGA}                             bt_FecharCarga.png
${BT_IMPRIMIR_MAPA_ROTA}                       bt_ImprimirMapaRota.png
${BT_OK_SEM_ATALHO}                            bt_OK_sem_atalho.png
${BT_SETA_REMOÇÃO_ROTAS_CARREGAMENTO}          bt_SetaRemoverRotasCarregamento.png
${BT_INCLUIR_VENDA_CARREGAMENTO}        bt_IncluirCarregamentoVenda.png
${BT_INCLUIR_COBRANÇA_CARREGAMENTO}     bt_IncluirCarregamentoCobranca.png
${BT_EMBARCAR}                          bt_Embarcar.png


# Checkbox
${CHECKBOX_TODOS_ITENS}                 checkbox_SelecionadoTodosCarregamentoVenda.png
${CHECKBOX_COBRANCA_CARREGAMENTO}       checkbox_ContasaReceberCobrancaCarregamento.png

# LABEL
${LB_NVENDA_CARREGAMENTO}               lb_NVendaCarregamento.png
${LB_NDOCUMENTO}                        lb_NDocumento.png

# =============================================================
# INPUTS
# =============================================================
${INPUT_DESCRICAO_CARREGAMENTO}                input_DescricaoCarregamento.png
${INPUT_PESQUISA_CARREGAMENTO}                 input_PesquisaCarregamento.png
${INPUT_PALETES_CARREGAMENTO}                  input_PaletesCarregamento.png
${INPUT_CODCOBRADOR_CARREGAMENTO}       input_CodCobrador.png



# =============================================================
# ÍCONES
# =============================================================
${ICONE_LUPA_GERACAO_VENDAS}                    icone_LupaGeracaoVendas.png

# =============================================================
# OUTROS
# =============================================================
${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}             grid_PedidosOrdemDeEntregaNovo.png

# =============================================================
# VARIÁVEIS DE OPERAÇÃO (inicializadas em runtime via Set Test Variable)
# =============================================================
${COD_VENDA}                                   None
${COD_DOACAO}                                  None
${ID_GRUPO_ENTREGA}                            None
${Codigos_Vendas}                              ${None}
${Quantidade_Vendas_Feitas}                    None
${Codigo_Vendedor}                             None
${Codigo_Cliente}                              None
${COD_CARREGAMENTO}                            None
${ROTA}                                        None
${ROTA_1}                                      None
${ROTA_2}                                      None
${VOLUME_CARREGAMENTO}                         None
${VOLUME_INICIAL}                              None
${LISTA_ROTAS}                                 None
${QTD_VENDAS_INCLUIDAS}                        None
@{ULTIMAS_VENDAS}
${COD_MOTORISTA}                               None
${COD_ENTREGADOR}                              None
${DOC_ADIANTAMENTO}                            None
${TOTAL_ADIANTAMENTO}                          None

*** Keywords ***

# =============================================================
# KEYS CARREGAMENTO DE PREVENDA - VINICIUS
# =============================================================

Ler imagens iniciais
    Add Image Path    ${IMAGENS}

# =============================================================
# BANCO DE DADOS - CONSULTAS
# =============================================================

Seleciona vendedor

    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codVendedor[0][0]}

Seleciona cliente com rota

    [Arguments]    ${ROTA}

    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) AND Codigo <> 1 AND c.Rota = ${ROTA} ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    IF    len($codCliente) == 0
        Fail    Nenhum cliente com rota foi encontrado.
    END

    RETURN    ${codCliente[0][0]}

Seleciona cliente com rota aleatória

    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) AND Codigo <> 1 AND c.Rota IS NOT NULL ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    IF    len($codCliente) == 0
        Fail    Nenhum cliente com rota foi encontrado.
    END

    RETURN    ${codCliente[0][0]}

Buscar Rotas Distintas Com Clientes

    [Arguments]    ${QUANTIDADE_ROTAS}

    ${rotas}    Query    SELECT DISTINCT Rota FROM clientes WHERE (Tipo LIKE 'C' OR Tipo LIKE 'A') AND Ativo = -1 AND Status = 'ATIVA' AND CreditoCortado = 0 AND Codigo <> 1 AND Rota IS NOT NULL ORDER BY RAND() LIMIT ${QUANTIDADE_ROTAS};

    IF    len($rotas) < ${QUANTIDADE_ROTAS}
        Fail    Não foram encontradas ${QUANTIDADE_ROTAS} rotas distintas com clientes ativos no ambiente.
    END

    ${LISTA_ROTAS}    Create List
    FOR    ${rota}    IN    @{rotas}
        Append To List    ${LISTA_ROTAS}    ${rota[0]}
    END

    Set Test Variable    ${ROTA_1}    ${rotas[0][0]}

    Set Test Variable    ${ROTA_2}    ${rotas[1][0]}
    
    Set Test Variable    ${LISTA_ROTAS}

Valida Carregamento gerado

    ${Consulta}    Query    SELECT Sequencia FROM cargas ORDER BY Sequencia DESC LIMIT 1;

    Set Test Variable    ${COD_CARREGAMENTO}    ${Consulta[0][0]}

# =============================================================
# PRÉ-VENDA - CRIAÇÃO DE CENÁRIOS
# =============================================================

Quando adiciono um Vendedor e um Cliente com rota

    [Arguments]    ${ROTA}=${EMPTY}

    Set Test Variable    ${TELA}    Pedido

    # --- VENDEDOR ---
    ${codVendedor}    Seleciona vendedor

    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    # --- CLIENTE COM ROTA ---
    IF    '${ROTA}' == '${EMPTY}'

        ${codCliente}    Seleciona cliente com rota aleatória

    ELSE

        ${codCliente}    Seleciona cliente com rota    ${ROTA}
    END

    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Keypedidos1.Valida avisos após incluir cliente e vendedor - Pré-Venda

# =============================================================
# PRÉ-VENDA - TELA DE PEDIDOS (DENTRO DO CARREGAMENTO)
# =============================================================

E abro a tela de pedido

    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.A
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_PEDIDOS_ROTA}    ${TEMPO_TELA}

Quando removo uma pré-venda

    Sleep    ${SLEEP_BAIXO}

    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}    

    Press Combination    KEY.ALT    KEY.R

    Wait Until Screen Contain    ${AVISO_PERGUNTA_QUALQUER}    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_MEDIO}

E fecho a tela de pedido

    Press Combination    KEY.ALT    KEY.F

    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Not Contain    ${TELA_PEDIDOS_ROTA}    ${SLEEP_BAIXO}

E removo um pedido da rota

    E abro a tela de pedido

    Quando removo uma pré-venda

    E fecho a tela de pedido

    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}   ${TEMPO_TELA}

E removo um dos pedidos da rota

    E clico em Incluir Rotas

    Quando seleciono a rota incluída

    E removo um pedido da rota

# =============================================================
# TELA DE GERAÇÃO DE VENDAS
# =============================================================

E listo pela tela de Geração de vendas

    KeyGeracaoDeVenda1.Dado que acesso a tela de geração de vendas

    Press Combination    KEY.ALT    KEY.L

    Wait Until Screen Not Contain    ${ICONE_LUPA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Not Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}

# =============================================================
# TELA DE CARREGAMENTO - NAVEGAÇÃO
# =============================================================

Dado que acesso a tela de Carregamento

    Sleep    ${SLEEP_BAIXO}

    Type With Modifiers    T    CTRL

    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${TELA_CARREGAMENTOS}
    Sleep    ${SLEEP_BAIXO}

Quando pesquiso o Carregamento gerado

    SikuliLibrary.Click    ${INPUT_PESQUISA_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${COD_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

E fecho a tela de carregamento
    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${TELA_CARREGAMENTOS}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Not Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

# =============================================================
# TELA DE CARREGAMENTO - CRIAÇÃO E EDIÇÃO
# =============================================================

E clico para adicionar um carregamento

    Press Combination    KEY.ALT    KEY.A
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

Quando adiciono uma Descrição qualquer e incluo um palete

    SikuliLibrary.Click    ${INPUT_DESCRICAO_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Informar Descrição    CARREGAMENTO PREVENDA
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.click    ${INPUT_PALETES_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

Informar Descrição
    [Arguments]    ${DESCRICAO}

    Valida carregamento gerado
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Input Text    ${EMPTY}    ${DESCRICAO} - ${COD_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

Então edito o carregamento

    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

E adiciono um carregamento com rota sem informar descrição

    E clico para adicionar um carregamento

    SikuliLibrary.Click    ${INPUT_PALETES_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

    E clico em Incluir Rotas

    Então eu Listo as Rotas

    E gravo incluindo rotas da lista    1

# =============================================================
# TELA DE CARREGAMENTO - GERENCIAMENTO DE ROTAS
# =============================================================

E clico em Incluir Rotas

    SikuliLibrary.Click    ${BT_INCLUIR_ROTAS}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_INCLUSAO_ROTAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então eu Listo as Rotas

    Press Combination    KEY.ALT    KEY.L
    Sleep    ${SLEEP_BAIXO}

E gravo incluindo rotas da lista

    [Arguments]    ${QUANTIDADE_ROTAS}

    SikuliLibrary.Click    ${GRID_ROTA_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${index}    IN RANGE    ${QUANTIDADE_ROTAS}

        Press Special Key    SPACE
        Sleep    ${SLEEP_BAIXO}

        IF    ${index} < (${QUANTIDADE_ROTAS} - 1)

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

    END

    SikuliLibrary.Click    ${BT_SETA_INCLUSÃO_ROTAS_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain
    ...    ${TELA_CADASTRO_CARREGAMENTO}
    ...    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}

E incluo uma rota ao carregamento

    E clico em Incluir Rotas

    Então eu Listo as Rotas

    E gravo incluindo rotas da lista    1

E removo uma rota do carregamento

    E clico em Incluir Rotas

    Quando removo a rota selecionada

    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando removo a rota selecionada

    Wait Until Screen Contain    ${GRID_CARREGAMENTO_INCLUIDO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${GRID_CARREGAMENTO_INCLUIDO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${BT_SETA_REMOÇÃO_ROTAS_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

Quando seleciono a rota incluída

    Wait Until Screen Contain    ${GRID_CARREGAMENTO_INCLUIDO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${GRID_CARREGAMENTO_INCLUIDO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}

# =============================================================
# TELA DE CARREGAMENTO - AÇÕES DE CARGA (MONTAR / FECHAR / GRAVAR)
# =============================================================

Quando eu Monto a Carga

    SikuliLibrary.Click    ${BT_MONTAR_CARGA}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${AVISO_CARGA_MONTADA}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

Quando Imprimo o mapa da rota

    SikuliLibrary.Click    ${BT_IMPRIMIR_MAPA_ROTA}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

E em seguida fecho a carga

    SikuliLibrary.Click    ${BT_FECHAR_CARGA}
    Sleep    ${SLEEP_BAIXO}

Então Gravo o carregamento

    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}

    Valida Carregamento gerado

Então gravo o carregamento com o status

    [Arguments]    ${STATUS}

    IF    '${STATUS}' == 'Fechada'

        Quando eu monto a carga

        Quando imprimo o mapa da rota

        E em seguida fecho a carga
        
    ELSE IF    '${STATUS}' == 'Montando'

        Quando eu monto a carga

    ELSE IF    '${STATUS}' == 'Cadastrando'

        Log To Console    Nenhuma ação necessária

    ELSE

        Fail    Status inválido informado: ${STATUS}

    END

    Então Gravo o carregamento

    E valido que o carregamento está com o status    ${STATUS}

Quando eu tento montar a carga sem descrição

    SikuliLibrary.Click    ${BT_MONTAR_CARGA}
    Sleep    ${SLEEP_BAIXO}

E informo uma descrição

    SikuliLibrary.Click    ${INPUT_DESCRICAO_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

    Informar Descrição    CARREGAMENTO PREVENDA

Então valido a mensagem de descrição obrigatória 

    Wait Until Screen Contain    ${AVISO_DESCRICAO_OBRIGATORIA}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain
    ...    ${TELA_CADASTRO_CARREGAMENTO}
    ...    ${TEMPO_TELA}

# =============================================================
# TELA DE CARREGAMENTO - EXCLUSÃO
# =============================================================

E excluo o carregamento

    Press Combination    KEY.ALT    KEY.X

    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Contain    ${AVISO_CANCELAR_CARREGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    ${carregamento_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} AND Cancelado = 1
    Sleep    ${SLEEP_BAIXO}

    Should Be True    ${carregamento_excluido}    Carregamento não foi excluído corretamente.

# =============================================================
# VALIDAÇÕES DE REGRA DE NEGÓCIO
# =============================================================

Então tento fechar a carga sem montar e imprimir o mapa

    Quando tento fechar a carga sem montar e imprimir o mapa

    Então fecho a validação de fechar sem montar e imprimir o mapa

Quando tento fechar a carga sem montar e imprimir o mapa

    SikuliLibrary.Click    ${BT_FECHAR_CARGA}
    Sleep    ${SLEEP_BAIXO}

Então fecho a validação de fechar sem montar e imprimir o mapa

    Wait Until Screen Contain    ${AVISO_FECHAR_SEM_MONTAR_MAPA}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

E valido que um carregamento com status não pode ser excluído

    [Arguments]    ${STATUS}

    Press Combination    KEY.ALT    KEY.X

    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S

    IF    '${STATUS}' == 'Fechada'

        Wait Until Screen Contain    ${AVISO_EXCLUSAO_STATUS_FECHADO}    ${TEMPO_TELA}

    ELSE IF    '${STATUS}' == 'Montando'

        Wait Until Screen Contain    ${AVISO_EXCLUSAO_STATUS_MONTANDO}    ${TEMPO_TELA}

    ELSE

        Fail    Status inválido informado: ${STATUS}

    END

    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}

    ${carregamento_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} AND Cancelado IS NULL
    Sleep    ${SLEEP_BAIXO}

    Should Be True    ${carregamento_excluido}    Carregamento foi excluído indevidamente

E valido que o carregamento está com o status

    [Arguments]    ${STATUS}
    
    ${carregamento_existe}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} AND Status = '${STATUS}'
    Should Be True
    ...    ${carregamento_existe}
    ...    Carregamento pesquisado não está com o status ${STATUS}

E valido que o carregamento contém as rotas esperadas

    ${rotas}    Query    SELECT CodigoRota FROM cargas_rotas WHERE CodigoCarregamento = ${COD_CARREGAMENTO} ORDER BY CodigoRota;

    ${quantidade}    Get Length    ${rotas}

    Should Be Equal As Integers    ${quantidade}    ${LISTA_ROTAS.__len__()}
    ...    O carregamento contém ${quantidade} rotas, mas deveria conter ${LISTA_ROTAS.__len__()}.

    ${rotas_encontradas}    Evaluate    sorted([r[0] for r in $rotas])

    ${rotas_esperadas}    Evaluate    sorted(${LISTA_ROTAS})

    Should Be Equal    ${rotas_encontradas}    ${rotas_esperadas}
    ...    As rotas do carregamento não correspondem às rotas das pré-vendas criadas.

E obtenho o volume atual do carregamento

    ${volume}    Query    SELECT Volume FROM cargas WHERE Sequencia = ${COD_CARREGAMENTO};

    IF    len($volume) > 0

        Set Test Variable    ${VOLUME_CARREGAMENTO}    ${volume[0][0]}
        
    ELSE
        Fail    Carregamento não encontrado no banco de dados.
    END

E valido o volume inicial do carregamento como cadastrando

    E obtenho o volume atual do carregamento

    ${VOLUME_INICIAL}    Set Variable    ${VOLUME_CARREGAMENTO}

    Set Test Variable    ${VOLUME_INICIAL}    ${VOLUME_INICIAL}

    Log To Console    *** VALIDAÇÃO 1: Volume inicial (Cadastrando) = ${VOLUME_INICIAL} pré-vendas

E valido que o volume do carregamento é

    [Arguments]    ${VOLUME_ESPERADO}

    ${volume}    Query    SELECT Volume FROM cargas WHERE Sequencia = ${COD_CARREGAMENTO};
    
    IF    len($volume) == 0

        Fail    Carregamento não encontrado no banco de dados.

    END
    
    ${volume_atual}    Set Variable    ${volume[0][0]}

    Should Be Equal As Integers    ${volume_atual}    ${VOLUME_ESPERADO}

    ...    O volume do carregamento é ${volume_atual}, mas era esperado ${VOLUME_ESPERADO}

E valido o volume após remover uma pré-venda

    ${VOLUME_ESPERADO}    Evaluate    ${VOLUME_INICIAL} - 1

    Log To Console    *** VALIDAÇÃO 2: Volume esperado (Montando) = ${VOLUME_ESPERADO} pré-vendas (${VOLUME_INICIAL} - 1)

    E valido que o volume do carregamento é    ${VOLUME_ESPERADO}

# =============================================================
# KEYS CARREGAMENTO DE VENDA - KAINA
# =============================================================

Iniciar novo carregamento

    Clicar no botão Adicionar

    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}

    Setar codigo carregamento


Setar codigo carregamento

    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL ORDER BY c.Sequencia DESC LIMIT 1

    IF    not ${resultado}

        RETURN    0

    END

    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}


Preencher descrição com o código do carregamento

    ${descricao}=    Catenate    SEPARATOR=    AUTOMACAO -    ${COD_CARREGAMENTO}

    SikuliLibrary.Input Text    ${EMPTY}    ${descricao}
    Sleep    ${SLEEP_BAIXO}


E gravo o carregamento da venda

    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}

    Clicar no botão Gravar

    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}


Fechar tela de carregamento

    Run Keyword And Ignore Error    Press Special Key    ESC


Pesquisar carregamento por código
    [Arguments]    ${codigo}

    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${codigo}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}


Limpar filtro de pesquisa

    Press Combination    KEY.ALT    KEY.P

    Input Text    ${EMPTY}    ${EMPTY}
    
    Press Special Key    ENTER


Editar carregamento existente

    Clicar no botão Editar

    Sleep    ${SLEEP_BAIXO}


Excluir carregamento existente

    ${aviso_excluir}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    3

    IF    ${aviso_excluir}

        Press Combination    KEY.ALT    KEY.S

    END

    ${aviso_cancelar}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CANCELAR_CARREGAMENTO}    3

    IF    ${aviso_cancelar}

        Press Combination    KEY.ALT    KEY.S

    END

Clicar no botão Incluir Venda no carregamento

    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_VENDA_CARREGAMENTO}    5

    IF    ${existe}

        SikuliLibrary.Click    ${BT_INCLUIR_VENDA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}

    END


Abrir tela de listagem de vendas

    Clicar no botão Incluir Venda no carregamento

    Clicar no botão Listar


Selecionar a próxima venda disponível

    ${COD_VENDA}=    Pegar próxima venda disponível

    Log    Selecionando venda código: ${COD_VENDA}

   ${CHECKBOX_TODOS_ITENS_BOOL}=    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_TODOS_ITENS}    15

    IF    ${CHECKBOX_TODOS_ITENS_BOOL}

        SikuliLibrary.Click    ${CHECKBOX_TODOS_ITENS}    2    
        Sleep    ${SLEEP_BAIXO}

    END

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB

    END

    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}
    SikuliLibrary.Click    ${LB_NVENDA_CARREGAMENTO}
    
    Input Text    ${EMPTY}    ${COD_VENDA}

    Press Special Key    LEFT

    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}

    Clicar no botão Adicionar


Pegar próxima venda disponível

    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Cancelada IS NULL AND v.CodigoCarregamento IS NULL ORDER BY v.Codigo DESC LIMIT 1

    RETURN    ${resultado[0][0]}


Pegar quantidade de vendas incluídas no carregamento

    Log    Consultando quantidade de vendas incluídas no carregamento ${COD_CARREGAMENTO}

    ${resultado}=    Query    SELECT COUNT(*) FROM vendas v WHERE v.CodigoCarregamento = ${COD_CARREGAMENTO} AND v.Cancelada IS NULL

    ${tamanho}=    Get Length    ${resultado}

    IF    ${tamanho} == 0

        RETURN    0

    END

    RETURN    ${resultado[0][0]}


Pegar ultimas vendas do carregamento

    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.CodigoCarregamento = ${COD_CARREGAMENTO} ORDER BY v.Codigo DESC

    IF    not ${resultado}

        RETURN    ${EMPTY}

    END

    ${VENDAS}=    Evaluate    [item[0] for item in $resultado]

    RETURN    ${VENDAS}

Clicar no botão Incluir Cobrança no carregamento

    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}    5

    IF    ${existe}

        SikuliLibrary.Click    ${BT_INCLUIR_COBRANÇA_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}

    END


Abrir tela de listagem de cobranças

    Clicar no botão Incluir Cobrança no carregamento

    IF    ${INPUT_CODCOBRADOR_CARREGAMENTO}

        SikuliLibrary.Click    ${INPUT_CODCOBRADOR_CARREGAMENTO}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    2

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END

    Clicar no botão Listar

    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    ${TEMPO_TELA}


Incluir cobrança no carregamento
    @{ULTIMAS_VENDAS}=    Pegar ultimas vendas do carregamento

    Abrir tela de listagem de cobranças
    
    FOR    ${COD_VENDA}    IN    @{ULTIMAS_VENDAS}

        ${DOCUMENTO}=    Pegar documento da venda sem cobrança    ${COD_VENDA}

        Selecionar cobrança pelo documento    ${DOCUMENTO}

    END

    Aguardar tela de cobrança fechar

    Clicar no botão Gravar


Verificar se existe cobrança a incluir

    @{ULTIMAS_VENDAS}=    Pegar ultimas vendas do carregamento

    ${EXISTE}=    Set Variable    ${FALSE}

    FOR    ${COD_VENDA}    IN    @{ULTIMAS_VENDAS}

        ${DOCUMENTO}=    Pegar documento da venda sem cobrança    ${COD_VENDA}

        IF    "${DOCUMENTO}" != "${EMPTY}"

            ${EXISTE}=    Set Variable    ${TRUE}

            BREAK

        END

    END

    RETURN    ${EXISTE}


Selecionar cobrança pelo documento
    [Arguments]    ${DOCUMENTO}

    # Limpa filtro e busca pelo documento
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    # Seleciona a cobrança encontrada
    ${CHECKBOX_COBRANCA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${CHECKBOX_COBRANCA_CARREGAMENTO}    5

    IF    ${CHECKBOX_COBRANCA}

        SikuliLibrary.Click    ${CHECKBOX_COBRANCA_CARREGAMENTO}

        Sleep    ${SLEEP_BAIXO}
        
    END

    # Confirma seleção
    Press Combination    KEY.ALT    KEY.O
    Sleep    ${SLEEP_MEDIO}


Aguardar tela de cobrança fechar

    FOR    ${I}    IN RANGE    15

        ${TELA_ABERTA}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_CONTAS_A_RECEBER_CARREGAMENTO}    0.1

        IF    not ${TELA_ABERTA}

            BREAK

        END

        Sleep    ${SLEEP_MEDIO}

    END

Pegar documento da venda sem cobrança

    [Arguments]    ${COD_VENDA}

    ${resultado}=    Query    SELECT cr.NDocumento FROM contasareceber cr LEFT JOIN cobrancas_detalhes cbd ON cr.Sequencia = cbd.SequenciaCR WHERE cr.CodigoVenda = ${COD_VENDA} AND cbd.SequenciaCR IS NULL

    IF    not ${resultado}

        Log    Nenhum documento sem cobrança para venda ${COD_VENDA}

        RETURN    ${EMPTY} 

    END

    RETURN    ${resultado[0][0]}


Cancelar operação e fechar tela
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Fechar tela de carregamento

Navegar para próximo campo
    [Arguments]    ${QTD_TABS}

    FOR    ${I}    IN RANGE    ${QTD_TABS}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END


Acessar tela de embarque
    ${existe}=    Run Keyword And Return Status    Wait Until Screen Contain    ${BT_EMBARCAR}    5

    IF    ${existe}

        SikuliLibrary.Click    ${BT_EMBARCAR}
        Sleep    ${SLEEP_BAIXO}

    END

    Wait Until Screen Contain    ${TELA_EMBARQUE}    ${TEMPO_TELA}


Preencher dados do veículo no embarque
    
    [Arguments]    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}

    Press Special Key    HOME

    ${POSICAO}=    Obter posição do estado no combobox    ${UF}

    FOR    ${I}    IN RANGE    ${POSICAO}

        Press Special Key    DOWN

    END

    Navegar para próximo campo    1

    Input Text    ${EMPTY}    ${PLACA}

    Navegar para próximo campo    1

    Input Text    ${EMPTY}    ${KM_SAIDA}

    Navegar para próximo campo    1

    Input Text    ${EMPTY}    ${KM_CHEGADA}

    Navegar para próximo campo    1

    Input Text    ${EMPTY}    ${LITROS}

    Navegar para próximo campo    1


Obter posição do estado no combobox
    [Arguments]    ${UF}

    ${ESTADOS}=    Create List    ${EMPTY}    AC    AL    AP    AM    BA    CE    DF    ES    GO    MA    MG    MS    MT    PA    PB    PE    PI    PR    RJ    RN    RO    RR    RS    SC    SE    SP    TO    EX

    ${POSICAO}=    Get Index From List    ${ESTADOS}    ${UF}

    RETURN    ${POSICAO}


Preencher código do motorista

    [Arguments]    ${COD_MOTORISTA}

    Input Text    ${EMPTY}    ${COD_MOTORISTA}

    Navegar para próximo campo    1
    Sleep    ${SLEEP_MEDIO}

    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO}    2

    IF    ${AVISO}

        Clicar no botão Ok

        ${NOVO_COD}=    Obter código do cliente diferente    D    ${COD_MOTORISTA}

        Preencher código do motorista    ${NOVO_COD}

    END


Preencher código do entregador
    [Arguments]    ${COD_ENTREGADOR}

    Input Text    ${EMPTY}    ${COD_ENTREGADOR}

    Navegar para próximo campo    1
    Sleep    ${SLEEP_MEDIO}

    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO}    2

    IF    ${AVISO}

        Clicar no botão Ok

        ${NOVO_COD}=    Obter código do cliente diferente    V    ${COD_ENTREGADOR}

        Preencher código do entregador    ${NOVO_COD}

    END


Obter código do cliente diferente
    [Arguments]    ${TIPO}    ${COD_ATUAL}

    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 AND c.Codigo != ${COD_ATUAL} LIMIT 1

    IF    not ${resultado}

        ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 LIMIT 1

    END

    Should Not Be Empty    ${resultado}

    RETURN    ${resultado[0][0]}


Obter código do cliente
    [Arguments]    ${TIPO}

    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.Tipo = '${TIPO}' AND c.Ativo = -1 LIMIT 1

    Should Not Be Empty    ${resultado}
    
    RETURN    ${resultado[0][0]}


Preencher dados do adiantamento

    [Arguments]    ${DOC}    ${TOTAL}

    Navegar para próximo campo    2

    Input Text    ${EMPTY}    ${DOC}

    Navegar para próximo campo    1

    Input Text    ${EMPTY}    ${TOTAL}

    Sleep    ${SLEEP_BAIXO}


Gerar dados do adiantamento
    ${DOC}=    Evaluate    random.randint(100000,999999)

    ${TOTAL}=    Evaluate    random.randint(100,1000)

    Set Test Variable    ${DOC_ADIANTAMENTO}    ${DOC}

    Set Test Variable    ${TOTAL_ADIANTAMENTO}    ${TOTAL}
    

Salvar embarque
    Clicar no botão Gravar
    Sleep    ${SLEEP_MEDIO}


Validar adiantamento no banco
    ${resultado}=    Query    SELECT ca.Documento, ca.Valor FROM cargas_adiantamento ca WHERE ca.CodigoCarga = ${COD_CARREGAMENTO} AND ca.Cancelado IS NULL

    Should Not Be Empty    ${resultado}

    Should Be Equal As Strings    ${resultado[0][0]}    ${DOC_ADIANTAMENTO}

    Should Be Equal As Numbers    ${resultado[0][1]}    ${TOTAL_ADIANTAMENTO}


Validar dados do adiantamento na tabela cargas
    ${resultado}=    Query    SELECT c.CodMotorista, c.CodEntregador, c.UFPlaca, c.Placa, c.KMSaida, c.KMChegada, c.QtdeLitros_Comb, c.ValorAdiantamento FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO}

    Should Not Be Empty    ${resultado}

    Set Test Variable    ${COD_MOTORISTA}    ${resultado[0][0]}

    Set Test Variable    ${COD_ENTREGADOR}    ${resultado[0][1]}

    Log    Motorista: ${resultado[0][0]} | Entregador: ${resultado[0][1]} | UF: ${resultado[0][2]} | Placa: ${resultado[0][3]}

    Log    KM Saída: ${resultado[0][4]} | KM Chegada: ${resultado[0][5]} | Litros: ${resultado[0][6]} | Valor Adiantamento: ${resultado[0][7]}


Quando inicio um novo carregamento
    Clicar no botão Adicionar
    
    Wait Until Screen Contain    ${TELA_CARREGAMENTO_ADICIONAR}    ${TEMPO_TELA}

    Setar codigo carregamento


Quando pesquiso o carregamento
    [Arguments]    ${codigo}
    Pesquisar carregamento por código    ${codigo}


Quando limpo o filtro da pesquisa
    Limpar filtro de pesquisa


Quando edito o carregamento cadastrado
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Clicar no botão Editar


Quando excluo o carregamento
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Clicar no botão Excluir
    Excluir carregamento existente


E informo uma descrição valida
    Informar Descrição    AUTOMACAO
    Sleep    ${SLEEP_BAIXO}


Então o carregamento da venda deve ser salvo com sucesso
    Log    Verificando status do carregamento ${COD_CARREGAMENTO}

    ${carregamento_bool}=    Query    SELECT c.Status FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL
    Should Not Be Empty    ${carregamento_bool}
    
    IF    not ${carregamento_bool}

        Fail    O carregamento não foi salvo com sucesso. Status atual: ${carregamento_bool[0][0]}

    END


Então o status deve ser
    [Arguments]    ${status}

    Log    Verificando status do carregamento ${COD_CARREGAMENTO}
    
    ${resultado}=    Query    SELECT c.Status FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL

    Should Not Be Empty    ${resultado}

    Should Be Equal As Strings    ${resultado[0][0]}    ${status}
    
    Log    Status do carregamento: ${resultado[0][0]}


Então o status do carregamento deve ser
    [Arguments]    ${STATUS_ESPERADO}
    Log    Verificando status do carregamento ${COD_CARREGAMENTO} — esperado: ${STATUS_ESPERADO}
    ${status}=    Query    SELECT c.Status FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL
    Should Not Be Empty    ${status}
    Should Be Equal As Strings    ${status[0][0]}    ${STATUS_ESPERADO}
    Log    Status do carregamento: ${status[0][0]}


E que existe um carregamento com status
    [Arguments]    ${status}
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Cancelado IS NULL AND c.Status = '${status}' ORDER BY c.Sequencia DESC LIMIT 1
    Should Not Be Empty    ${resultado}
    Set Test Variable    ${COD_CARREGAMENTO}    ${resultado[0][0]}


E incluo vendas no carregamento
    [Arguments]    ${QTD_VENDAS}
    ${QTD_VENDAS_INCLUIDAS}=    Pegar quantidade de vendas incluídas no carregamento
    Log    Quantidade atual de vendas no carregamento: ${QTD_VENDAS_INCLUIDAS}
    ${QTD_VENDAS_INCLUIDAS}=    Evaluate    ${QTD_VENDAS_INCLUIDAS} + ${QTD_VENDAS}
    Set Suite Variable    ${QTD_VENDAS_INCLUIDAS}    ${QTD_VENDAS_INCLUIDAS}
    Log    Quantidade esperada após inclusão: ${QTD_VENDAS_INCLUIDAS}

    Abrir tela de listagem de vendas

    FOR    ${INDEX}    IN RANGE    ${QTD_VENDAS}
        Selecionar a próxima venda disponível
    END

    Clicar no botão Salvar
    Sleep    ${SLEEP_MEDIO}


E incluo uma cobrança no carregamento
    ${EXISTE_COBRANCA}=    Verificar se existe cobrança a incluir
    IF    ${EXISTE_COBRANCA}
        Incluir cobrança no carregamento
    ELSE
        Log    Nenhuma cobrança encontrada para incluir. Cancelando operação.
        Cancelar operação e fechar tela
    END


Então a venda deve ser incluída com sucesso no carregamento
    ${QTD_ATUAL}=    Pegar quantidade de vendas incluídas no carregamento
    Log    Quantidade esperada: ${QTD_VENDAS_INCLUIDAS} | Quantidade atual: ${QTD_ATUAL}
    IF    ${QTD_ATUAL} != ${QTD_VENDAS_INCLUIDAS}
        Fail    A venda não foi incluída com sucesso no carregamento. Esperado: ${QTD_VENDAS_INCLUIDAS}, Obtido: ${QTD_ATUAL}
    END


Então o carregamento deve ser excluído com sucesso
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL
    Should Be Empty    ${resultado}


Então o sistema deve impedir a exclusão
    ${resultado}=    Query    SELECT c.Sequencia FROM cargas c WHERE c.Sequencia = ${COD_CARREGAMENTO} AND c.Cancelado IS NULL

    Should Not Be Empty    ${resultado}

    ${aviso_excluir_carregamento_fechado}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO_FECHADO}    ${TEMPO_TELA}
    
    IF    ${aviso_excluir_carregamento_fechado}

        Clicar no botão Ok
        Sleep    ${SLEEP_BAIXO}
        
    END

Quando acesso a tela de embarque
    Pesquisar carregamento por código    ${COD_CARREGAMENTO}
    Acessar tela de embarque


E informo os dados do veículo
    [Arguments]    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}
    Preencher dados do veículo no embarque    ${UF}    ${PLACA}    ${KM_SAIDA}    ${KM_CHEGADA}    ${LITROS}


E informo os dados do motorista
    ${COD}=    Obter código do cliente    D
    Preencher código do motorista    ${COD}


E informo os dados do entregador
    ${COD}=    Obter código do cliente    V
    Preencher código do entregador    ${COD}


E informo os dados do adiantamento
    Gerar dados do adiantamento
    Preencher dados do adiantamento    ${DOC_ADIANTAMENTO}    ${TOTAL_ADIANTAMENTO}
    Clicar no botão Incluir


E gravo o embarque
    Salvar embarque


Então o embarque deve ser salvo com sucesso
    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}


Então o adiantamento deve estar cadastrado no banco
    Validar adiantamento no banco
    Validar dados do adiantamento na tabela cargas

