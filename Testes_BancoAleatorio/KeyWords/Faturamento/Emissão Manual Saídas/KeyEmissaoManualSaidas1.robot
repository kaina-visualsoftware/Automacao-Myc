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
${IMAGENS}    ./testes_bancoAleatorio/images

# Conexão com banco de dados
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

${TELA_NOTA_FISCAL_PREENCHIMENTO_MANUAL}    tela_NotaFiscalPreenchimentoManual.png
${LABEL_CATEGORIA_VENDAS}                   lb_CategoriaVendas.png
${INPUT_COD_CLIENTE}                        input_CodCliente.png
${INPUT_COD_PRODUTO}                        input_CodProduto.png
${ROW_PAGAMENTO_INCLUSO}                    row_PagInclusoNFeSaidasManual.png
${FORMA_RECEBIMENTO_OUTROS}                 Outros...

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu acesso a tela de lançamento de nota fiscal preenchimento manual

    Verifica formas de recebimento da venda

    Verifica parâmetros que interferem na venda

    Key Down    CTRL
    Press Special Key    F9
    Key Up      CTRL
    Wait Until Screen Contain    ${TELA_NOTA_FISCAL_PREENCHIMENTO_MANUAL}    ${TEMPO_TELA}
    
    Press Special Key    TAB

    ${categoriaVendas} =    Exists    ${LABEL_CATEGORIA_VENDAS}

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
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    ${EntradaIgualA_Outros} =     Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'
        
        utils.Personalização de Pagamentos

    END 

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto 

    END

Então finalizo a nota fiscal de saída manual

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento fim de semana(${FORMA_PADRAO[4]})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G

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

Calcula valor final da NFe Saídas Manual

    ${ValorTotalProdutos}    Query    SELECT nsp.ValorTotal, nsp.* FROM notassaidas_produtos nsp WHERE nsp.NF = 20006 AND nsp.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);