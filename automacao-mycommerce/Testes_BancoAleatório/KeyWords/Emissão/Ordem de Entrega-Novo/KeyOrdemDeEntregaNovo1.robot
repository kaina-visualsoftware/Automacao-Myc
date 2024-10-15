*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Library    ../libs/verificacoesExtras.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot
Resource     ../utils/montadorDeCenarios.robot

*** Variables ***
#Imagens
${IMAGENS}    ./Testes_BancoAleatório/images

#Conexão com banco de dados
${DBHost}                                ${config.IpServidor}
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root

#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20

#Imagens Telas
${MENU_EMISSÃO}                                menu_Emissão.png
${SUBMENU_ORDEM_DE_ENTREGA_NOVO}               subMenu_OrdemDeEntregaNovo.png
${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}    subMenu_OrdemDeEntregaNovoLancamento.png
${TELA_ORDEM_DE_ENTREGA}                       tela_OrdemDeEntrega.png
${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}             grid_PedidosOrdemDeEntregaNovo.png
${LB_CODIGO_PEDIDO}                            lb_CodigoPedido.png

*** Keywords ***

Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu acesso o menu de Emissão/Ordem de Entrega Novo
    SikuliLibrary.Click    ${MENU_EMISSÃO}
    Wait Until Screen Contain    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO}
    Wait Until Screen Contain    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}    ${TEMPO_TELA}

E inicio um lançamento de Ordem de Entrega Novo
    SikuliLibrary.Click    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}
    Wait Until Screen Contain    ${TELA_ORDEM_DE_ENTREGA}    ${TEMPO_TELA}

Quando seleciono a última venda gerada
    Press Combination    KEY.ALT    KEY.F
    Sleep    ${SLEEP_BAIXO}    
    Wait Until Screen Contain    ${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}

E seleciono o produto
    
    Press Special Key   TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Última ordem de entrega feita/em aberto

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${ID_ENTREGA_PENDENTE}

Última ordem de entrega feita/em aberto
    ${consulta}    Query    SELECT ep.ID FROM entregas_pendentes ep ORDER BY ep.ID DESC LIMIT 1;

    Set Test Variable    ${ID_ENTREGA_PENDENTE}    ${consulta[0][0]}

Então gero a entrega
    Press Combination    KEY.ALT    KEY.G

Valida quantidade entregue
    ${consulta}    Query    selectStatement