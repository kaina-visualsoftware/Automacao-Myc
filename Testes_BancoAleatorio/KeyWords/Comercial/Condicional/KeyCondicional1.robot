*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Library    Telnet
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot

*** Variables ***
# Repositório de Imagens
${IMAGES}                                ./Testes_BancoAleatorio/images

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
${TELA_CONDICIONAIS}                     tela_Condicionais.png
${TELA_ADICIONAR_CONDICIONAL}            tela_CondicionaisAdicionar.png
${TELA_DETALHES_CONDICIONAL}             tela_DetalhesCondicional.png
${TELA_VISUALIZA_CONDICIONAL}            tela_VisualizaVenda.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${TELA_VENDAS_ADICIONAR}                 tela_VendaBalcaoAdicionar.png
${TELA_GERAÇÃO_VENDA_PARICAL}            tela_GeracaoVendaParcialCondicional.png

# Telas Avisos
${AVISO_DESEJA_EXCLUIR}                  aviso_DesejaExcluir.png

# Botões

# Outros
${MODAL_GERAR_VENDA_CONDICIONAL}         modal_GerarVendaCondicional.png
${MODAL_GERAR_VENDA_PARCIAL}             modal_GerarVendaParcialCondicional.png
${ROW_PRODUTO_INCLUSO_VENDA_PARCIAL}     row_ProdInclusoVendaParcialCond.png
${MODAL_CANCELAR_VENDA}                  modal_CancelarVenda.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de condicionais
    
    Press Special Key    F11

    Valida lançamento de condicional em aberto

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

    Verifica parametros que interferem na venda

E adiciono uma nova Condicional

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADICIONAR_CONDICIONAL}    ${TEMPO_TELA}

    ${Consulta}    Query    SELECT Codigo FROM condicionais ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_CONDICIONAL}    ${Consulta[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_CONDICIONAL}

    # Seta a lista de produtos como None para dar certo em ambos os casos (venda com mais de um produto e com apenas 1 produto)
    Set Test Variable    ${Codigos_Produtos}

Quando insiro vendedor e cliente

    utils.Adicionar Vendedor e Cliente(Condicional)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E insiro um produto normal

    IF    ${SelecionaProdutoComLinha}

        utils.Seleciona produto com linha cadastrada(${Parametro_VendeSemEstoqueCondicional})

    ELSE

        IF     ${Parametro_VendeSemEstoqueCondicional}

            utils.Inserir Produto normal - Permite sem estoque

        ELSE
            
            utils.Inserir Produto normal - Necessita de estoque

        END

    END

    utils.Valida parametros após incluir produto

E insiro mais de um produto normal(${Quantidade})

    ${Codigos_Produtos}    Create List
    
    FOR    ${I}    IN RANGE    ${Quantidade}
        
        E insiro um produto normal

        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}
        
    END

    Log To Console    Codigos_Produtos: ${Codigos_Produtos}

    Set Test Variable    ${Codigos_Produtos}
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${Quantidade}

Então finalizo a condicional
    
    Press Combination    KEY.ALT     Key.D
    Wait Until Screen Contain    ${TELA_DETALHES_CONDICIONAL}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Automacao Condicional
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.F

    Valida impressao direta de venda(${Parametro_ImprimeCondicional})

    KeyCondicional1.Valida baixa de estoque

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

Então visualizo a condicional

    Press Combination    KEY.ALT     Key.U
    Wait Until Screen Contain    ${TELA_VISUALIZA_CONDICIONAL}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.r

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

Quando clico em editar
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E

    utils.Valida solicitacao de senha do usuário

    Wait Until Screen Contain    ${TELA_ADICIONAR_CONDICIONAL}    ${TEMPO_TELA}

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Então excluo a condicional

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.x
    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Exclusao de Condicional - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitacao de senha do usuário
    
    Sleep    ${SLEEP_MEDIO}
    Check If Exists In Database    SELECT * FROM condicionais AS c WHERE c.Codigo = ${COD_CONDICIONAL} AND c.`Status` = 'x' AND c.Cancelada = 1;

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

Quando clico em gerar venda
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G

    Wait Until Screen Contain    ${MODAL_GERAR_VENDA_CONDICIONAL}    ${SLEEP_ALTO}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    KeyCondicional1.Consulta venda gerada a partir da condicional

    KeyVendas1.Verifica formas de recebimento da venda

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando cliclo em gerar venda parcial
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.V

    Wait Until Screen Contain    ${MODAL_GERAR_VENDA_PARCIAL}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S

    Wait Until Screen Contain    ${TELA_GERAÇÃO_VENDA_PARICAL}    ${TEMPO_TELA}

E gero a venda de parte dos produtos(${Quantidade})
    
    ${Produtos_Condicional}    Create List
    ${Codigos_Produtos}        Create List
    
    ${prodsCond}    Query    SELECT CodigoProduto FROM CondicionaisProdutos WHERE CodigoCondicional = ${COD_CONDICIONAL} AND (QtdeOriginal > QtdeDevolvida or QtdeDevolvida is NULL) AND Cancelada IS NULL;
    
    FOR    ${I}    IN RANGE    ${Quantidade}
        
        Press Special Key    SPACE
        Sleep    ${SLEEP_BAIXO}

        Append To List    ${Produtos_Condicional}    ${prodsCond[${I}][0]}
        
    END
    Log To Console    prodsCond: ${prodsCond}
    Log To Console    Produtos_Condicional: ${Produtos_Condicional}

    Wait Until Screen Contain    ${ROW_PRODUTO_INCLUSO_VENDA_PARCIAL}    ${SLEEP_ALTO}

    Press Combination    KEY.ALT     Key.G
    Wait Until Screen Contain    ${MODAL_GERAR_VENDA_PARCIAL}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}

    KeyVendas1.Verifica formas de recebimento da venda

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

    ${Codigo_Venda_Gerada_Cond}    Query    SELECT Codigo FROM vendas AS v WHERE v.CodCondicional = ${COD_CONDICIONAL};

    Set Test Variable    ${Codigo_Venda_Gerada}    ${Codigo_Venda_Gerada_Cond[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Venda_Gerada}

    Set Test Variable    ${Codigos_Produtos}    ${Produtos_Condicional}

    ${QUANTIDADE_PRODUTOS}    Get Length    ${Codigos_Produtos}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}
    
Então cancelo a geração da venda
    
    Sleep    ${SLEEP_ALTO}
    Press Special Key    ESC
    Wait Until Screen Contain    ${MODAL_CANCELAR_VENDA}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S

    IF    ${Parametro_ExigeSenhaCancelarVenda}

        Cancela venda com senha

    END
    
    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

    Validação de vendas canceladas vindas do condicional

Validação de vendas canceladas vindas do condicional
    
    Check If Exists In Database    SELECT * FROM vendas AS v WHERE v.CodCondicional = ${COD_CONDICIONAL} AND `Status` LIKE 'x';

    Check If Not Exists In Database    SELECT * FROM condicionaisprodutos AS cp WHERE cp.CodigoCondicional = ${COD_CONDICIONAL} AND QtdeGerada = 1;

Validação de vendas após a geração do condicional
    
    Check If Exists In Database    SELECT * FROM vendas AS v WHERE v.CodCondicional = ${COD_CONDICIONAL} AND `Status` LIKE 'f';

    Check If Not Exists In Database    SELECT * FROM condicionaisprodutos AS cp WHERE cp.CodigoCondicional = ${COD_CONDICIONAL} AND QtdeGerada = 0;

    ${Codigo_Venda_Gerada_Cond}    Query    SELECT Codigo FROM vendas AS v WHERE v.CodCondicional = ${COD_CONDICIONAL} AND `Status` LIKE 'f';

    Should Be Equal    ${CODIGO_VENDA_GERADA_CONDICIONAL}    ${Codigo_Venda_Gerada_Cond[0][0]}

    Set Test Variable    ${Codigo_Venda_Gerada}    ${Codigo_Venda_Gerada_Cond[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Codigo_Venda_Gerada}

Valida baixa de estoque

    Sleep    ${SLEEP_MEDIO}
    Log To Console    QUANTIDADE_PRODUTOS: ${QUANTIDADE_PRODUTOS}

    IF    ${QUANTIDADE_PRODUTOS} > 1
        
        FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}
            
            Log To Console    Codigos_Produtos NA POS ${i}: ${Codigos_Produtos[${i}]}

            ${COD_PRODUTO}    Set Variable    ${Codigos_Produtos[${i}]}
            Log To Console    COD_PRODUTO: ${COD_PRODUTO}
            
            ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_CONDICIONAL}

            IF    ${Baixa_De_Estoque}
                Log To Console    Baixou estoque corretamente do produto [${COD_PRODUTO}] na Condicional!
            ELSE
                Fail    Falha na baixa do estoque na Condicional! Verifique!
            END
        END

    ELSE

        ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_CONDICIONAL}

        IF    ${Baixa_De_Estoque}
            Log To Console    Baixou estoque corretamente na Condicional!
        ELSE
            Log To Console    Falha na baixa do estoque na Condicional! Verifique!
        END

    END

Consulta venda gerada a partir da condicional

    ${Consulta}    Query    SELECT v.Codigo FROM vendas v WHERE v.CodCondicional = ${COD_CONDICIONAL} AND v.`Status` = 'e';

    Set Test Variable    ${CODIGO_VENDA_GERADA_CONDICIONAL}    ${Consulta[0][0]}

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${CODIGO_VENDA_GERADA_CONDICIONAL}