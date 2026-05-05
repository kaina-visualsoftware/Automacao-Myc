# Cenários de Comissão — Linha Tabela de Preço, Tabela de Preço Geral e Tabela de Preço Escalonada# Cenários de Comissão — Linha Tabela de Preço, Tabela de Preço Geral e Tabela de Preço Escalonada



## Visão Geral## Visão Geral



Este documento descreve os **8 cenários de teste** (Testes 88–95) que validam 3 tipos de comissionamento por tabela de preço:Este documento descreve os **8 cenários de teste** (Testes 88–95) que validam 3 tipos de comissionamento por tabela de preço:



1. **Comissão por Linha — Tabela de Preço** (Testes 88–91)1. **Comissão por Linha — Tabela de Preço** (Testes 88–91)

2. **Comissão por Tabela de Preço — Geral** (Testes 92–93)2. **Comissão por Tabela de Preço — Geral** (Testes 92–93)

3. **Comissão por Tabela de Preço — Escalonada** (Testes 94–95)3. **Comissão por Tabela de Preço — Escalonada** (Testes 94–95)



> ⚠️ Todos os cenários validam **apenas comissão de produto** (sem serviço).> ⚠️ Por enquanto, todos os cenários validam **apenas comissão de produto** (sem serviço).



------



## BLOCO 1 — Comissão por Linha: Tabela de Preço (Testes 88–91)## BLOCO 1 — Comissão por Linha: Tabela de Preço (Testes 88–91)



### Contexto### Contexto



- Comissão por linha com `comissaoporlinha.Tipo = 'DT'` (Tabela de Preço)- Comissão por linha com `comissaoporlinha.Tipo = 'DT'` (Tabela de Preço)

- Tabela `comissaoporlinha_tabpreco` com campos `{ID, IDLinhaComissao, idTabela, Aliquota}`- Tabela `comissaoporlinha_tabpreco` com campos `{ID, IDLinhaComissao, idTabela, Aliquota}`

- Funciona de forma análoga à Diferenciada por Vendedor, porém vinculada à **tabela de preço** utilizada na venda/OS- Funciona de forma análoga à Diferenciada por Vendedor, porém vinculada à **tabela de preço** utilizada na venda/OS

- O produto deve ter vínculo com a comissão por linha (`produtos.CodigoComissao`)- O produto deve ter vínculo com a comissão por linha (`produtos.CodigoComissao`)

- O vendedor deve estar cadastrado para comissão por linha (`ComissaoDiferenciadapor = 'L'`)- O vendedor deve estar cadastrado para comissão por linha

- **Não** depende do parâmetro `PermiteVariasTabelas`- **Não** depende do parâmetro `PermiteVariasTabelas`



### Tabelas Envolvidas### Tabelas Envolvidas



| Tabela | Alias | Descrição || Tabela | Alias | Descrição |

|---|---|---||---|---|---|

| `comissaoporlinha` | cl | Linha de comissão vinculada ao produto (`Tipo = 'DT'`) || `comissaoporlinha` | cl | Linha de comissão vinculada ao produto (`Tipo = 'DT'`) |

| `comissaoporlinha_tabpreco` | cpt | Alíquota por tabela de preço vinculada à linha de comissão || `comissaoporlinha_tabpreco` | cpt | Alíquota por tabela de preço vinculada à linha de comissão |

| `produtos` | p | `CodigoComissao` → vínculo com `comissaoporlinha` || `produtos` | p | `CodigoComissao` → vínculo com `comissaoporlinha` |

| `vendasprodutos` | vp | Dados do produto na venda (valor unitário, etc.) || `vendasprodutos` | vp | Dados do produto na venda (valor unitário, etc.) |



### Regras### Regras



- Se `cpt.Aliquota > 0` → gera comissão: `ValorComissao = ValorUnitario × (cpt.Aliquota / 100)`- Se `cpt.Aliquota > 0` → gera comissão: `ValorComissao = ValorUnitario × (cpt.Aliquota / 100)`

- Se `cpt.Aliquota = 0` → **NÃO** gera comissão- Se `cpt.Aliquota = 0` → **NÃO** gera comissão



### Identificadores de Cenário### Identificadores de Cenário



| ID do Cenário | Condição | Gera Comissão? || ID do Cenário | Condição | Gera Comissão? |

|---|---|---||---|---|---|

| `PROD__TAB_PRECO__COM_ALIQ` | `cpt.Aliquota > 0` | ✅ Sim || `PROD__TAB_PRECO__COM_ALIQ` | `cpt.Aliquota > 0` | ✅ Sim |

| `PROD__TAB_PRECO__SEM_ALIQ` | `cpt.Aliquota = 0` | ❌ Não || `PROD__TAB_PRECO__SEM_ALIQ` | `cpt.Aliquota = 0` | ❌ Não |



### Matriz de Testes### Matriz de Testes



| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada || Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |

|---|---|---|---|---||---|---|---|---|---|

| **88** | `PROD__TAB_PRECO__COM_ALIQ` | Venda de Balcão | ✅ Sim | `cpt.Aliquota` (> 0) || **88** | `PROD__TAB_PRECO__COM_ALIQ` | Venda de Balcão | ✅ Sim | `cpt.Aliquota` (> 0) |

| **89** | `PROD__TAB_PRECO__SEM_ALIQ` | Venda de Balcão | ❌ Não | `cpt.Aliquota` (= 0) || **89** | `PROD__TAB_PRECO__SEM_ALIQ` | Venda de Balcão | ❌ Não | `cpt.Aliquota` (= 0) |

| **90** | `PROD__TAB_PRECO__COM_ALIQ` | OS somente com Produto | ✅ Sim | `cpt.Aliquota` (> 0) || **90** | `PROD__TAB_PRECO__COM_ALIQ` | OS somente com Produto | ✅ Sim | `cpt.Aliquota` (> 0) |

| **91** | `PROD__TAB_PRECO__SEM_ALIQ` | OS somente com Produto | ❌ Não | `cpt.Aliquota` (= 0) || **91** | `PROD__TAB_PRECO__SEM_ALIQ` | OS somente com Produto | ❌ Não | `cpt.Aliquota` (= 0) |



### Fórmula de Cálculo### Fórmula de Cálculo



``````

ValorComissao = ValorUnitario × (cpt.Aliquota / 100)ValorComissao = ValorUnitario × (cpt.Aliquota / 100)

``````



------



## BLOCO 2 — Comissão por Tabela de Preço: Geral (Testes 92–93)## BLOCO 2 — Comissão por Tabela de Preço: Geral (Testes 92–95)



### Contexto### Contexto



- Comissão calculada a partir do campo `tabelas.PComissao` (percentual de comissão da tabela de preço)- No cadastro da tabela de preço, tipo de controle = **Geral**, com um campo de percentual de comissão

- **Não** é comissão por linha — o produto **não** tem vínculo com `comissaoporlinha`- Funciona quando:

- Funciona quando:  - Parâmetro `configempresa.PermiteVariasTabelas = 1` (habilitado)

  - Parâmetro `configempresa.PermiteVariasTabelas = 1` (habilitado)  - Vendedor cadastrado para comissão por linha

  - Vendedor com `ComissaoDiferenciadapor = 'L'` (mesmo tipo dos vendedores por linha, mas a comissão vem da tabela)  - Produto **SEM** vínculo com comissão por linha (`produtos.CodigoComissao IS NULL` ou = 0)

  - Produto **SEM** vínculo com comissão por linha (`produtos.CodigoComissao IS NULL` ou = 0)  - Tabela de preço utilizada na venda/OS possui percentual de comissão definido

  - Tabela de preço do tipo `TP_Preco = 'G'` (Geral) com `PComissao` definido

- Aplica-se somente a **venda de balcão** (o parâmetro `PermiteVariasTabelas` não se aplica a OS)### Tabelas Envolvidas



### Tabelas Envolvidas| Tabela | Alias | Descrição |

|---|---|---|

| Tabela | Alias | Descrição || `tabelapreco` | tp | Cadastro da tabela de preço com campo de % comissão |

|---|---|---|| `configempresa` | ce | Parâmetro `PermiteVariasTabelas` |

| `tabelas` | t | Cadastro da tabela de preço (`TP_Preco = 'G'`, campo `PComissao`) || `produtos` | p | Produto sem `CodigoComissao` (sem vínculo com comissão por linha) |

| `configempresa` | ce | Parâmetro `PermiteVariasTabelas` || `vendasprodutos` | vp | Dados do produto na venda |

| `produtos` | p | Produto sem `CodigoComissao` (sem vínculo com comissão por linha) |

| `vendasprodutos` | vp | Dados do produto na venda |### Regras



### Regras- Se `tp.PercentualComissao > 0` → gera comissão: `ValorComissao = ValorUnitario × (tp.PercentualComissao / 100)`

- Se `tp.PercentualComissao = 0` → **NÃO** gera comissão

- Se `t.PComissao > 0` → gera comissão: `ValorComissao = ValorUnitario × (t.PComissao / 100)`

- Se `t.PComissao = 0` ou `NULL` → **NÃO** gera comissão### Pré-condições



### Pré-condições| Parâmetro | Valor | Descrição |

|---|---|---|

| Parâmetro | Valor | Descrição || `PERMITE_VARIAS_TABELAS` | 1 | Habilita exibição de várias tabelas na venda |

|---|---|---|

| `PERMITE_VARIAS_TABELAS` | 1 | Habilita seleção de tabela de preço na venda |### Identificadores de Cenário



### Identificadores de Cenário| ID do Cenário | Condição | Gera Comissão? |

|---|---|---|

| ID do Cenário | Condição | Gera Comissão? || `PROD__TAB_PRECO_GERAL__COM_PERC` | `tp.PercentualComissao > 0` | ✅ Sim |

|---|---|---|| `PROD__TAB_PRECO_GERAL__SEM_PERC` | `tp.PercentualComissao = 0` | ❌ Não |

| `PROD__TAB_PRECO_GERAL__COM_PERC` | `t.PComissao > 0` | ✅ Sim |

| `PROD__TAB_PRECO_GERAL__SEM_PERC` | `t.PComissao = 0` ou `NULL` | ❌ Não |### Matriz de Testes



### Matriz de Testes| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |

|---|---|---|---|---|

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada || **92** | `PROD__TAB_PRECO_GERAL__COM_PERC` | Venda de Balcão | ✅ Sim | `tp.PercentualComissao` (> 0) |

|---|---|---|---|---|| **93** | `PROD__TAB_PRECO_GERAL__SEM_PERC` | Venda de Balcão | ❌ Não | `tp.PercentualComissao` (= 0) |

| **92** | `PROD__TAB_PRECO_GERAL__COM_PERC` | Venda de Balcão | ✅ Sim | `t.PComissao` (> 0) || **94** | `PROD__TAB_PRECO_GERAL__COM_PERC` | OS somente com Produto | ✅ Sim | `tp.PercentualComissao` (> 0) |

| **93** | `PROD__TAB_PRECO_GERAL__SEM_PERC` | Venda de Balcão | ❌ Não | `t.PComissao` (= 0) || **95** | `PROD__TAB_PRECO_GERAL__SEM_PERC` | OS somente com Produto | ❌ Não | `tp.PercentualComissao` (= 0) |



### Fórmula de Cálculo### Fórmula de Cálculo



``````

ValorComissao = ValorUnitario × (t.PComissao / 100)ValorComissao = ValorUnitario × (tp.PercentualComissao / 100)

``````



------



## BLOCO 3 — Comissão por Tabela de Preço: Escalonada (Testes 94–95)## BLOCO 3 — Comissão por Tabela de Preço: Escalonada (Testes 96–99)



### Contexto### Contexto



- Comissão calculada a partir de faixas de desconto cadastradas na tabela `comissao_escalonadatab`- No cadastro da tabela de preço, tipo de controle = **Escalonada**, com faixas de desconto × alíquota

- Cada faixa define: até qual percentual de desconto (`Ate`) → qual alíquota de comissão (`Comissao`)- Funciona quando:

- Funciona quando:  - Vendedor com `ComissaoDiferenciadapor = 'TPE'` (Tabela de Preço Escalonada)

  - Vendedor com `ComissaoDiferenciadapor = 'TPE'` (Tabela de Preço Escalonada)  - Tabela de preço utilizada na venda/OS possui tipo Escalonada com faixas cadastradas

  - A tabela de preço utilizada na venda/OS possui faixas cadastradas em `comissao_escalonadatab`  - A faixa de desconto 0 é **obrigatória** (sempre há uma alíquota para quando não há desconto)

  - A faixa com `Ate = 0` é obrigatória (garante alíquota mesmo sem desconto)- O parâmetro `PermiteVariasTabelas` pode estar habilitado ou desabilitado



### Tabelas Envolvidas### Tabelas Envolvidas



| Tabela | Alias | Descrição || Tabela | Alias | Descrição |

|---|---|---||---|---|---|

| `comissao_escalonadatab` | cet | Faixas: `IDTabela`, `Ate` (% desconto limite), `Comissao` (% alíquota) || `tabelapreco` | tp | Cadastro da tabela de preço com tipo Escalonada |

| `tabelas` | t | Cadastro da tabela de preço vinculada às faixas || `tabelapreco_escalonada` | tpe | Faixas de desconto × alíquota (ex: Ate=0 → Comissao=8%) |

| `clientes` | c | Vendedor com `ComissaoDiferenciadapor = 'TPE'` || `clientes` | c | Vendedor com `ComissaoDiferenciadapor = 'TPE'` |

| `vendasprodutos` | vp | Dados do produto na venda (valor unitário, desconto aplicado) || `vendasprodutos` | vp | Dados do produto na venda (valor unitário, desconto) |



### Regras### Regras



- Lê o desconto aplicado ao produto na venda/OS (`vendasprodutos.Desconto`)- Consulta-se o desconto aplicado ao produto na venda/OS

- Localiza a faixa em `comissao_escalonadatab` onde `cet.Ate >= desconto` (ORDER BY `cet.Ate` ASC LIMIT 1)- Localiza-se a faixa na tabela `tabelapreco_escalonada` onde `tpe.Ate >= desconto` (ORDER BY tpe.Ate ASC LIMIT 1)

- Aplica `cet.Comissao` sobre o valor unitário do produto- A alíquota `tpe.Comissao` dessa faixa é aplicada sobre o valor unitário do produto

- Como a faixa `Ate = 0` é obrigatória, **sempre** há uma faixa aplicável- Como a faixa de desconto 0 é obrigatória, **sempre** há uma faixa aplicável



### Identificadores de Cenário### Identificadores de Cenário



| ID do Cenário | Condição | Gera Comissão? || ID do Cenário | Condição | Gera Comissão? |

|---|---|---||---|---|---|

| `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Produto com desconto aleatório → aplica faixa correspondente | ✅ Sim || `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | Produto sem desconto → aplica faixa de desconto 0 | ✅ Sim |

| `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Produto com desconto aleatório → aplica faixa correspondente | ✅ Sim |

### Matriz de Testes

### Matriz de Testes

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |

|---|---|---|---|---|| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |

| **94** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Venda de Balcão | ✅ Sim | `cet.Comissao` (faixa correspondente ao desconto) ||---|---|---|---|---|

| **95** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | OS somente com Produto | ✅ Sim | `cet.Comissao` (faixa correspondente ao desconto) || **96** | `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | Venda de Balcão | ✅ Sim | `tpe.Comissao` (faixa de desconto 0) |

| **97** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | Venda de Balcão | ✅ Sim | `tpe.Comissao` (faixa correspondente ao desconto) |

### Fórmula de Cálculo| **98** | `PROD__TAB_PRECO_ESCALONADA__SEM_DESC` | OS somente com Produto | ✅ Sim | `tpe.Comissao` (faixa de desconto 0) |

| **99** | `PROD__TAB_PRECO_ESCALONADA__COM_DESC` | OS somente com Produto | ✅ Sim | `tpe.Comissao` (faixa correspondente ao desconto) |

```

ValorComissao = ValorUnitario × (cet.Comissao / 100) × Quantidade### Fórmula de Cálculo

```

```

---ValorComissao = ValorUnitario × (tpe.Comissao / 100) × Quantidade

```

## Resumo Geral

---

| Bloco | Tipo | Testes | Operações | Qtd |

|---|---|---|---|---|## Resumo Geral

| **1** | Linha — Tabela de Preço | 88–91 | Venda + OS só produto | 4 |

| **2** | Tabela de Preço — Geral | 92–93 | Venda de Balcão | 2 || Bloco | Tipo | Testes | Operações | Qtd |

| **3** | Tabela de Preço — Escalonada | 94–95 | Venda + OS só produto | 2 ||---|---|---|---|---|

| | | | **Total** | **8** || **1** | Linha — Tabela de Preço | 88–91 | Venda + OS só produto | 4 |

| **2** | Tabela de Preço — Geral | 92–95 | Venda + OS só produto | 4 |

---| **3** | Tabela de Preço — Escalonada | 96–99 | Venda + OS só produto | 4 |

| | | | **Total** | **12** |

## Fluxo de Cada Teste

---

```

[Setup]## Fluxo de Cada Teste

  → Set ${Cenario_Comissao_Linha} = cenário do produto        (Bloco 1)

  → Set ${Cenario_Comissao_Tabela_Preco} = cenário do produto (Blocos 2 e 3)```

  → (Bloco 2) Set PARAMS_PRE_CONDICOES com PERMITE_VARIAS_TABELAS 1[Setup]

  → (Opcional) Set ${Cenario_Sem_Comissao_Produto} = ${True}  → Set ${Cenario_Comissao_Linha} = cenário do produto

  → Montador cria Venda ou OS com produto  → (Bloco 2) Set PARAMS_PRE_CONDICOES com PERMITE_VARIAS_TABELAS 1

  → (Opcional) Set ${Cenario_Sem_Comissao_Produto} = ${True}

[Passos]  → Montador cria Venda ou OS com produto

  1. Dado que acesso a tela de comissões

  2. Quando insiro o vendedor comissionado[Passos]

  3. E seleciono a comissão de produtos  1. Dado que acesso a tela de comissões

  4. E baixo a comissao recém recebida     ← pula se Cenario_Sem_Comissao_Produto  2. Quando insiro o vendedor comissionado

  5. E saio da tela(Comissoes)  3. E seleciono a comissão de produtos

```  4. E baixo a comissao recém recebida     ← pula se Sem_Comissao_Produto

  5. E saio da tela(Comissoes)
```
