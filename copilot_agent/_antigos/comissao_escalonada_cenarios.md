# Cenários de Comissão Escalonada — Tipo Padrão

## Contexto

Na comissão escalonada (vendedor com `ComissaoDiferenciadapor = 'D'`), há dois tipos: **Padrão** e **Tabela de Preço**.
Aqui tratamos apenas o tipo **Padrão**.

### Tabelas envolvidas

| Tabela | Alias | Descrição |
|---|---|---|
| `comissao_escalonadaprod` | ce | Faixas de desconto × alíquota de comissão para **produtos** |
| `clientes` | c | Campo `ComissaoPercentualServicos` (% Serviço) para **serviços** |

### Regras de cálculo — Produto

- A automação gera um desconto aleatório inteiro (0 a max `ce.Ate`) e o insere no campo de desconto do produto na venda/OS.
- Consulta-se o percentual de desconto aplicado ao produto na venda/OS (`vendasprodutos.Desconto`).
- Localiza-se a faixa na tabela `comissao_escalonadaprod` onde `ce.Ate >= desconto` (ORDER BY ce.Ate ASC LIMIT 1).
- A alíquota `ce.Comissao` dessa faixa é aplicada sobre o valor unitário do produto.
- Fórmula: `ValorComissao = ValorUnitario × (ce.Comissao / 100) × Quantidade`

### Regras de cálculo — Serviço

- Usa-se `clientes.ComissaoPercentualServicos` do vendedor (ou executor, conforme parâmetro).
- Se `ComissaoPercentualServicos == 0 ou NULL` → NÃO gera comissão de serviço.
- Se `ComissaoPercentualServicos > 0` → gera comissão: `ValorBase × (ComissaoPercentualServicos / 100)`
- `ValorBase = TotalServicos - (TotalServicos × (TotalTributos / 100))`

---

## Cenários

### Teste 86 — Venda de balcão (apenas produto) — Escalonada
- **Operação**: Venda de balcão com 1 produto normal
- **Validação**: Gera comissão do produto utilizando `ce.Comissao` (faixa escalonada baseada no desconto)
- **Setup**: `montadorDeCenarios.Dado que realizo uma venda completa, com produto normal`

---

### Teste 87 — OS com produto e serviço, parâmetro desabilitado, vendedor COM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: desabilitado (0)
- **Vendedor_OS**: `ComissaoPercentualServicos > 0`
- **Validação produto**: Gera comissão do produto utilizando `ce.Comissao`
- **Validação serviço**: Gera comissão do serviço utilizando `clientes.ComissaoPercentualServicos`

### Teste 88 — OS com produto e serviço, parâmetro desabilitado, vendedor SEM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: desabilitado (0)
- **Vendedor_OS**: `ComissaoPercentualServicos == 0 ou NULL`
- **Validação produto**: Gera comissão do produto utilizando `ce.Comissao`
- **Validação serviço**: NÃO gera comissão do serviço

---

### Teste 89 — OS com produto e serviço, parâmetro habilitado, mesmo vendedor COM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: habilitado (1)
- **Parâmetro** `SELECIONA_FUNCIONARIO_OS`: desabilitado (0) → mesmo vendedor
- **Vendedor_OS**: `ComissaoPercentualServicos > 0`
- **Validação produto**: Gera comissão do produto utilizando `ce.Comissao`
- **Validação serviço**: Gera comissão do serviço utilizando `clientes.ComissaoPercentualServicos`

### Teste 90 — OS com produto e serviço, parâmetro habilitado, mesmo vendedor SEM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: habilitado (1)
- **Parâmetro** `SELECIONA_FUNCIONARIO_OS`: desabilitado (0) → mesmo vendedor
- **Vendedor_OS**: `ComissaoPercentualServicos == 0 ou NULL`
- **Validação produto**: Gera comissão do produto utilizando `ce.Comissao`
- **Validação serviço**: NÃO gera comissão do serviço

---

### Teste 91 — OS com produto e serviço, parâmetro habilitado, diferentes vendedores, executor COM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: habilitado (1)
- **Parâmetro** `SELECIONA_FUNCIONARIO_OS`: habilitado (1) → vendedores diferentes
- **Executor**: `ComissaoPercentualServicos > 0`
- **Validação produto**: Gera comissão do produto para Vendedor_OS utilizando `ce.Comissao`
- **Validação serviço**: Gera comissão do serviço para Executor utilizando `clientes.ComissaoPercentualServicos` do executor

### Teste 92 — OS com produto e serviço, parâmetro habilitado, diferentes vendedores, executor SEM ComissaoPercentualServicos — Escalonada
- **Operação**: OS com 1 produto + 1 serviço
- **Parâmetro** `OS_COMISSAO_VENDEDOR_EXECUTOR`: habilitado (1)
- **Parâmetro** `SELECIONA_FUNCIONARIO_OS`: habilitado (1) → vendedores diferentes
- **Executor**: `ComissaoPercentualServicos == 0 ou NULL`
- **Validação produto**: Gera comissão do produto para Vendedor_OS utilizando `ce.Comissao`
- **Validação serviço**: NÃO gera comissão para o executor

---

## Resumo dos Testes

| # | Cenário | Produto | Serviço | Parâmetro |
|---|---------|---------|---------|-----------|
| 86 | Venda balcão | ce.Comissao | — | — |
| 87 | OS param desab, vend COM %serv | ce.Comissao | ComissaoPercentualServicos | 0 |
| 88 | OS param desab, vend SEM %serv | ce.Comissao | NÃO gera | 0 |
| 89 | OS param hab, mesmo vend COM %serv | ce.Comissao | ComissaoPercentualServicos | 1 |
| 90 | OS param hab, mesmo vend SEM %serv | ce.Comissao | NÃO gera | 1 |
| 91 | OS param hab, dif vend, exec COM %serv | ce.Comissao (vend_os) | ComissaoPercentualServicos (exec) | 1 |
| 92 | OS param hab, dif vend, exec SEM %serv | ce.Comissao (vend_os) | NÃO gera (exec) | 1 |
