*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/estoque.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                                  ./testes_bancoAleatorio/images

# Conexão com banco de dados
${DBHost}                                   ${config.IpServidor}
${DBName}                                   ${config.Database}
${DBPass}                                   vssql
${DBPort}                                   ${config.Porta}
${DBUser}                                   root

# Sleep's
${SLEEP_BAIXO}                              0.7
${SLEEP_MEDIO}                              1.7
${SLEEP_ALTO}                               3
${TEMPO_TELA}                               20

# Telas
${TELA_NOTA_FISCAL_PREENCHIMENTO_MANUAL}    tela_NotaFiscalPreenchimentoManual.png
${GUIA_TOTALIZACAO_TRANSPORTADORA}          guia_TotalizacaoETransportadora.png
${GUIA_PAGAMENTOS_NFE}                      guia_PagamentosNFe.png

# Telas Avisos
${AVISO_INFORMAR_QTDE_VOLUME}               aviso_InformarQtdeVolumeNFe.png

# Inputs
${INPUT_COD_CLIENTE}                        input_CodCliente.png
${INPUT_COD_PRODUTO}                        input_CodProduto.png

# Labels
${LABEL_CATEGORIA_VENDAS}                   lb_CategoriaVendas.png
${LABEL_QUANTIDADE_VOLUME_NFE}              lb_QuantidadeVolumeNFe.png

# Outros
${ROW_PAGAMENTO_INCLUSO}                    row_PagInclusoNFeSaidasManual.png
${FORMA_RECEBIMENTO_OUTROS}                 Outros...
${Valor_Total_Produtos}                     0

# Parâmetros de Configuração (inicializados em runtime via Set Global Variable)
${Parametro_RealizaVendaSemEstoque}         None
${Parametro_BaixaAutomatico}               None

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${valorTotalNota}                           ${0}
@{Produtos_NF}
${Codigo_Cliente}                           None
${FORMA_PADRAO}                             ${None}
${FORMA_PRAZO}                              None
${DESCONTO_FORMA}                           ${0}
${EntradaIgualA_Outros}                     None
${VALOR_FINAL_NFE_SAIDA_MANUAL}             None
${Valor_Total_ICMS}                         ${0}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu acesso a tela de lançamento de nota fiscal preenchimento manual

    Verifica formas de recebimento da venda

    Key Down    CTRL
    Press Special Key    F9
    Key Up      CTRL
    Wait Until Screen Contain    ${TELA_NOTA_FISCAL_PREENCHIMENTO_MANUAL}    ${TEMPO_TELA}
    
    Press Special Key    TAB

    ${categoriaVendas}    Exists    ${LABEL_CATEGORIA_VENDAS}

    WHILE    ${categoriaVendas} == False

        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}

        ${categoriaVendas} =    Exists    ${LABEL_CATEGORIA_VENDAS}
    END

    FOR    ${i}    IN RANGE    3
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

E adiciono vendedor e cliente

    utils.Adicionar Vendedor e Cliente(NFeSaidasManual)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando informo um produto normal
    
    Set Test Variable    ${valorTotalNota}    0

    @{Produtos_NF}    Create List

    ${numeroDeProdutos}    Evaluate    random.randint(1, 3)

    FOR    ${I}    IN RANGE    ${numeroDeProdutos}
        
        ${codigo}    ${quantidade}    ${valorUnitario}    ${valorTotal}    ${aliquotaICMS}    Selecionar produto

        Valida parametros após incluir produto

        &{produto_nf}    Create Dictionary    
        ...    codigo=${codigo}    
        ...    quantidade=${quantidade}    
        ...    valor_unitario=${valorUnitario}    
        ...    valor_total=${valorTotal}    
        ...    aliquota_icms=${aliquotaICMS}

        Append To List    ${Produtos_NF}    ${produto_nf}

    END

    Set Test Variable    ${Produtos_NF}
    
Selecionar produto

    ${campoRefProd}    Exists    ${LABEL_REF_PRODUTO}

    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    IF    ${campoRefProd}
        
        SikuliLibrary.Click    ${BT_SETA_DIREITA}
        Sleep    ${SLEEP_BAIXO}

    END

    Type With Modifiers    P    SHIFT
    Sleep    ${SLEEP_BAIXO}

    ${produto}    Query    SELECT Codigo, VendaT1, AliquotaICMS FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    ${codigoProduto}    Set Variable    ${produto[0][0]}
    ${valorUnitario}    Set Variable    ${produto[0][1]}
    ${aliquotaICMS}     Set Variable    ${produto[0][2]}
    ${qtdeProduto}      Evaluate    random.randint(1, 3)
    
    Input Text    ${EMPTY}    ${codigoProduto}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${qtdeProduto}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${valorTotalProduto}    Evaluate    ${qtdeProduto} * ${valorUnitario}

    ${Valor_Total_Produtos}    Evaluate    round(${Valor_Total_Produtos} + ${valorTotalProduto}, 2)

    Set Test Variable    ${Valor_Total_Produtos}

    RETURN    ${codigoProduto}    ${qtdeProduto}    ${valorUnitario}    ${valorTotalProduto}    ${aliquotaICMS}

Valida cliente pessoa física

    ${clientePF}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM clientes c WHERE c.Codigo = ${Codigo_Cliente} AND c.FisicaJuridica = 'J';

    IF    ${clientePF}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END        

Quando seleciono um produto
    
    IF    ${Parametro_RealizaVendaSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE
        
        utils.Inserir Produto normal - Necessita de estoque

    END

    utils.Valida parametros após incluir produto
    
Verifica formas de recebimento da venda
    
    ${FORMA_PADRAO}    Valida Configuracoes Venda
    ${FORMA_PRAZO}    Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO}

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.M

    Wait Until Screen Contain    ${GUIA_PAGAMENTOS_NFE}    ${TEMPO_TELA}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    ${EntradaIgualA_Outros}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'
        
        utils.Personalização de Pagamentos

    END

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto

    END

Então finalizo a nota fiscal de saída manual

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento em fins de semana e feriados(${FORMA_PADRAO[4]})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.G

    Valida necessidade de informar volume

    Calcula valor final da NFe Manual de Saída

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'
        
        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Finalização com recebimento de duplicatas(${VALOR_FINAL_NFE_SAIDA_MANUAL})

            END

        END

    END
    
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_NOTA_FISCAL_PREENCHIMENTO_MANUAL}    ${TEMPO_TELA}

# Calcula valor final da NFe Saídas Manual

#     ${ValorTotalProdutos}    Query    SELECT nsp.ValorTotal, nsp.* FROM notassaidas_produtos nsp WHERE nsp.NF =  AND nsp.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

Valida necessidade de informar volume
    
    Sleep    ${SLEEP_BAIXO}
    ${aviso}    Exists    ${AVISO_INFORMAR_QTDE_VOLUME}

    IF    ${aviso}

        Press Special Key    ENTER

        Wait Until Screen Contain    ${GUIA_TOTALIZACAO_TRANSPORTADORA}    ${TEMPO_TELA}

        SikuliLibrary.Click    ${LABEL_QUANTIDADE_VOLUME_NFE}

        Input Text    ${EMPTY}    100

        Press Special Key    TAB

        E acesso a aba pagamentos

        Press Combination    KEY.ALT    KEY.G

    END

Calcula valor final da NFe Manual de Saída

    Calcula valor de ICMS

    ${Valor_Total_NF}    Set Variable    ${Valor_Total_Produtos}

    Set Test Variable    ${VALOR_FINAL_NFE_SAIDA_MANUAL}    ${Valor_Total_NF}

Calcula valor de ICMS

    ${total_icms}    Set Variable    0

    FOR    ${produto}    IN    @{Produtos_NF}

        ${calc_icms}    Evaluate    round(${produto['valor_total']} * (${produto['aliquota_icms']} / 100), 2)

        ${total_icms}    Evaluate    round(${total_icms} + ${calc_icms}, 2)

    END

    Set Test Variable    ${Valor_Total_ICMS}    ${total_icms}