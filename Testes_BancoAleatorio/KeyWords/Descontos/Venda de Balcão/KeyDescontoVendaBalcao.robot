*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/estoque.py
Library    Process
Library    Collections
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                                ./testes_bancoAleatorio/images

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
${TELA_VENDAS}                           tela_VendasDeBalcao.png
${TELA_VENDAS_ADICIONAR}                 tela_VendaBalcaoAdicionar.png
${TELA_LIBERAÇÃO_DESCONTO_SENHA}         tela_liberacaoDesconto.png
${MODAL_SUPERVISOR_SEM_PERMISSAO}        tela_SupervisorSemPermissao.png

# Outros
${Codigos_Produtos}                      ${None}
${INPUT_COD_CLIENTE_VENDA}               lb_CodClienteVenda.png
${BT_SETA_DIREITA}                       bt_SetaDireita.png
${LABEL_DESCONTO_FINAL_VENDA}            lb_DescontoFinalVenda.png

# Parâmetros de Configuração (inicializados em runtime via Set Global Variable)
${Parametro_Local_Negociacao}             None
${Parametro_IndicacaoVenda}               None

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${COD_VENDA}                             None
${CODIGO_OPERACAO_MOV}                   None
${Codigo_Cliente}                        None
${COD_PRODUTO}                           None
${TELA}                                  None
${Aviso_Vendedor_Existe_Comissao}        ${False}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de vendas de balcão

    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

    Set Test Variable    ${TELA}    Venda

Quando pressiono o atalho de adicionar

    Press Combination    KEY.ALT     Key.A
    Sleep    ${SLEEP_BAIXO}

    IF    ${Parametro_Local_Negociacao}

        Valida local de negociação da venda

    END

    Valida indicação de venda(${Parametro_IndicacaoVenda})

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    Última venda feita/em aberto
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    # Seta a lista de produtos como None para dar certo em ambos os casos (venda com mais de um produto e com apenas 1 produto)
    Set Test Variable    ${Codigos_Produtos}

Última venda feita/em aberto

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

E adiciono o vendedor de código(${codigoVendedor})

    Set Test Variable    ${Aviso_Vendedor_Existe_Comissao}    ${False}

    Input Text    ${EMPTY}    ${codigoVendedor}
    Press Special Key    TAB

E adiciono o cliente de código(${codigoCliente})

    SikuliLibrary.Double Click    ${INPUT_COD_CLIENTE_VENDA}
    Input Text    ${EMPTY}    ${codigoCliente}

    Press Special Key    TAB

    Set Test Variable    ${Codigo_Cliente}    ${codigoCliente}

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E insiro um produto normal de código(${codigoProduto})
    
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codigoProduto}

    Press Special Key    TAB

    Set Test Variable    ${COD_PRODUTO}    ${codigoProduto}

    utils.Valida parametros após incluir produto

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    Key.M

    Valida cliente com vales compra disponíveis

E insiro um desconto de [${valor_desconto}]%

    SikuliLibrary.Double Click    ${LABEL_DESCONTO_FINAL_VENDA}

    Input Text    ${EMPTY}    ${valor_desconto}

    Press Special Key    TAB

    Wait Until Screen Contain    ${TELA_LIBERAÇÃO_DESCONTO_SENHA}    ${TEMPO_TELA}

E insiro a senha [${senha_usuário_supervisor}] do vendedor de código [${codigo_usuário_supervisor}]

    Input Text    ${EMPTY}    ${senha_usuário_supervisor}

    Press Special Key    ENTER

Então deve ser exibida a tela dizendo [Supervisor não Cadastrado ou Sem Permissão]

    Wait Until Screen Contain    ${MODAL_SUPERVISOR_SEM_PERMISSAO}    ${TEMPO_TELA}

    Press Special Key    ENTER

    Press Special Key    ESC