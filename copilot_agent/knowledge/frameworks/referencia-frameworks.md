# Referência dos Frameworks — myCommerce Automação

## Contexto
Referência rápida e precisa sobre os frameworks utilizados no projeto de automação Desktop do myCommerce.

---

## 1. Robot Framework

**Documentação Oficial**: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html

### Estrutura de Arquivo `.robot`

```robot
*** Settings ***
Library    NomeDaBiblioteca
Resource   caminho/para/resource.robot
Variables  caminho/para/variables.py

Suite Setup       Keyword De Configuração
Suite Teardown    Keyword De Limpeza

*** Variables ***
${VARIAVEL_ESCALAR}    valor
@{VARIAVEL_LISTA}      item1    item2
&{VARIAVEL_DICT}       chave1=valor1    chave2=valor2

*** Test Cases ***
Nome Do Teste
    [Tags]    tag1    tag2
    [Documentation]    Descrição do teste
    Keyword Um    argumento1
    Keyword Dois

*** Keywords ***
Nome Da Keyword
    [Arguments]    ${arg1}    ${arg2}=default
    [Documentation]    Descrição da keyword
    Log    ${arg1}
    RETURN    resultado
```

### Seções Principais

| Seção | Descrição |
|---|---|
| `*** Settings ***` | Imports de libraries, resources e configuração de suite |
| `*** Variables ***` | Definição de variáveis (escalares `${}`, listas `@{}`, dicts `&{}`) |
| `*** Test Cases ***` | Casos de teste (um por bloco, indentados com 4 espaços) |
| `*** Keywords ***` | Keywords reutilizáveis |

### Separador de Colunas

Robot Framework usa **2+ espaços** como separador entre argumentos. Um único espaço faz parte do nome.

```robot
# Correto (4 espaços entre keyword e argumento)
Click    ${IMAGEM}
# Errado (1 espaço — seria interpretado como parte do nome)
Click ${IMAGEM}
```

### Controle de Fluxo

```robot
# IF/ELSE
IF    ${condição}
    Keyword A
ELSE IF    ${outra_condição}
    Keyword B
ELSE
    Keyword C
END

# FOR loop
FOR    ${item}    IN    @{lista}
    Log    ${item}
END

FOR    ${i}    IN RANGE    10
    Log    ${i}
END

# TRY/EXCEPT
TRY
    Keyword Que Pode Falhar
EXCEPT    mensagem de erro
    Keyword De Tratamento
END
```

### Variáveis Especiais

| Variável | Descrição |
|---|---|
| `${EMPTY}` | String vazia |
| `${None}` | Valor None/null |
| `${True}` / `${False}` | Booleanos |
| `${TEST_NAME}` | Nome do teste em execução |
| `${SUITE_NAME}` | Nome da suite em execução |

### Keywords Úteis (BuiltIn)

| Keyword | Uso |
|---|---|
| `Set Test Variable` | Define variável visível no teste atual |
| `Set Suite Variable` | Define variável visível na suite |
| `Run Keyword And Return Status` | Executa keyword e retorna True/False |
| `Run Keywords` | Executa múltiplas keywords em sequência |
| `Should Be Equal` | Asserção de igualdade |
| `Should Contain` | Asserção de conteúdo |
| `Log To Console` | Imprime no console |
| `Fail` | Falha o teste com mensagem |
| `Sleep` | Espera N segundos |
| `Evaluate` | Avalia expressão Python |
| `Create List` | Cria uma lista vazia ou com itens |
| `Append To List` | Adiciona item a uma lista |
| `Get Length` | Retorna o tamanho de uma coleção |
| `Get From List` | Retorna item de uma lista por índice |

### Execução via Linha de Comando

```bash
# Executar toda uma suite
robot -d ./results ./TestsCases/Comercial/Condicional/Teste_Condicional1.robot

# Executar apenas um teste por tag
robot -d ./results -i Teste01 ./TestsCases/Comercial/Condicional/Teste_Condicional1.robot

# Executar um teste específico por nome
robot -d ./results --test "Teste 01 - Lançamento de condicional" ./Teste_Condicional1.robot
```

---

## 2. SikuliLibrary (robotframework-SikuliLibrary)

**Documentação Oficial**: https://sikulix.github.io/docs/

### Setup

```robot
*** Settings ***
Library    SikuliLibrary

*** Keywords ***
Inicializar
    Start Sikuli Process
    Add Image Path    ./Testes_BancoAleatorio/images
```

### Keywords Principais

| Keyword | Uso | Exemplo |
|---|---|---|
| `Start Sikuli Process` | Inicia o servidor Sikuli (Suite Setup) | `Start Sikuli Process` |
| `Stop Remote Server` | Para o servidor (Suite Teardown) | `Stop Remote Server` |
| `Add Image Path` | Adiciona caminho de imagens | `Add Image Path    ${IMAGENS}` |
| `Click` | Clica na imagem encontrada na tela | `SikuliLibrary.Click    ${BOTAO}` |
| `Double Click` | Duplo clique na imagem | `SikuliLibrary.Double Click    ${INPUT}` |
| `Wait Until Screen Contain` | Espera imagem aparecer (com timeout) | `Wait Until Screen Contain    ${TELA}    25` |
| `Screen Should Contain` | Verifica se imagem está na tela | `Screen Should Contain    ${TELA}` |
| `Screen Should Not Contain` | Verifica que imagem NÃO está na tela | `Screen Should Not Contain    ${AVISO}` |
| `Input Text` | Digita texto no campo ativo | `Input Text    ${EMPTY}    texto` |
| `Type` | Digita texto (alternativa) | `Type    ${EMPTY}    texto` |
| `Exists` | Verifica se imagem existe (retorna True/False) | `${existe}    Exists    ${IMAGEM}` |

### Reconhecimento Visual

- Usa **imagens .png** para encontrar elementos na tela
- As imagens são screenshots recortados dos elementos visuais
- A busca é feita por **similaridade visual** (pattern matching)
- O timeout padrão de `Wait Until Screen Contain` deve ser suficiente para a aplicação carregar

### Resolução de Nomes

Quando há conflito com keywords de mesmo nome, usar prefixo:

```robot
SikuliLibrary.Click    ${IMAGEM}
SikuliLibrary.Double Click    ${INPUT}
```

---

## 3. ImageHorizonLibrary

**Documentação**: https://eficode.github.io/robotframework-imagehorizonlibrary/

Biblioteca complementar para interação via teclado.

### Keywords Principais

| Keyword | Uso | Exemplo |
|---|---|---|
| `Press Special Key` | Pressiona tecla especial | `Press Special Key    F11` |
| `Press Combination` | Pressiona combinação de teclas | `Press Combination    KEY.ALT    KEY.A` |

### Teclas Especiais

```robot
# Teclas de função
Press Special Key    F1
Press Special Key    F11

# Teclas de navegação
Press Special Key    TAB
Press Special Key    ENTER
Press Special Key    ESC
Press Special Key    SPACE

# Combinações com ALT (atalhos do myCommerce)
Press Combination    KEY.ALT    KEY.A    # Adicionar
Press Combination    KEY.ALT    KEY.E    # Editar
Press Combination    KEY.ALT    KEY.x    # Excluir
Press Combination    KEY.ALT    KEY.G    # Gravar/Gerar
Press Combination    KEY.ALT    KEY.F    # Finalizar
Press Combination    KEY.ALT    KEY.D    # Detalhes
Press Combination    KEY.ALT    KEY.S    # Sim/Confirmar
Press Combination    KEY.ALT    KEY.N    # Não
Press Combination    KEY.ALT    KEY.U    # Visualizar
Press Combination    KEY.ALT    KEY.V    # Venda parcial
Press Combination    KEY.ALT    KEY.P    # Produto
Press Combination    KEY.ALT    KEY.r    # Retornar
Press Combination    KEY.ALT    KEY.I    # Incluir
Press Combination    KEY.ALT    KEY.C    # Confirmar
```

---

## 4. DatabaseLibrary

**Documentação**: https://github.com/franz-see/Robotframework-Database-Library

### Setup de Conexão

```robot
*** Settings ***
Library    DatabaseLibrary

*** Keywords ***
Conectar ao Banco de Dados
    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
```

### Keywords Principais

| Keyword | Uso | Exemplo |
|---|---|---|
| `Query` | Executa SELECT e retorna resultado | `${result}    Query    SELECT * FROM tabela;` |
| `Check If Exists In Database` | Verifica se query retorna registros | `Check If Exists In Database    SELECT * FROM vendas WHERE id=1;` |
| `Check If Not Exists In Database` | Verifica se query NÃO retorna registros | `Check If Not Exists In Database    SELECT * FROM vendas WHERE Status='x';` |
| `Execute Sql String` | Executa SQL arbitrário (INSERT/UPDATE/DELETE) | `Execute Sql String    UPDATE config SET param=1;` |

### Padrão de Resultado de Query

```robot
# Query retorna lista de tuplas: [[valor1, valor2], [valor3, valor4]]
${resultado}    Query    SELECT Codigo, Nome FROM clientes LIMIT 2;

# Acessar primeiro registro, primeiro campo
${codigo}    Set Variable    ${resultado[0][0]}

# Acessar primeiro registro, segundo campo
${nome}    Set Variable    ${resultado[0][1]}
```

---

## 5. FakerLibrary

**Documentação**: https://guykisel.github.io/robotframework-faker/

Geração de dados aleatórios para testes.

```robot
*** Settings ***
Library    FakerLibrary    locale=pt_BR

*** Keywords ***
Gerar Dados
    ${nome}    FakerLibrary.Name
    ${cpf}     FakerLibrary.Cpf
    ${email}   FakerLibrary.Email
```

---

## Referências Rápidas

| Framework | Documentação |
|---|---|
| Robot Framework | https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html |
| SikuliX | https://sikulix.github.io/docs/ |
| DatabaseLibrary | https://github.com/franz-see/Robotframework-Database-Library |
| ImageHorizonLibrary | https://eficode.github.io/robotframework-imagehorizonlibrary/ |
| FakerLibrary | https://guykisel.github.io/robotframework-faker/ |
