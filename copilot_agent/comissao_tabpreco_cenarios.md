# Cenários de Comissão — Linha Tabela de Preço, Tabela de Preço Geral e Tabela de Preço Escalonada

## Visão Geral

Este documento descreve os **12 cenários de teste** (Testes 88–99) que validam 3 novos tipos de comissionamento:

1. **Comissão por Linha — Tabela de Preço** (Testes 88–91)
2. **Comissão por Tabela de Preço — Geral** (Testes 92–95)
3. **Comissão por Tabela de Preço — Escalonada** (Testes 96–99)

> ⚠️ Por enquanto, todos os cenários validam **apenas comissão de produto** (sem serviço).

---

## BLOCO 1 — Comissão por Linha: Tabela de Preço (Testes 88–91)

### Contexto

- Comissão por linha com `comissaoporlinha.Tipo = 'DT'` (Tabela de Preço)
- Tabela `comissaoporlinha_tabpreco` com campos `{ID, IDLinhaComissao, idTabela, Aliquota}`
- Funciona de forma análoga à Diferenciada por Vendedor, porém vinculada à **tabela de preço** utilizada na venda/OS
- O produto deve ter vínculo com a comissão por linha (`produtos.CodigoComissao`)
- O vendedor deve estar cadastrado para comissão por linha
- **Não** depende do parâmetro `PermiteVariasTabelas`

### Tabelas Envolvidas

| Tabela | Alias | Descrição |
|---|---|---|
| `comissaoporlinha` | cl | Linha de comissão vinculada ao produto (`Tipo = 'DT'`) |
| `comissaoporlinha_tabpreco` | cpt | Alíquota por tabela de preço vinculada à linha de comissão |
| `produtos` | p | `CodigoComissao` → vínculo com `comissaoporlinha` |
| `vendasprodutos` | vp | Dados do produto na venda (valor unitário, etc.) |

### Regras

- Se `cpt.Aliquota > 0` → gera comissão: `ValorComissao = ValorUnitario × (cpt.Aliquota / 100)`
- Se `cpt.Aliquota = 0` → **NÃO** gera comissão

### Identificadores de Cenário

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PROD__TAB_PRECO__COM_ALIQ` | `cpt.Aliquota > 0` | ✅ Sim |
| `PROD__TAB_PRECO__SEM_ALIQ` | `cpt.Aliquota = 0` | ❌ Não |

### Matriz de Testes

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |
|---|---|---|---|---|
| **88** | `PROD__TAB_PRECO__COM_ALIQ` | Venda de Balcão | ✅ Sim | `cpt.Aliquota` (> 0) |
| **89** | `PROD__TAB_PRECO__SEM_ALIQ` | Venda de Balcão | ❌ Não | `cpt.Aliquota` (= 0) |
| **90** | `PROD__TAB_PRECO__COM_ALIQ` | OS somente com Produto | ✅ Sim | `cpt.Aliquota` (> 0) |
| **91** | `PROD__TAB_PRECO__SEM_ALIQ` | OS somente com Produto | ❌ Não | `cpt.Aliquota` (= 0) |

### Fórmula de Cálculo

```
ValorComissao = ValorUnitario × (cpt.Aliquota / 100)
```

---

## BLOCO 2 — Comissão por Tabela de Preço: Geral (Testes 92–95)

### Contexto

- No cadastro da tabela de preço, tipo de controle = **Geral**, com um campo de percentual de comissão
- Funciona quando:
  - Parâmetro `configempresa.PermiteVariasTabelas = 1` (habilitado)
  - Vendedor cadastrado para comissão por linha
  - Produto **SEM** vínculo com comissão por linha (`produtos.CodigoComissao IS NULL` ou = 0)
  - Tabela de preço utilizada na venda/OS possui percentual de comissão definido

### Tabelas Envolvidas

| Tabela | Alias | Descrição |
|---|---|---|
| `tabelapreco` | tp | Cadastro da tabela de preço com campo de % comissão |
| `configempresa` | ce | Parâmetro `PermiteVariasTabelas` |
| `produtos` | p | Produto sem `CodigoComissao` (sem vínculo com comissão por linha) |
| `vendasprodutos` | vp | Dados do produto na venda |

### Regras

- Se `tp.PercentualComissao > 0` → gera comissão: `ValorComissao = ValorUnitario × (tp.PercentualComissao / 100)`
- Se `tp.PercentualComissao = 0` → **NÃO** gera comissão

### Pré-condições

| Parâmetro | Valor | Descrição |
|---|---|---|
| `PERMITE_VARIAS_TABELAS` | 1 | Habilita exibição de várias tabelas na venda |

### Identificadores de Cenário

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PROD__TAB_PRECO_GERAL__COM_PERC` | `tp.PercentualComissao > 0` | ✅ Sim |
| `PROD__TAB_PRECO_GERAL__SEM_PERC` | `tp.PercentualComissao = 0` | ❌ Não |

### Matriz de Testes

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |
|---|---|---|---|---|
| **92** | `PROD__TAB_PRECO_GERAL__COM_PERC` | Venda de Balcão | ✅ Sim | `tp.PercentualComissao` (> 0) |
| **93** | `PROD__TAB_PRECO_GERAL__SEM_PERC` | Venda de Balcão | ❌ Não | `tp.PercentualComissao` (= 0) |
| **94** | `PROD__TAB_PRECO_GERAL__COM_PERC` | OS somente com Produto | ✅ Sim | `tp.PercentualComissao` (> 0) |
| **95** | `PROD__TAB_PRECO_GERAL__SEM_PERC` | OS somente com Produto | ❌ Não | `tp.PercentualComissao` (= 0) |

### Fórmula de Cálculo

```
ValorComissao = ValorUnitario × (tp.PercentualComissao / 100)
```

---

## BLOCO 3 — Comissão por Tabela de Preço: Escalonada (Testes 96–99)

### Contexto

- No cadastro da tabela de preço, tipo de controle = **Escalonada**, com faixas de desconto × alíquota
- Funciona quando:
  - Vendedor com `ComissaoDiferenciadapor = 'TPE'` (Tabela de Preço Escalonada)
  - Tabela de preço utilizada na venda/OS possui tipo Escalonada com faixas cadastradas
  - A faixa de desconto 0 é **obrigatória** (sempre há uma alíquota para quando não há desconto)
- O parâmetro `PermiteVariasTabelas` pode estar habilitado ou desabilitado

### Tabelas Envolvidas

| Tabela | Alias | Descrição |
|---|---|---|
| `tabelapreco` | tp | Cadastro da tabela de preço com tipo Escalonada |
| `tabelapreco_escalonada` | tpe | Faixas de desconto × alíquota (ex: Ate=0 → Comissao=8%) |
| `clientes` | c | Vendedor com `ComissaoDiferenciadapor = 'TPE'` |
| `vendasprodutos` | vp | Dados do produto na venda (valor unitário, desconto) |

### Regras

- Consulta-se o desconto aplicado ao produto na venda/OS
- Localiza-se a faixa na tabela `tabelapreco_escalonada` onde `tpe.Ate >= desconto` (ORDER BY tpe.Ate ASC LIMIT 1)
- A alíquota `tpe.Comissao` dessa faixa é aplicada sobre o valor unitário do produto
- Como a faixa de desconto 0 é obrigatória, **sempre** há uma faixa aplicável

### Identificadores de Cenário

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | Produto sem desconto → aplica faixa de desconto 0 | ✅ Sim |
| `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Produto com desconto aleatório → aplica faixa correspondente | ✅ Sim |

### Matriz de Testes

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |
|---|---|---|---|---|
| **96** | `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | Venda de Balcão | ✅ Sim | `tpe.Comissao` (faixa de desconto 0) |
| **97** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Venda de Balcão | ✅ Sim | `tpe.Comissao` (faixa correspondente ao desconto) |
| **98** | `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | OS somente com Produto | ✅ Sim | `tpe.Comissao` (faixa de desconto 0) |
| **99** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | OS somente com Produto | ✅ Sim | `tpe.Comissao` (faixa correspondente ao desconto) |

### Fórmula de Cálculo

```
ValorComissao = ValorUnitario × (tpe.Comissao / 100) × Quantidade
```

---

## Resumo Geral

| Bloco | Tipo | Testes | Operações | Qtd |
|---|---|---|---|---|
| **1** | Linha — Tabela de Preço | 88–91 | Venda + OS só produto | 4 |
| **2** | Tabela de Preço — Geral | 92–95 | Venda + OS só produto | 4 |
| **3** | Tabela de Preço — Escalonada | 96–99 | Venda + OS só produto | 4 |
| | | | **Total** | **12** |

---

## Fluxo de Cada Teste

```
[Setup]
  → Set ${Cenario_Comissao_Linha} = cenário do produto
  → (Bloco 2) Set PARAMS_PRE_CONDICOES com PERMITE_VARIAS_TABELAS 1
  → (Opcional) Set ${Cenario_Sem_Comissao_Produto} = ${True}
  → Montador cria Venda ou OS com produto

[Passos]
  1. Dado que acesso a tela de comissões
  2. Quando insiro o vendedor comissionado
  3. E seleciono a comissão de produtos
  4. E baixo a comissao recém recebida     ← pula se Sem_Comissao_Produto
  5. E saio da tela(Comissoes)
```
