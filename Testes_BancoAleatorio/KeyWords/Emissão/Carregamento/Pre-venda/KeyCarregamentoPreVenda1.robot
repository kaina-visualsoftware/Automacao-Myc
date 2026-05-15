*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/validaParametros.py
Library    Process
Library    ${EXECDIR}/Testes_BancoAleatorio/libs/verificacoesExtras.py
Variables    ${EXECDIR}/Testes_BancoAleatorio/libs/leituraConfig.py

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/montadorDeCenarios.robot
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
${TELA_GERACAO_VENDAS}                         tela_GeracaoVenda.png
${TELA_CARREGAMENTOS}                          tela_Carregamentos.png
${TELA_CADASTRO_CARREGAMENTO}                  tela_CadastroCarregamento.png
${TELA_INCLUSAO_ROTAS}                         tela_InclusaoRotas.png
${TELA_IMPRESSAO}                              tela_Impressao.png
${TELA_PEDIDOS_ROTA}                           tela_Pedidosrota.png

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

# =============================================================
# INPUTS
# =============================================================
${INPUT_DESCRICAO_CARREGAMENTO}                input_DescricaoCarregamento.png
${INPUT_PESQUISA_CARREGAMENTO}                 input_PesquisaCarregamento.png
${INPUT_PALETES_CARREGAMENTO}                  input_PaletesCarregamento.png

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

*** Keywords ***

# =============================================================
# SETUP / INICIALIZAÇÃO
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

Buscar Duas Rotas Distintas Com Clientes
    ${rotas}    Query    SELECT DISTINCT Rota FROM clientes WHERE (Tipo LIKE 'C' OR Tipo LIKE 'A') AND Ativo = -1 AND Status = 'ATIVA' AND CreditoCortado = 0 AND Codigo <> 1 AND Rota IS NOT NULL ORDER BY RAND() LIMIT 2;

    IF    len($rotas) < 2
        Fail    Não foram encontradas duas rotas distintas com clientes ativos no ambiente.
    END

    Set Test Variable    ${ROTA_1}    ${rotas[0][0]}
    Set Test Variable    ${ROTA_2}    ${rotas[1][0]}

Valida Carregamento gerado
    ${Consulta}    Query    SELECT Sequencia FROM cargas ORDER BY Sequencia DESC LIMIT 1;
    Set Test Variable    ${COD_CARREGAMENTO}    ${Consulta[0][0]}

# =============================================================
# PRÉ-VENDA - CRIAÇÃO DE CENÁRIOS
# =============================================================

Dado que eu crio uma pré-venda com rota
    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)
    E listo pela tela de Geração de vendas

Dado que eu crio duas pré-vendas com rotas distintas
    Buscar Duas Rotas Distintas Com Clientes

    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Buscar Duas Rotas Distintas Com Clientes
    Quando adiciono um Vendedor e um Cliente com rota    ${ROTA_1}
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota    ${ROTA_2}
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

    E listo pela tela de Geração de vendas

Dado que eu crio duas pré-vendas com a mesma rota

    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Buscar Duas Rotas Distintas Com Clientes
    Quando adiciono um Vendedor e um Cliente com rota    ${ROTA_1}
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota    ${ROTA_1}
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

    E listo pela tela de Geração de vendas

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

# =============================================================
# TELA DE GERAÇÃO DE VENDAS
# =============================================================

E listo pela tela de Geração de vendas
    Então acesso a tela de geração de vendas
    E clico em Listar ALT L
    Então fecho a tela de geração de vendas

Então acesso a tela de geração de vendas
    KeyGeracaoDeVenda1.Dado que acesso a tela de geração de vendas

E clico em Listar ALT L
    Press Combination    KEY.ALT    KEY.L
    Wait Until Screen Not Contain    ${ICONE_LUPA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então fecho a tela de geração de vendas
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Wait Until Screen Not Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}

# =============================================================
# TELA DE CARREGAMENTO - NAVEGAÇÃO
# =============================================================

Dado que acesso a tela de carregamento
    Então acesso a tela de Carregamento

Então acesso a tela de Carregamento
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.CTRL    KEY.T
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
    Informar Descrição
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.click    ${INPUT_PALETES_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}

Informar Descrição
    Valida carregamento gerado
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Input Text    ${EMPTY}    AUTOMACAO PREVENDA - ${COD_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}

Então edito o carregamento
    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

E adiciono um carregamento sem rota
    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete

E adiciono um carregamento com rotas
    [Arguments]    ${QUANTIDADE_ROTAS}

    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo rotas da lista    ${QUANTIDADE_ROTAS}

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
    Informar Descrição

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

E valido que o carregamento contém duas rotas diferentes
    ${rotas}    Query    SELECT CodigoRota FROM cargas_rotas WHERE CodigoCarregamento = ${COD_CARREGAMENTO} ORDER BY CodigoRota;
    ${rotas_encontradas}    Evaluate    sorted([r[0] for r in $rotas])
    ${rotas_esperadas}      Evaluate    sorted([${ROTA_1}, ${ROTA_2}])
    Should Be Equal    ${rotas_encontradas}    ${rotas_esperadas}
    ...    As rotas do carregamento não correspondem às rotas das pré-vendas criadas.

E valido que o carregamento contém apenas uma rota
    ${rotas}    Query    SELECT CodigoRota FROM cargas_rotas WHERE CodigoCarregamento = ${COD_CARREGAMENTO};
    ${quantidade}    Get Length    ${rotas}
    Should Be Equal As Integers    ${quantidade}    1
    ...    O carregamento contém ${quantidade} rotas, mas deveria conter apenas uma.

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

