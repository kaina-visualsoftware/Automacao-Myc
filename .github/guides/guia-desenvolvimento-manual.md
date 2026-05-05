# Guia: Como Desenvolver Testes Manualmente

> **Público-alvo**: Desenvolvedores iniciantes que precisam criar testes do zero, sem assistência de IA.

---

## Visão Geral

Este projeto automatiza testes no ERP desktop **myCommerce** usando reconhecimento visual de imagens. A automação tira prints de pedaços da tela e usa esses prints para localizar botões, campos e janelas no sistema.

### Tecnologias

| Tecnologia | Para quê serve |
|---|---|
| **Robot Framework** | Linguagem de automação de testes (arquivos `.robot`) |
| **SikuliLibrary** | Reconhecimento visual — encontra imagens na tela e clica nelas |
| **ImageHorizonLibrary** | Pressionar teclas especiais e combinações de teclas |
| **DatabaseLibrary** | Consultar e validar dados no banco MySQL |
| **FakerLibrary** | Gerar dados aleatórios |
| **Python** | Bibliotecas auxiliares de validação |

---

## Pré-Requisitos

```bash
python --version           # Python 3.9.13+
pip install robotframework
pip install robotframework-SikuliLibrary
pip install robotframework-imagehorizonlibrary
pip install robotframework-faker
pip install robotframework-databaselibrary
pip install mysql-connector-python
pip install pymysql
```

Também necessário: VS Code, Java 8+, acesso ao banco MySQL do myCommerce.

---

## Estrutura de Pastas

```
Testes_BancoAleatorio/
├── images/        ← TODAS as imagens .png ficam AQUI
├── KeyWords/      ← Keywords (as ações/passos do teste)
│   ├── Comercial/
│   ├── Financeiro/
│   └── ...
├── TestsCases/    ← Test Cases (os testes em si)
│   ├── Comercial/
│   ├── Financeiro/
│   └── ...
├── utils/         ← Keywords compartilhadas
└── libs/          ← Bibliotecas Python
```

**Regra de Ouro**: `TestsCases/` define O QUE testar. `KeyWords/` define COMO executar.

---

## Passo a Passo: Criando um Teste

### 1. Identifique o Módulo
- O módulo já existe em `KeyWords/` e `TestsCases/`? → crie novos arquivos dentro
- Não existe? → crie pastas espelhadas

### 2. Mapeie o Fluxo Manual
Faça manualmente no myCommerce e anote:
- Qual tecla/menu abre a tela?
- Que tela aparece ao abrir?
- Quais campos preencher?
- Quais botões clicar?
- Quais avisos/popups podem aparecer?
- Como confirmar que a operação foi feita?

### 3. Capture as Imagens

Use **Win + Shift + S** para capturar. Salve como **PNG** em `images/`.

| Tipo | Prefixo | O que capturar |
|---|---|---|
| Tela/Janela | `tela_` | Apenas a barra de título |
| Botão | `bt_` | Botão inteiro com bordas |
| Label | `lb_` | Rótulo ao lado do campo |
| Input | `input_` | Campo de entrada |
| Modal/Popup | `modal_` | Texto mais específico |
| Aviso | `aviso_` | Linha de texto do aviso |
| Linha grid | `row_` | Indicador de inclusão |

**Regras de captura**:
- Menor área possível que identifique o elemento
- Elementos estáticos (títulos, labels, ícones) — nunca dados variáveis
- Mesma resolução do teste (1920x1080)
- Sempre PNG, nunca JPG

### 4. Crie o Arquivo de Keywords
Localização: `KeyWords/<Módulo>/<SubMódulo>/Key<Nome>1.robot`

```robot
*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Variables    ../../../libs/leituraConfig.py
Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
${IMAGENS}          ./Testes_BancoAleatorio/images
${DBHost}           ${config.IpServidor}
${DBName}           ${config.Database}
${DBPass}           vssql
${DBPort}           ${config.Porta}
${DBUser}           root
${SLEEP_BAIXO}      0.7
${SLEEP_MEDIO}      1.5
${SLEEP_ALTO}       3
${TEMPO_TELA}       25

${TELA_EXEMPLO}     tela_Exemplo.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de exemplo
    Press Special Key    F5
    Wait Until Screen Contain    ${TELA_EXEMPLO}    ${TEMPO_TELA}
```

### 5. Crie o Arquivo de Test Case
Localização: `TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome>1.robot`

```robot
*** Settings ***
Documentation    Testes de exemplo
Resource    ../../../KeyWords/<Módulo>/<SubMódulo>/Key<Nome>1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Key<Nome>1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Descrição do teste
    [Tags]    Teste01
    Dado que acesso a tela de exemplo
    E adiciono um novo item
    Então salvo o cadastro
```

### 6. Execute e Valide

```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ -i Teste01 .\TestsCases\<Módulo>\<SubMódulo>\Teste_<Nome>1.robot
```

> **IMPORTANTE**: Clique na tela do myCommerce após iniciar a execução!

---

## Keywords Reutilizáveis Prontas

### utils/utils.robot
| Keyword | Uso |
|---|---|
| `Adicionar Vendedor e Cliente(${TELA})` | `utils.Adicionar Vendedor e Cliente(Venda)` |
| `Inserir Produto normal - Necessita de estoque` | Insere produto aleatório com estoque |
| `E saio da tela(${TELA})` | `E saio da tela(Condicional)` |
| `Valida solicitação de senha do usuário supervisor` | Trata popup de senha |

### utils/montadorDeCenarios.robot
```robot
Dado que realizo uma venda completa, com produto normal
Dado que realizo um pedido, com produto normal
Dado que realizo uma devolução completa da venda
```

---

## Depuração

| Tipo de Falha | Sintoma | Solução |
|---|---|---|
| Imagem não encontrada | Timeout em `Wait Until Screen Contain` | Re-capturar na resolução correta |
| Aviso inesperado | Popup bloqueou execução | Tratar em `validacaoAviso.robot` |
| Dados do banco | Query retorna vazio | Verificar dados no banco |
| Timing | Ação executada cedo demais | Aumentar Sleep |
| Foco da janela | Teclas foram para outra janela | Clicar na tela antes da ação |

---

## Checklist

- [ ] Módulo identificado
- [ ] Diretórios espelhados criados
- [ ] Imagens capturadas em `images/`
- [ ] Variáveis com prefixo correto
- [ ] Keywords BDD em português
- [ ] Test Cases com Tags sequenciais
- [ ] Suite Setup/Teardown configurados
- [ ] Teste executado localmente
