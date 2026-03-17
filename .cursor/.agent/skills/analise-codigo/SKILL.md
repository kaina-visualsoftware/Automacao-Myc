---
name: Análise de Código
description: Analisa a estrutura e código do projeto mycommerce-automacao, gerando inventários e relatórios de cobertura
---

# Skill: Análise de Código

## Objetivo

Analisar o código-fonte do projeto `mycommerce-automacao` para entender a estrutura, mapear componentes e identificar cobertura de testes.

## Quando Usar

- Quando o usuário pedir para **analisar** ou **entender** o código
- Quando for necessário **inventariar** recursos existentes antes de criar algo novo
- Para gerar **relatórios de cobertura** de testes

## Procedimento

### 1. Mapear Estrutura de Diretórios

Percorrer `Testes_BancoAleatorio/` e listar:

| Diretório | Conteúdo |
|---|---|
| `KeyWords/<Módulo>/` | Keywords organizadas por módulo do ERP |
| `TestsCases/<Módulo>/` | Test Cases espelhando KeyWords |
| `utils/` | Keywords e cenários compartilhados |
| `libs/` | Bibliotecas Python auxiliares |
| `images/` | Imagens .png para reconhecimento visual |

### 2. Inventariar Módulos do ERP

Módulos atualmente cobertos:

| Módulo | Keywords | Test Cases | Status |
|---|---|---|---|
| **Comercial/Condicional** | `KeyCondicional1.robot` | `Teste_Condicional1.robot` | ✅ Coberto |
| **Comercial/Vendas** | `keyVendas1.robot` | Testes de vendas | ✅ Coberto |
| **Comercial/Devolução** | `KeyDevolucaoVenda1.robot` | Testes de devolução | ✅ Coberto |
| **Comercial/Doação** | `KeyDocao1.robot` | Testes de doação | ✅ Coberto |
| **Comercial/Orçamento** | `KeyOrcamento1.robot` | Testes de orçamento | ✅ Coberto |
| **Comercial/OS** | `KeyOrdemDeSevico1.robot` | Testes de OS | ✅ Coberto |
| **Financeiro/Caixa** | `keyCaixa1.robot` | Testes de caixa | ✅ Coberto |
| **Financeiro/Contas a Pagar** | `keyContasPagar1.robot` | Testes de contas | ✅ Coberto |
| **Login** | Keyword de login | `Teste_LoginSistema1.robot` | ✅ Coberto |
| **Descontos** | Keywords | Test Cases | ✅ Coberto |
| **Emissão** | Keywords | Test Cases | ✅ Coberto |
| **Faturamento** | Keywords | Test Cases | ✅ Coberto |
| **MyMonitorFaturamento** | Keywords | Test Cases | ✅ Coberto |
| **Pré-Venda/Pedidos** | `KeyPedidos1.robot` | Testes de pedidos | ✅ Coberto |

### 3. Inventariar Componentes Compartilhados

#### utils/utils.robot (1600+ linhas)
Contém keywords reutilizáveis:
- `Adicionar Vendedor e Cliente(${TELA})` — Adiciona vendedor e cliente em qualquer tela
- `Seleciona vendedor` — Query SQL para selecionar vendedor aleatório
- `E saio da tela(${TELA})` — Fecha tela atual (parametrizado)
- `Inserir Produto normal - Necessita de estoque` — Insere produto com estoque
- `Inserir Produto normal - Permite sem estoque` — Insere sem verificar estoque
- Variáveis globais de imagens (telas, avisos, modais, inputs, labels, botões)

#### utils/montadorDeCenarios.robot (500+ linhas)
Cenários compostos a partir de keywords de múltiplos módulos:
- `Dado que realizo uma venda completa, com produto normal`
- `Dado que realizo um pedido, com produto normal`
- `Dado que realizo uma devolução completa da venda`
- etc.

#### utils/validacaoAviso.robot
Keywords para tratar avisos/popups que o ERP pode exibir durante a execução.

#### utils/parametros_pre_condicoes.robot
Preparação do ambiente (validação de parâmetros do banco antes dos testes).

### 4. Inventariar Bibliotecas Python (`libs/`)

| Arquivo | Responsabilidade |
|---|---|
| `validaParametros.py` | Valida configurações do ERP (config, empresa, formas parcelamento) |
| `validaComissoes.py` | Valida cálculos de comissões |
| `estoque.py` | Valida movimentação de estoque |
| `verificacoesExtras.py` | Verificações auxiliares |
| `leituraConfig.py` | Lê configuração de conexão com o BD |

### 5. Analisar Padrões de um Arquivo

Para cada arquivo `.robot` analisado, documentar:

```
Arquivo: <nome>
Módulo: <módulo do ERP>
Tipo: TestCase | Keyword
Settings:
  - Libraries: [lista]
  - Resources: [lista]
  - Variables: [lista]
Variáveis:
  - Imagens: [lista de ${VAR} = imagem.png]
  - DB Config: [se aplicável]
  - Sleeps: [se definidos localmente]
Keywords/TestCases:
  - <nome> — <breve descrição>
  - <nome> — <breve descrição>
Queries SQL usadas:
  - <query> — <propósito>
Dependências:
  - Depende de: [resources/libraries]
  - Usado por: [quem importa este resource]
```

### 6. Analisar o Executor (`Executar_Automacao.py`)

Script Python principal que:
- Executa Login como primeiro teste obrigatório
- Itera sobre todos os `.robot` em `TestsCases/`
- Executa cada test case individualmente
- Se um teste falha: fecha o ERP, re-executa login, continua
- Gera relatórios em `Relatorios/<data>/Resultados Finais/`
- Move artefatos do Sikuli para `sikuli_java/`
- Filtra output sensível (DB name, port, IP, machine name)

## Output Esperado

Ao usar esta skill, gere um relatório no formato acima com os componentes solicitados pelo usuário. Seja específico sobre queries SQL, dependências entre arquivos e padrões identificados.
