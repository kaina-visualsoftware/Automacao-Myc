# AGENTS.md - Padrões e Convenções do Projeto mycommerce-automacao

## 🤖 Uso de Skills e Sub-Agentes

Eu devo usar **proativamente** as skills e sub-agentes quando tarefas relacionadas surgirem, sem pedir confirmação:

| Skill/Agent | Quando usar |
|-------------|-------------|
| `Geração de Test Cases` | Criar novos testes e templates |
| `Análise de Código` | Mapear keywords, inventariar módulos |
| `Padrões de Desenvolvimento` | Entender arquitetura e padrões |
| `Documentação dos Frameworks` | Consultar APIs e sintaxe |
| `Grill with Docs` | Testar ideias contra o domínio |
| `subagent:explore` | Explorar código, buscar padrões |
| `subagent:general` | Executar múltiplas tarefas complexas |
| `Validador BDD` | **APÓS criar/modificar arquivos .robot** - validar padrões BDD |

**Regra: Sempre executar o `Validador BDD` após criar um novo arquivo `.robot` em `KeyWords/` ou `TestsCases/`**

---

## 1. Visão Geral do Projeto

Este projeto contém automação de testes para o sistema ERP myCommerce utilizando Robot Framework com SikuliLibrary para automação de interface gráfica e DatabaseLibrary para validações no banco de dados.

**Stack Tecnológico:**
- Robot Framework
- SikuliLibrary (automação UI via imagens)
- DatabaseLibrary (validações SQL)
- Python (libs auxiliares)

---

## 2. Estrutura de Diretórios

```
mycommerce-automacao/
├── Testes_BancoAleatorio/
│   ├── KeyWords/          # Implementação (COMO testar)
│   ├── TestsCases/        # Fluxo de teste (O QUE testar)
│   ├── utils/             # Recursos compartilhados
│   ├── libs/              # Bibliotecas Python auxiliares
│   └── images/            # Todas as imagens .png (diretório único, sem subpastas)
├── docs/                  # Documentação do projeto
└── readme.md              # Documentação principal
```

**Regra Importante (R1):** Os diretórios em `KeyWords/` e `TestsCases/` devem ser espelhados:

```
KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot
TestsCases/Comercial/Ordem de Servico/Teste_OS_Regressao.robot
```

---

## 3. Padrão BDD (Behavior-Driven Development)

### Palavras-chave em Português

O projeto utiliza BDD com palavras-chave em português:

```robot
*** Test Cases ***
Teste 01 - Descrição do teste
    [Tags]    Teste01

    Dado que acesso a tela de ordens de serviços
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    Então gravo a ordem de serviço
```

### Regras de Sintaxe (R2)

- **Verbos no infinitivo**: "Dado que acesso", "Quando insiro", "Então finalizo"
- **Primeira letra maiúscula**: "Dado que", "Quando", "Então", "E"
- **Argumentos entre parênteses**: `Keyword(${Variavel})`
- **Namespace para ambiguidades**: `KeyModulo.NomeDaKeyword`

### Hierarquia BDD

1. **Dado (Given)** - Contexto/pré-condição
2. **Quando (When)** - Ação principal
3. **E (And)** - Passos adicionais
4. **Então (Then)** - Resultado esperado

---

## 4. Convenções de Nomenclatura de Arquivos (R3)

### Keywords (Implementação)

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Keywords Principal | `Key<Nome><N>.robot` | `KeyOrdemDeSevico1.robot` |
| Keywords Regressão | `Key<Nome>Regressao.robot` | `KeyOrdemDeServicoRegressao.robot` |

### Test Cases (Fluxo)

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Test Case | `Teste_<Nome><N>.robot` | `Teste_OS_Regressao.robot` |

### Regras de Nomenclatura

- `Key` e `Teste_` com iniciais maiúsculas
- `<Nome>` segue CamelCase (primeira letra maiúscula)
- `<N>` é número sequencial (1, 2, 3...)
- Sem acentos ou caracteres especiais
- Sem underscores no nome dos arquivos Robot (exceto no prefixo `Teste_`)

---

## 5. Convenções de Nomenclatura de Variáveis

### Variáveis de Imagem (R4)

| Prefixo | Tipo de Elemento | Exemplo de Variável | Exemplo de Arquivo |
|---------|------------------|---------------------|--------------------|
| `${TELA_}` | Telas/janelas | `${TELA_ORDEM_SERVICO}` | `tela_OrdemServico.png` |
| `${AVISO_}` | Avisos/alertas | `${AVISO_CLIENTE_NAO_CADASTRADO}` | `aviso_ClienteNaoCadastrado.png` |
| `${BT_}` | Botões | `${BT_SALVAR}` | `bt_Salvar.png` |
| `${BTN_}` | Botões (alternativo) | `${BTN_CANCELAR}` | `btn_Cancelar.png` |
| `${INPUT_}` | Campos de entrada | `${INPUT_CPF}` | `input_CPF.png` |
| `${LB_}` | Labels/rótulos | `${LB_CLIENTE}` | `lb_Cliente.png` |
| `${MODAL_}` | Modais/popups | `${MODAL_CONFIRMAR}` | `modal_Confirmar.png` |
| `${ROW_}` | Linhas de grid | `${ROW_ITEM}` | `row_Item.png` |
| `${ABA_}` | Abas/tabs | `${ABA_DADOS}` | `aba_Dados.png` |
| `${ICONE_}` | Ícones | `${ICONE_SALVAR}` | `icone_Salvar.png` |

### Variáveis de Banco de Dados (R6)

```robot
${DBHost}    ${config.IpServidor}
${DBName}    ${config.Database}
${DBPass}    vssql
${DBPort}    ${config.Porta}
${DBUser}    root
```

### Variáveis de Tempo (R7)

```robot
${SLEEP_BAIXO}    0.7
${SLEEP_MEDIO}    1.5
${SLEEP_ALTO}     3
${TEMPO_TELA}     25
```

---

## 6. Padrão de Seções Obrigatórias (R5)

Todo arquivo Robot deve conter:

```robot
*** Settings ***
Documentation    Descrição do arquivo
Library          SikuliLibrary
Library          DatabaseLibrary

Resource         ${EXECDIR}/caminho/para/recurso.robot

*** Variables ***
${VAR_EXEMPLO}    valor


*** Keywords ***
Nome da Keyword
    [Arguments]    ${arg1}    ${arg2}
    Log    Executando keyword


*** Test Cases ***
Nome do Teste
    [Tags]    Teste01
    Dado que acesso a tela
    Quando faco uma acao
    Entao valido o resultado
```

---

## 7. Recursos Compartilhados (Utils)

### Arquivos em `Testes_BancoAleatorio/utils/`

| Arquivo | Propósito |
|---------|-----------|
| `utils.robot` | Funções reutilizáveis de UI, seleção de vendedor/cliente, inserção de produtos |
| `validacaoAviso.robot` | Tratamento de popups/warnings, validação de parâmetros |
| `montadorDeCenarios.robot` | Cenários pré-construídos (vendas, pedidos, devoluções) |
| `parametros_pre_condicoes.robot` | Gerenciamento e restauração de parâmetros do banco |
| `myCommerce.robot` | Operações de login/logout |
| `parametros_admin_sistema.robot` | Configuração de parâmetros do sistema |

### Padrão de Import

```robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Modulo/Submodulo/KeyNome1.robot
```

---

## 8. Biblioteca Python (libs)

### Arquivos em `Testes_BancoAleatorio/libs/`

| Arquivo | Propósito |
|---------|-----------|
| `leituraConfig.py` | Lê configuração do myCommerce |
| `validaParametros.py` | Valida parâmetros do sistema no banco |
| `validaComissoes.py` | Validação de cálculos de comissão |
| `estoque.py` | Validação de movimento de estoque |
| `verificacoesExtras.py` | Funções de verificação adicionais |
| `validaTelasIni.py` | Validação de telas iniciais |
| `configPorUsuarioWin.py` | Configuração específica por usuário |

---

## 9. Padrões de Imagens

### Diretório de Imagens

Todas as imagens devem ser armazenadas em: `Testes_BancoAleatorio/images/` (diretório único, sem subpastas).

### Diretrizes para Captura de Imagens

- **Resolução**: 1920x1080 (Full HD)
- **Minimizar**: Capturar a menor área que identifica exclusivamente o elemento
- **Evitar**: Valores variáveis (CPF, preços, nomes), telas inteiras
- **Formato**: PNG, preferencialmente com fundo transparente

---

## 10. Padrão de Setup/Teardown (R9)

### Suite Setup

```robot
Suite Setup    Run Keywords
...    Start Sikuli Process
...    AND    KeyNome1.Ler imagens iniciais
...    AND    Conectar ao Banco de Dados
...    AND    Preparar Ambiente MyCommerce
```

### Suite Teardown

```robot
Suite Teardown    Stop Remote Server
```

### Test Teardown (Opcional)

```robot
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar
```

### Componentes do Setup

1. **Start Sikuli Process**: Inicializa SikuliLibrary
2. **Ler imagens iniciais**: Carrega caminhos das imagens com `Add Image Path`
3. **Conectar ao Banco de Dados**: Conecta ao MySQL usando DatabaseLibrary
4. **Preparar Ambiente MyCommerce**: Carrega parâmetros do sistema via `Carregar parâmetros do sistema`

---

## 11. Regras Obrigatórias (R1-R11)

| Regra | Descrição |
|-------|-----------|
| **R1** | Separar KeyWords e TestCases com estrutura de diretórios espelhada |
| **R2** | Usar BDD em português (Dado/Quando/Então/E) |
| **R3** | Nomenclatura de arquivos: `Key<Nome>N.robot` / `Teste_<Nome>N.robot` |
| **R4** | Variáveis de imagem com prefixos: `${TELA_}`, `${AVISO_}`, `${BT_}`, etc. |
| **R5** | Seções obrigatórias: `*** Settings ***`, `*** Variables ***`, `*** Keywords ***` ou `*** Test Cases ***` |
| **R6** | Variáveis de conexão BD: DBHost, DBName, DBPass, DBPort, DBUser |
| **R7** | Tempos de espera padronizados: SLEEP_BAIXO=0.7, SLEEP_MEDIO=1.5, SLEEP_ALTO=3, TEMPO_TELA=25 |
| **R8** | Namespacing: Usar `SikuliLibrary.Click` quando houver ambiguidade |
| **R9** | Padrão Setup/Teardown: Sikuli → imagens → BD → prepara; Teardown: Stop Remote Server |
| **R10** | Tags sequenciais: `Teste01`, `Teste02`, `Teste03`, etc. |
| **R11** | Botões genéricos: Se o botão for genérico (Adicionar, Editar, Excluir, Gravar, Salvar, Ok, Sim, Não, Fechar, Sair), verificar se existe keyword genérica em `utils.robot`. Se não existir, criar a keyword lá e usar nos lugares que precisar. |

---

## 12. Padrão de Tags

### Tags Sequenciais (Obrigatório - R10)

```robot
*** Test Cases ***
Teste 01 - Descrição
    [Tags]    Teste01

Teste 02 - Descrição
    [Tags]    Teste02

Teste 03 - Descrição
    [Tags]    Teste03
```

### Tags de Categoria (Opcional)

```robot
[Tags]    Smoke
[Tags]    Regression
[Tags]    OrdemServico
```

---

## 13. Padrões de Query no Banco

### Consultas

```robot
${consulta}    Query    SELECT Codigo FROM tabela ORDER BY Codigo DESC LIMIT 1;

${resultado}    Query    SELECT c.CPF FROM clientes c WHERE c.Ativo = -1 LIMIT 1;
```

### Validações

```robot
Check If Exists In Database    SELECT * FROM tabela WHERE condicao;

Check If Not Exists In Database    SELECT * FROM tabela WHERE condicao;
```

### Atualizações

```robot
Execute Sql String    UPDATE tabela SET coluna = valor;
```

---

## 14. Gerenciamento de Conflitos de Keywords

### Quando usar Namespace (R8)

Quando uma keyword existe em mais de um arquivo importado, usar prefixo para evitar ambiguidade:

```robot
KeyOrdemDeSevico1.Dado que acesso a tela de ordens de serviços
KeyOrdemDeServicoRegressao.Entao gravo a ordem de serviço
```

---

## 15. Reutilização de Keywords

### Boas Práticas

1. **Separar preocupações**: Keywords em arquivo separado dos test cases
2. **Usar resources compartilhados**: Quando possível, reutilizar keywords de `utils.robot`
3. **Namespace para conflitos**: Quando necessário, usar prefixo do arquivo
4. **Validação CPF**: Tipar sem máscara na tela, validar no banco com remoção de máscara

### Exemplo de Estrutura

```robot
# KeyWords/Modulo/KeyNomeRegressao.robot
*** Settings ***
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Modulo/KeyNome1.robot

*** Keywords ***
Dado que acesso a tela para regressão
    KeyNome1.Dado que acesso a tela

Quando inicio uma nova operação
    KeyNome1.Quando pressiono o atalho de adicionar
```

---

## 16. Exemplo Completo de Test Case

```robot
*** Settings ***
Documentation    Teste de Regressão - Ordem de Serviço

Resource    ../../../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeServicoRegressao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar


*** Test Cases ***
Teste 01 - Criar OS validando cliente por CPF
    [Tags]    Teste01

    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo o cliente pelo CPF
    E acesso a aba de pagamentos
    Então gravo a ordem de serviço
    Então a ordem de serviço deve estar salva no banco com os dados corretos


Teste 02 - Validar CPF não cadastrado na OS
    [Tags]    Teste02

    Dado que gravo o código da última OS existente
    Dado que acesso a tela de ordens de serviços para regressão
    Quando inicio uma nova ordem de serviço
    E informo o vendedor
    E informo a tabela de preço
    E informo cliente com CPF não existente
    Então nenhuma OS deve ter sido persistida no banco
```

---

## Resumo das Regras Essenciais

1. ✅ Estrutura espelhada KeyWords/TestsCases
2. ✅ BDD em português (Dado/Quando/Então/E)
3. ✅ Nomenclatura: `Key<Nome>N.robot` / `Teste_<Nome>N.robot`
4. ✅ Imagens: prefixos `${TELA_}`, `${AVISO_}`, `${BT_}`, etc.
5. ✅ Seções obrigatórias no arquivo Robot
6. ✅ Conexão DB: variáveis padrão
7. ✅ Tempos: SLEEP_BAIXO/MÉDIO/ALTO
8. ✅ Namespace para ambiguidades
9. ✅ Setup: Sikuli → imagens → BD → prepara
10. ✅ Tags: Teste01, Teste02, etc.