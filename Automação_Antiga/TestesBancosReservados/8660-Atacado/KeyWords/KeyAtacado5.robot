*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaAtacado.py

*** Variables ***
${IMAGES}                    ./TestesBancosReservados/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    8660
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${MENU_ESTOQUE}              menu_Estoque.png
${SUBMENU_ACERTO_ESTOQUE}    subMenu_AcertoEstoque.png
${TELA_ACERTO_ESTOQUE}       tela_AcertoEstoque.png
${TELA_ADICIONAR_ACERTO}     tela_LancamentosAcerto.png
${AVISO_EXCLUIR_ACERTO}      aviso_ExcluirAcerto.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de acerto de estoque
    
    SikuliLibrary.Click    ${MENU_ESTOQUE}
    SikuliLibrary.Click    ${SUBMENU_ACERTO_ESTOQUE}
    Wait Until Screen Contain    ${TELA_ACERTO_ESTOQUE}    ${TEMPO_TELA}

Quando adiciono um novo acerto 
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADICIONAR_ACERTO}    ${TEMPO_TELA}

Quando insiro um produto normal para ser devolvido

    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}

E insiro uma quantidade para o acerto(${QUANTIDADE_ACERTO})
    
    FOR    ${I}    IN RANGE    6
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${QUANTIDADE_ACERTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${QUANTIDADE_ACERTO}    ${QUANTIDADE_ACERTO}

Então adiciono o acerto 
    
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADICIONAR_ACERTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    
    ${VALIDADOR}    Valida Estoque    ${COD_PRODUTO}    ${QUANTIDADE_ACERTO}

    Should Be Equal    ${VALIDADOR}    ${True}
    
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_ACERTO_ESTOQUE}    ${TEMPO_TELA}

Então saio da tela sem realizar o acerto
    
    Press Combination    KEY.ALT     Key.S 
    Wait Until Screen Contain    ${TELA_ACERTO_ESTOQUE}    ${TEMPO_TELA}

Então excluo o acerto 

    FOR    ${I}    IN RANGE    5
        
        Press Special Key    TAB
        
    END

    FOR    ${I}    IN RANGE    10
        
        Press Special Key    DOWN
        
    END
    
    Press Combination    KEY.ALT     Key.X 
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${AVISO_EXCLUIR_ACERTO}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    Check If Exists In Database    SELECT * FROM acertoestoque WHERE CodigoProduto = ${COD_PRODUTO} AND (`Data` = CURDATE() AND Cancelado = 1) AND (Qtde = ${QUANTIDADE_ACERTO})