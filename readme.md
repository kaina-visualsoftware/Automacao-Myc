# MyCommerce Automação

Projeto de automação de testes para o sistema ERP desktop **myCommerce**, utilizando Robot Framework com SikuliLibrary para reconhecimento visual de imagens.

---

## Tecnologias Utilizadas

| Tecnologia | Descrição |
|------------|-----------|
| **Python 3.12+** | Linguagem de programação principal |
| **Robot Framework** | Framework de automação de testes |
| **SikuliLibrary** | Reconhecimento visual de imagens na tela |
| **ImageHorizonLibrary** | Interação via teclado e teclas especiais |
| **DatabaseLibrary** | Consultas e validações no banco de dados MySQL |
| **FakerLibrary** | Geração de dados aleatórios para testes |
| **Java 8+** | Necessário para o SikuliLibrary funcionar |

---

## Pré-Requisitos

Para executar os testes automatizados, é necessário:

1. **Visual Studio Code** com extensão **RobotCode** (`d-biehl.robotcode`)
2. **Python 3.12** ou superior (instalado para todos os usuários e adicionado ao PATH)
3. **Java JDK 8** ou superior (com variável JAVA_HOME configurada no sistema)
4. **Acesso ao banco de dados MySQL** do myCommerce

---

## Instalação

### 1. Clone o repositório

```bash
git clone <repositorio>
cd mycommerce-automacao
```

### 2. Configure o ambiente

#### Python
Instale o Python para Windows **para todos os usuários** e marque a opção "Add to PATH" durante a instalação.

#### Java
Instale o JDK e configure a variável de ambiente `JAVA_HOME` no sistema:
- Variável: `JAVA_HOME`
- Valor: `C:\Program Files\Java\jdk-17` (ou versão instalada)

### 3. Instale as dependências

```bash
pip install -r docs/requirements.txt
```

**Dependências do projeto:**
- robotframework
- robotframework-SikuliLibrary
- robotframework-imagehorizonlibrary
- robotframework-databaselibrary
- robotframework-faker
- mysql-connector-python
- pymysql

---

## Estrutura do Projeto

```
mycommerce-automacao/
├── .github/                    # Configurações do GitHub (AI Assistant)
│   ├── skills/                   # Skills especializadas
│   ├── knowledge/               # Base de conhecimento
│   ├── guides/                  # Guias de desenvolvimento
│   └── instructions/             # Regras globais
├── Testes_BancoAleatorio/        # Principal diretório de testes
│   ├── images/                  # Todas as imagens .png para Sikuli
│   ├── KeyWords/                # Keywords organizadas por módulo
│   │   ├── Comercial/           # Vendas, Condicional, OS, etc.
│   │   ├── Financeiro/          # Caixa, Contas a Pagar, etc.
│   │   ├── Emissão/             # Notas Fiscais, Carregamento
│   │   └── Login/               # Teste de login
│   ├── TestsCases/              # Test Cases espelhando KeyWords/
│   ├── utils/                   # Keywords compartilhadas
│   │   ├── utils.robot          # Funções reutilizáveis
│   │   ├── montadorDeCenarios.robot  # Cenários compostos
│   │   ├── validacaoAviso.robot      # Tratamento de popups
│   │   └── parametros_pre_condicoes.robot
│   └── libs/                    # Bibliotecas Python
│       ├── validaParametros.py
│       ├── validaComissoes.py
│       ├── estoque.py
│       ├── leituraConfig.py
│       └── verificacoesExtras.py
├── Executar_Automacao.py         # Script principal de execução
└── docs/                         # Documentação
    └── requirements.txt         # Dependências Python
```

---

## Como Executar os Testes

### Executar um arquivo de teste específico

```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Executar um teste específico por tag

```powershell
robot -d .\results\ -i Teste01 .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Executar múltiplos testes por tags

```powershell
robot -d .\results\ -i Teste03 -i Teste04 .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Executar todos os testes via script

```powershell
cd C:\Automacao\mycommerce-automacao
python Executar_Automacao.py
```

> **IMPORTANTE**: Clique na tela do myCommerce após iniciar a execução para garantir foco!

---

## Como Criar Novos Testes

### Usando o GitHub (Recomendado)

Basta descrever o que você quer em linguagem natural:

```
"Crie um teste para o módulo de Cadastro de Fornecedores. 
O atalho para abrir é F9. Preciso testar: inclusão, edição e exclusão."
```

O GitHub automaticamente ativa a skill `geracao-testcases` e gera os arquivos automaticamente.

### Manual (usando a estrutura do projeto)

#### Passo 1: Identifique o Módulo
Determine qual funcionalidade do myCommerce será testada.

#### Passo 2: Crie a Estrutura de Diretórios
```
Testes_BancoAleatorio/
├── KeyWords/<Módulo>/<SubMódulo>/
└── TestsCases/<Módulo>/<SubMódulo>/
```

#### Passo 3: Capture as Imagens
Use **Win + Shift + S** para capturar elementos da tela:
- **Telas**: `tela_NomeTela.png`
- **Botões**: `bt_NomeBotao.png`
- **Inputs**: `input_NomeInput.png`
- **Labels**: `lb_NomeLabel.png`
- **Avisos**: `aviso_NomeAviso.png`

Salve em `Testes_BancoAleatorio/images/`

#### Passo 4: Crie o Arquivo de Keywords
Localização: `KeyWords/<Módulo>/<SubMódulo>/Key<Nome><N>.robot`

#### Passo 5: Crie o Arquivo de Test Cases
Localização: `TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome><N>.robot`

---

## Padrões e Convenções (Regras R1-R10)

### R1 — Separação KeyWords/TestCases
Keywords em `KeyWords/<Módulo>/` e TestCases em `TestsCases/<Módulo>/` com diretórios espelhados.

### R2 — BDD em Português
Keywords nomeadas com Dado/Quando/Então/E:
```
Dado que acesso a tela de comissões
Quando insiro o vendedor comissionado
E seleciono a comissão de produtos
Então baixo a comissão recebida
```

### R3 — Nomenclatura de Arquivos
- Keywords: `Key<Nome>1.robot`
- Test Cases: `Teste_<Nome>1.robot`

### R4 — Variáveis de Imagem com Prefixo
- `${TELA_}` — Telas/janelas
- `${AVISO_}` — Avisos/alertas
- `${BT_}` — Botões
- `${LB_}` — Labels/rótulos
- `${MODAL_}` — Modais/popups
- `${ROW_}` — Linhas de grid

### R5 — Seções Obrigatórias
Todo arquivo `.robot` deve ter:
```
*** Settings ***
*** Variables ***
*** Keywords ***  (ou *** Test Cases ***)
```

### R6 — Conexão com Banco de Dados
Variáveis DBHost, DBName, DBPass, DBPort, DBUser sempre presentes nos arquivos de Keywords.

### R7 — Tempos de Espera Padronizados
```robot
${SLEEP_BAIXO}   0.7
${SLEEP_MEDIO}   1.5
${SLEEP_ALTO}    3
${TEMPO_TELA}    25
```

### R8 — Namespacing
Usar `SikuliLibrary.Click` quando há ambiguidade com outras libraries.

### R9 — Suite Setup/Teardown
TestCases devem ter:
- **Suite Setup**: Start Sikuli → Ler imagens → Conectar BD → Preparar Ambiente
- **Suite Teardown**: Stop Remote Server

### R10 — Tags Sequenciais
Todo test case deve ter `[Tags]` sequencial:
```robot
Teste 01 - Descrição
    [Tags]    Teste01

Teste 02 - Descrição
    [Tags]    Teste02
```

---

## Atalhos do myCommerce

| Atalho | Ação |
|--------|------|
| F5 | Atualizar |
| F11 | Abre Condicionais |
| ALT+A | Adicionar |
| ALT+E | Editar |
| ALT+x | Excluir |
| ALT+F | Finalizar |
| ALT+G | Gravar / Gerar |
| ALT+S | Sim / Confirmar |
| ALT+D | Detalhes |
| ESC | Cancelar / Voltar |
| TAB | Próximo campo |
| ENTER | Confirmar |

---

## Base de Conhecimento

### Guias de Desenvolvimento

- `.github/guides/guia-desenvolvimento-manual.md` — Desenvolvimento manual passo a passo
- `.github/guides/guia-desenvolvimento-com-ia.md` — Desenvolvimento com assistência de IA

### Cenários de Comissão

- `.github/knowledge/comissao/comissao-produto.md` — Comissão por linha para produto
- `.github/knowledge/comissao/comissao-servico.md` — Comissão por linha para serviço
- `.github/knowledge/comissao/comissao-prod-serv.md` — Cenários combinados produto + serviço
- `.github/knowledge/comissao/comissao-escalonada.md` — Comissão escalonada
- `.github/knowledge/comissao/comissao-tabpreco.md` — Comissão por tabela de preço

### Referência de Frameworks

- `.github/knowledge/frameworks/referencia-frameworks.md` — Referência completa de Robot Framework, SikuliLibrary, DatabaseLibrary, etc.

---

## Skills do GitHub

O projeto possui 4 skills especializadas ativadas automaticamente pelo GitHub:

| Skill | Quando Usar |
|-------|-------------|
| **geracao-testcases** | Criar novos testes, gerar templates, expandir cobertura |
| **analise-codigo** | Mapear keywords, inventariar módulos, relatório de cobertura |
| **padroes-desenvolvimento** | Entender arquitetura, padrões e convenções do projeto |
| **documentacao-frameworks** | Consultar API de frameworks, sintaxe, exemplos |

---

## Como Proceder Quando um Teste Falhar?

1. **Observar a falha**: Identifique em qual keyword ocorreu o erro
2. **Verificar imagem**: A imagem esperada estava correta na tela?
3. **Isolar o teste**: Execute apenas o teste que falhou usando tags
4. **Testar manualmente**: Reproduza o fluxo manualmente para confirmar

### Tipos Comuns de Falhas

| Tipo de Falha | Solução |
|---------------|---------|
| Imagem não encontrada | Re-capturar imagem na resolução correta (1920x1080) |
| Popup inesperado | Adicionar tratamento em `validacaoAviso.robot` |
| Query sem resultado | Verificar dados no banco |
| Timing | Aumentar `Sleep` antes da ação |
| Foco errado | Clicar na tela antes de executar ações |

---

## Executor Principal

O script `Executar_Automacao.py` automatiza a execução:

1. Executa Login como primeiro teste obrigatório
2. Itera sobre todos os `.robot` em `TestsCases/`
3. Se um teste falha: fecha o ERP, re-executa login, continua
4. Gera relatórios em `Relatorios/<data>/Resultados Finais/`

---

## Referências

- [Robot Framework](https://robotframework.org/)
- [SikuliLibrary](https://sikulix.github.io/docs/)
- [Documentação myCommerce](https://docs.mycommerce.com.br/)

---

## Autor

Projeto desenvolvido por Jaime Junior

---

**Obs**: Sempre clique na tela do myCommerce após iniciar a execução para garantir foco!