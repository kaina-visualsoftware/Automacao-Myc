---
name: Análise de Código
description: Analisa a estrutura e código do projeto mycommerce-automacao, gerando inventários e relatórios de cobertura
---

# Skill: Análise de Código

## Nome
`analise-codigo`

## Quando Usar
- Quando o usuário pedir para **analisar** ou **entender** o código existente
- Quando for necessário **inventariar** recursos existentes antes de criar algo novo
- Para gerar **relatórios de cobertura** de testes
- Para **mapear dependências** entre arquivos

## Entrada
- Nome do arquivo, módulo ou componente a ser analisado
- Ou solicitação de análise geral (sem parâmetro = projeto inteiro)

## Saída
- Relatório estruturado contendo: módulos cobertos, keywords mapeadas, queries SQL, dependências e recomendações

## Regras
1. **Sempre** percorrer fisicamente os diretórios antes de responder — nunca assumir que a lista de módulos está atualizada
2. **Sempre** documentar dependências entre arquivos (Resource, Library, Variables)
3. **Sempre** listar queries SQL encontradas com seu propósito
4. Para análise de arquivo individual, usar o template de documentação abaixo
5. Para análise geral, usar o inventário de módulos abaixo

---

## Template de Análise Individual

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
Queries SQL usadas:
  - <query> — <propósito>
Dependências:
  - Depende de: [resources/libraries]
  - Usado por: [quem importa este resource]
```

---

## Inventário de Módulos do ERP

| Módulo | Keywords | Test Cases |
|---|---|---|
| **Comercial/Condicional** | `KeyCondicional1.robot` | `Teste_Condicional1.robot` |
| **Comercial/Vendas** | `keyVendas1.robot` | Testes de vendas |
| **Comercial/Devolução** | `KeyDevolucaoVenda1.robot` | Testes de devolução |
| **Comercial/Doação** | `KeyDocao1.robot` | Testes de doação |
| **Comercial/Orçamento** | `KeyOrcamento1.robot` | Testes de orçamento |
| **Comercial/OS** | `KeyOrdemDeSevico1.robot` | Testes de OS |
| **Financeiro/Caixa** | `keyCaixa1.robot` | Testes de caixa |
| **Financeiro/Contas a Pagar** | `keyContasPagar1.robot` | Testes de contas |
| **Login** | `KeyLoginSistema1.robot` | `Teste_LoginSistema1.robot` |
| **Descontos** | Keywords | Test Cases |
| **Emissão** | Keywords | Test Cases |
| **Faturamento** | Keywords | Test Cases |
| **MyMonitorFaturamento** | Keywords | Test Cases |
| **Pré-Venda/Pedidos** | `KeyPedidos1.robot` | Testes de pedidos |

---

## Inventário de Componentes Compartilhados

### utils/utils.robot (1600+ linhas)
Keywords reutilizáveis:
- `Adicionar Vendedor e Cliente(${TELA})` — Adiciona vendedor e cliente em qualquer tela
- `Seleciona vendedor` — Query SQL para selecionar vendedor aleatório
- `E saio da tela(${TELA})` — Fecha tela atual (parametrizado)
- `Inserir Produto normal - Necessita de estoque` — Insere produto com estoque
- `Inserir Produto normal - Permite sem estoque` — Insere sem verificar estoque
- Variáveis globais de imagens (telas, avisos, modais, inputs, labels, botões)

### utils/montadorDeCenarios.robot (500+ linhas)
Cenários compostos:
- `Dado que realizo uma venda completa, com produto normal`
- `Dado que realizo um pedido, com produto normal`
- `Dado que realizo uma devolução completa da venda`

### utils/validacaoAviso.robot
Keywords para tratar avisos/popups do ERP durante a execução.

### utils/parametros_pre_condicoes.robot
Preparação do ambiente (validação de parâmetros do banco antes dos testes).

---

## Inventário de Bibliotecas Python (`libs/`)

| Arquivo | Responsabilidade |
|---|---|
| `validaParametros.py` | Valida configurações do ERP (config, empresa, formas parcelamento) |
| `validaComissoes.py` | Valida cálculos de comissões |
| `estoque.py` | Valida movimentação de estoque |
| `verificacoesExtras.py` | Verificações auxiliares |
| `leituraConfig.py` | Lê configuração de conexão com o BD |

---

## Executor (`Executar_Automacao.py`)

Script Python principal que:
- Executa Login como primeiro teste obrigatório
- Itera sobre todos os `.robot` em `TestsCases/`
- Executa cada test case individualmente
- Se um teste falha: fecha o ERP, re-executa login, continua
- Gera relatórios em `Relatorios/<data>/Resultados Finais/`
- Move artefatos do Sikuli para `sikuli_java/`
- Filtra output sensível (DB name, port, IP, machine name)
