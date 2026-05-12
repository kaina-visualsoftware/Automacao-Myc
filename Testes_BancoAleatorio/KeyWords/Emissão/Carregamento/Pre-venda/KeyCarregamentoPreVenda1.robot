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
# Repositório de Imagens
${IMAGENS}                                     ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                                      ${config.IpServidor}
${DBName}                                      ${config.Database}
${DBPass}                                      vssql
${DBPort}                                      ${config.Porta}
${DBUser}                                      root

# Sleep's
${SLEEP_BAIXO}                                 0.7
${SLEEP_MEDIO}                                 1.7
${SLEEP_ALTO}                                  3
${TEMPO_TELA}                                  20

# Telas
${MENU_EMISSÃO}                                menu_Emissão.png
${TELA_GERACAO_VENDAS}                         tela_GeracaoVenda.png
${TELA_CARREGAMENTOS}                          tela_Carregamentos.png
${TELA_CADASTRO_CARREGAMENTO}                  tela_CadastroCarregamento.png
${TELA_INCLUSAO_ROTAS}                         tela_InclusaoRotas.png
${TELA_IMPRESSAO}                              tela_Impressao.png

# Telas Avisos
${AVISO_EXCLUSAO_STATUS_FECHADO}               aviso_ExclusaoStatusFechado.png
${AVISO_CARGA_MONTADA}                         aviso_CargaMontada.png
${AVISO_EXCLUIR_CARREGAMENTO}                  aviso_ExcluirCarregamento.png
${AVISO_CANCELAR_CARREGAMENTO}                 aviso_CancelarCarregamento.png

# Grids
${GRID_ROTA_CARREGAMENTO}                      grid_RotaCarregamento.png

# Botões
${BT_SETA_INCLUIR_PRODUTO_ENTREGA}             bt_SetaIncluirProdutoEntrega.png
${BT_ADICIONAR_CARREGAMENTO}                   bt_AdicionarCarregamento.png
${BT_INCLUIR_ROTAS}                            bt_IncluirRotas.png
${BT_SETA_INCLUSÃO_ROTAS_CARREGAMENTO}         bt_SetaIncluirRotasCarregamento.png
${BT_MONTAR_CARGA}                             bt_MontarCarga.png
${BT_FECHAR_CARGA}                             bt_FecharCarga.png
${BT_IMPRIMIR_MAPA_ROTA}                       bt_ImprimirMapaRota.png
${BT_OK_SEM_ATALHO}                            bt_OK_sem_atalho.png
# Outros
${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}             grid_PedidosOrdemDeEntregaNovo.png

# Inputs
${INPUT_DESCRICAO_CARREGAMENTO}                input_DescricaoCarregamento.png
${INPUT_PESQUISA_CARREGAMENTO}                 input_PesquisaCarregamento.png
${INPUT_PALETES_CARREGAMENTO}                  input_PaletesCarregamento.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${COD_VENDA}                                   None
${COD_DOACAO}                                  None
${ID_GRUPO_ENTREGA}                            None
${Codigos_Vendas}                              ${None}
${Quantidade_Vendas_Feitas}                    None
${Codigo_Vendedor}                             None
${Codigo_Cliente}                              None
${COD_CARREGAMENTO}                            None

*** Keywords ***

Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu crio uma nova pré-venda de um cliente com rota
    
    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota aleatória
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

E listo pela tela de Geração de vendas

    Então acesso a tela de geração de vendas
    E clico em Listar ALT L
    Então fecho a tela de geração de vendas

Seleciona vendedor

    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codVendedor[0][0]}

Quando adiciono um Vendedor e um Cliente com rota
    [Arguments]    ${ROTA}
    Set Test Variable    ${TELA}    Pedido

    # --- VENDEDOR ---
    ${codVendedor}    Seleciona vendedor
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    # --- CLIENTE COM ROTA ---
    ${codCliente}    Seleciona cliente com rota    ${ROTA}
    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Keypedidos1.Valida avisos após incluir cliente e vendedor - Pré-Venda

Seleciona cliente com rota
    [Arguments]    ${ROTA}

    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) AND Codigo <> 1 AND c.Rota = ${ROTA} ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    
    IF    len($codCliente) == 0
        
        Fail    Nenhum cliente com rota foi encontrado.

    END

    RETURN    ${codCliente[0][0]}

Então acesso a tela de geração de vendas 

    KeyGeracaoDeVenda1.Dado que acesso a tela de geração de vendas

E clico em Listar ALT L

    Press Combination    KEY.ALT    KEY.L
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}

Então fecho a tela de geração de vendas
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${TELA_GERACAO_VENDAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Então acesso a tela de Carregamento

    Press Combination    KEY.CTRL    KEY.T
    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${TELA_CARREGAMENTOS}
    Sleep    ${SLEEP_BAIXO}

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

E clico em Incluir Rotas

    SikuliLibrary.Click    ${BT_INCLUIR_ROTAS}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_INCLUSAO_ROTAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então eu Listo as Rotas

    Press Combination    KEY.ALT    KEY.L
    Sleep    ${SLEEP_BAIXO}

E gravo incluindo a primeira Rota da lista

    SikuliLibrary.Click    ${GRID_ROTA_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_SETA_INCLUSÃO_ROTAS_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando eu Monto a Carga

    SikuliLibrary.Click    ${BT_MONTAR_CARGA}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${AVISO_CARGA_MONTADA}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}

E valido que o carregamento está com o status Montando
    ${carregamento_existe}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} and Status = 'Montando'
    Should Be True    ${carregamento_existe}    Carregamento pesquisado não está com o status correto

E valido que o carregamento está com o status Fechada
    ${carregamento_existe}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} and Status = 'Fechada'
    Should Be True    ${carregamento_existe}    Carregamento pesquisado não está com o status correto

E valido que o carregamento está com o status Cadastrando
    ${carregamento_existe}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} and Status = 'Cadastrando'
    Should Be True    ${carregamento_existe}    Carregamento pesquisado não está com o status correto

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

E fecho a tela de carregamento

    SikuliLibrary.Click    ${TELA_CARREGAMENTOS}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Not Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Dado que eu crio duas pré-vendas com rotas distintas

    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota    6
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)
     
    Keypedidos1.Dado que acesso a tela de pedidos
    Keypedidos1.E clico em adicionar
    Quando adiciono um Vendedor e um Cliente com rota    7
    KeyPedidos1.Quando insiro um produto normal informando a quantidade(1)
    Quando vou para a aba de pagamentos
    E audito o pedido
    Então finalizo o pedido
    E saio da tela(Pedido)

Valida Carregamento gerado

    ${Consulta}    Query    SELECT Sequencia FROM cargas ORDER BY Sequencia DESC LIMIT 1;

    Set Test Variable    ${COD_CARREGAMENTO}    ${Consulta[0][0]}

Quando pesquiso o Carregamento gerado

    SikuliLibrary.Click    ${INPUT_PESQUISA_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

E excluo o Carregamento parcialmente gerado

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

E excluo o Carregamento totalmente gerado

    Press Combination    KEY.ALT    KEY.X
    Wait Until Screen Contain    ${AVISO_EXCLUIR_CARREGAMENTO}    ${TEMPO_TELA}  
    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${AVISO_EXCLUSAO_STATUS_FECHADO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_OK_SEM_ATALHO}
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CARREGAMENTOS}    ${TEMPO_TELA}
    ${carregamento_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} AND Cancelado IS NULL
    Sleep    ${SLEEP_BAIXO}

    Should Be True    ${carregamento_excluido}    Carregamento foi excluído indevidamente

E adiciono um carregamento com rota

    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo a primeira Rota da lista

E adiciono um carregamento com duas rotas

    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete
    E clico em Incluir Rotas
    Então eu Listo as Rotas
    E gravo incluindo duas rotas da lista

E adiciono um carregamento sem rota

    E clico para adicionar um carregamento
    Quando adiciono uma Descrição qualquer e incluo um palete

E gravo incluindo duas rotas da lista

    SikuliLibrary.Click    ${GRID_ROTA_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_SETA_INCLUSÃO_ROTAS_CARREGAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CADASTRO_CARREGAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E valido que o carregamento contém duas rotas diferentes

    ${rotas}    Query    SELECT * FROM cargas_rotas WHERE CodigoCarregamento = ${COD_CARREGAMENTO};

    ${quantidade_rotas}    Get Length  ${rotas}

    Should Be Equal As Integers
    ...    ${quantidade_rotas}
    ...    2
    ...    Carregamento não contém duas rotas diferentes.

Quando adiciono um Vendedor e um Cliente com rota aleatória

    Set Test Variable    ${TELA}    Pedido

    # --- VENDEDOR ---
    ${codVendedor}    Seleciona vendedor
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    # --- CLIENTE COM ROTA ---
    ${codCliente}    Seleciona cliente com rota aleatória 
    Set Test Variable    ${Codigo_Cliente}    ${codCliente}

    SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Keypedidos1.Valida avisos após incluir cliente e vendedor - Pré-Venda

Seleciona cliente com rota aleatória

    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) AND Codigo <> 1 AND c.Rota IS NOT NULL ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    
    IF    len($codCliente) == 0
        
        Fail    Nenhum cliente com rota foi encontrado.

    END

    RETURN    ${codCliente[0][0]}

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

E valido que o carregamento foi excluído com sucesso

    ${carregamento_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM cargas WHERE sequencia = ${COD_CARREGAMENTO} AND Cancelado = 1
    Sleep    ${SLEEP_BAIXO}

    Should Be True    ${carregamento_excluido}    Carregamento foi excluído com sucesso

Dado que acesso a tela de carregamento

    Então acesso a tela de Carregamento

Informar Descrição

    Buscar Código do Carregamento em Edição

    SikuliLibrary.Input Text    ${EMPTY}    AUTOMACAO PREVENDA - ${COD_CARREGAMENTO}

    Sleep    ${SLEEP_BAIXO}

Buscar Código do Carregamento em Edição

    ${Consulta}    Query    SELECT Sequencia FROM cargas ORDER BY Sequencia DESC LIMIT 1;

    Set Test Variable    ${COD_CARREGAMENTO}    ${Consulta[0][0]}