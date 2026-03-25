# Documentação de Cenários — Comissão por Linha em Serviço

## Referências de Tabelas e Campos

| Alias usado neste doc | Tabela.Campo real |
|---|---|
| **Aliquota** | `comissaoporlinha_vendedor.Aliquota` (alíquota de venda) |
| **AliquotaExecucao** | `comissaoporlinha_vendedor.AliquotaExecucao` (alíquota de execução do serviço) |
| **Aliquota Geral Mista** | `comissaoporlinha.Aliquota` |

- **Parâmetro**: *"Gerar comissão para o vendedor do lançamento da OS e para o executor do serviço"*
- **Tabela**: `comissaoporlinha_vendedor` (alias: **cpv**)

> **IMPORTANTE**: O comportamento do ERP na tabela `comissoesservico` **NÃO é uniforme**:
> - Na **maioria** dos cenários, o ERP gera um registro para cada funcionário envolvido, mesmo quando a alíquota é 0 (registro com `Aliquota=0` e `ValorComissao=0`).
> - **EXCEÇÃO**: Quando **parâmetro desabilitado + vendedores diferentes** (Diferenciada e Mista), o **vendedor da OS NÃO gera nenhum registro** em `comissoesservico` — simplesmente não existe linha para ele. Isso vale tanto quando o executor tem `Aliquota > 0` (só executor recebe) quanto quando o executor tem `Aliquota = 0` (ninguém recebe). O **executor** sempre gera registro (com valor 0 se não recebe).
> - A **grid** da tela de comissões só exibe registros com valor > 0.
>
> **CAMPO `ComissaoVendedor`**: Quando o parâmetro está **habilitado**, o ERP gera **2 registros separados** em `comissoesservico` para distinguir o papel:
> - **Vendedor**: `ComissaoVendedor = 1` → ValorComissao calculado com `cpv.Aliquota` (ou 0 se Aliquota = 0)
> - **Executor**: `ComissaoVendedor IS NULL` → ValorComissao calculado com `cpv.AliquotaExecucao` (ou 0 se AliquotaExecucao = 0)
> - Isso acontece inclusive quando **o mesmo funcionário** é vendedor e executor (mesmo CodigoFuncionario, 2 linhas).
> - As queries de validação devem **sempre** filtrar por `ComissaoVendedor = 1` ou `ComissaoVendedor IS NULL` nos cenários com param habilitado.

---

## DIFERENCIADA POR VENDEDOR

### Parâmetro DESABILITADO — Mesmo vendedor (Vendedor_OS = Executor)

| Condição | Resultado |
|---|---|
| Vendedor_OS com `Aliquota == 0` | **Não gera comissão** (registro com valor 0) |
| Vendedor_OS com `Aliquota > 0` | **Gera comissão** utilizando `Aliquota` |

### Parâmetro DESABILITADO — Vendedores diferentes (Vendedor_OS ≠ Executor)

| Condição Executor | Condição Vendedor_OS | Resultado |
|---|---|---|
| `Aliquota > 0` | `Aliquota == 0` | **SÓ Executor recebe** (com `Aliquota` do executor) |
| `Aliquota == 0` | `Aliquota > 0` | **NINGUÉM recebe** (nenhum dos dois) |
| `Aliquota == 0` | `Aliquota == 0` | **NINGUÉM recebe** |

> **Atenção**: Na diferenciada com param desabilitado e vendedores diferentes, quem determina se haverá comissão é **o executor**. Se o executor tem `Aliquota > 0`, **só ele recebe**. Se o executor tem `Aliquota == 0`, **ninguém recebe** — independentemente da alíquota do vendedor da OS.

### Parâmetro HABILITADO — Mesmo vendedor (Vendedor_OS = Executor)

| Condição | Resultado |
|---|---|
| `AliquotaExecucao > 0` (qualquer `Aliquota`) | **Gera comissão** com `Aliquota + AliquotaExecucao` |
| `AliquotaExecucao == 0`, `Aliquota > 0` | **Gera comissão** com `Aliquota + 0` = `Aliquota` |
| `AliquotaExecucao == 0` e `Aliquota == 0` | **Não gera comissão** |

### Parâmetro HABILITADO — Vendedores diferentes (Vendedor_OS ≠ Executor)

| Condição Vendedor_OS | Condição Executor | Resultado |
|---|---|---|
| `Aliquota == 0` | `AliquotaExecucao == 0` | **NINGUÉM recebe** |
| `Aliquota == 0` | `AliquotaExecucao > 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `AliquotaExecucao` |
| `Aliquota > 0` | `AliquotaExecucao == 0` | Vendedor_OS: **recebe** com `Aliquota` · Executor: **não recebe** |
| `Aliquota > 0` | `AliquotaExecucao > 0` | Vendedor_OS: **recebe** com `Aliquota` · Executor: **recebe** com `AliquotaExecucao` |

---

## MISTA

### Parâmetro DESABILITADO — Mesmo vendedor (Vendedor_OS = Executor)

| Condição | Resultado |
|---|---|
| Vendedor_OS com `Aliquota > 0` (na cpv) | **Gera comissão** utilizando `cpv.Aliquota` |
| Vendedor_OS com `Aliquota == 0` (na cpv) | **Registro com valor 0** em `comissoesservico` (Aliquota=0, ValorComissao=0). **NÃO faz fallback** para Alíquota Geral. **NÃO aparece no grid**. |
| Vendedor_OS **não consta** na tabela cpv | **Gera comissão** utilizando `Aliquota Geral Mista` |

> **⚠️ Regra Mista — cpv vs Geral**: Na linha mista, quando o vendedor **está** na tabela `comissaoporlinha_vendedor` vinculado a uma linha mista, usa-se a `cpv.Aliquota` desse vendedor, **independente** de ser 0 ou maior. Se `cpv.Aliquota = 0`, a comissão é 0 — **NÃO há fallback** para a Alíquota Geral Mista. O fallback para Alíquota Geral **só** acontece quando o vendedor **NÃO está** na tabela cpv.

### Parâmetro DESABILITADO — Vendedores diferentes (Vendedor_OS ≠ Executor)

| Condição Executor | Condição Vendedor_OS | Resultado |
|---|---|---|
| `Aliquota > 0` | `Aliquota > 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota` |
| `Aliquota > 0` | `Aliquota == 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota` |
| `Aliquota > 0` | Sem cpv | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota` |
| `Aliquota == 0` | `Aliquota > 0` | **NINGUÉM recebe** |
| `Aliquota == 0` | `Aliquota == 0` | **NINGUÉM recebe** |
| `Aliquota == 0` | Sem cpv | **NINGUÉM recebe** |
| Sem cpv | `Aliquota > 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota Geral Mista` |
| Sem cpv | `Aliquota == 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota Geral Mista` |
| Sem cpv | Sem cpv | Vendedor_OS: **não recebe** · Executor: **recebe** com `Aliquota Geral Mista` |

> **Atenção Mista param desab vendedores diferentes**: A lógica segue o mesmo padrão da diferenciada — quem determina é o executor. Se executor tem `Aliquota > 0`, **só ele recebe** (com sua `Aliquota`). Se executor tem `Aliquota == 0`, **ninguém recebe**. Se executor **não consta** na cpv, usa `Aliquota Geral Mista` para o executor.

### Parâmetro HABILITADO — Mesmo vendedor (Vendedor_OS = Executor)

| Condição | Resultado |
|---|---|
| `AliquotaExecucao > 0` (qualquer `Aliquota`) | **Gera comissão** com `Aliquota + AliquotaExecucao` |
| `AliquotaExecucao == 0`, `Aliquota > 0` | **Gera comissão** com `Aliquota + 0` = `Aliquota` |
| `AliquotaExecucao == 0` e `Aliquota == 0` | **Não gera comissão** |
| **Não consta** na tabela cpv | **Gera comissão** com o dobro da `Aliquota Geral Mista` (= 2 × `Aliquota Geral Mista`) |

### Parâmetro HABILITADO — Vendedores diferentes (Vendedor_OS ≠ Executor)

| Condição Vendedor_OS | Condição Executor | Resultado |
|---|---|---|
| `Aliquota == 0` | `AliquotaExecucao == 0` | **NINGUÉM recebe** |
| `Aliquota == 0` | `AliquotaExecucao > 0` | Vendedor_OS: **não recebe** · Executor: **recebe** com `AliquotaExecucao` |
| `Aliquota > 0` | `AliquotaExecucao == 0` | Vendedor_OS: **recebe** com `Aliquota` · Executor: **não recebe** |
| `Aliquota > 0` | `AliquotaExecucao > 0` | Vendedor_OS: **recebe** com `Aliquota` · Executor: **recebe** com `AliquotaExecucao` |
| **Sem cpv** | (qualquer) | Vendedor_OS: **recebe** com `Aliquota Geral Mista` · Executor: **recebe** com `Aliquota Geral Mista` |

---

## Mapeamento Cenário → Teste

| Cenário | Tipo | Param | Vendedores | Teste |
|---|---|---|---|---|
| `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ` | Diferenciada | Desab | Mesmo | Teste 23 |
| `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ` | Diferenciada | Desab | Mesmo | Teste 24 |
| `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ` | Diferenciada | Desab | Diferentes | Teste 25 |
| `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ` | Diferenciada | Desab | Diferentes | Teste 26 |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC` | Diferenciada | Hab | Mesmo | Teste 27 |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC` | Diferenciada | Hab | Mesmo | Teste 28 |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ` | Diferenciada | Hab | Mesmo | Teste 29 |
| `PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ` | Diferenciada | Hab | Diferentes | Teste 30 |
| `PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_ALIQ` | Diferenciada | Hab | Diferentes | Teste 31 |
| `PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_COM_ALIQ` | Diferenciada | Hab | Diferentes | Teste 32 |
| `PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_SEM_ALIQ` | Diferenciada | Hab | Diferentes | Teste 33 |
| `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ` | Mista | Desab | Mesmo | Teste 34 |
| `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO` | Mista | Desab | Mesmo | Teste 35 |
| `PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | Mista | Desab | Mesmo | Teste 36 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ` | Mista | Desab | Diferentes | Teste 37 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO` | Mista | Desab | Diferentes | Teste 38 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV` | Mista | Desab | Diferentes | Teste 39 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ` | Mista | Desab | Diferentes | Teste 40 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO` | Mista | Desab | Diferentes | Teste 41 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV` | Mista | Desab | Diferentes | Teste 42 |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO` | Mista | Hab | Mesmo | Teste 43 |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC` | Mista | Hab | Mesmo | Teste 44 |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ` | Mista | Hab | Mesmo | Teste 45 |
| `PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | Mista | Hab | Mesmo | Teste 46 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ` | Mista | Hab | Diferentes | Teste 47 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO` | Mista | Hab | Diferentes | Teste 48 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV` | Mista | Hab | Diferentes | Teste 49 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ` | Mista | Hab | Diferentes | Teste 50 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO` | Mista | Hab | Diferentes | Teste 55 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV` | Mista | Hab | Diferentes | Teste 51 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ` | Mista | Desab | Diferentes | Teste 52 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO` | Mista | Desab | Diferentes | Teste 53 |
| `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV` | Mista | Desab | Diferentes | Teste 54 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO` | Mista | Hab | Diferentes | Teste 56 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ` | Mista | Hab | Diferentes | Teste 57 |
| `PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV` | Mista | Hab | Diferentes | Teste 58 |

---

## Observações Importantes

1. **Diferenciada param desab, vendedores diferentes**: Quem "manda" é o **executor**. Se executor `Aliquota > 0` → **só executor** recebe. Se executor `Aliquota == 0` → **ninguém** recebe.
2. **Mista param desab, vendedores diferentes**: Mesma lógica — executor determina. Se executor `Aliquota > 0` → **só executor**. Se executor `Aliquota == 0` → **ninguém**. Se executor **sem cpv** → executor recebe com `Aliquota Geral Mista`.
3. **Param habilitado (ambos tipos), vendedores diferentes**: Cada um é avaliado **independentemente**. Executor usa `AliquotaExecucao`, vendedor_OS usa `Aliquota`.
4. **Grid da tela de comissões**: Só mostra registros com valor > 0. Cenários sem comissão não aparecem na grid mas o registro **pode** existir no BD com valor 0 (veja observação 9).
5. **Cenário `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ` (Teste 25)**: O nome refere-se ao **executor** ter `Aliquota > 0`. O vendedor da OS **deve** ter `Aliquota == 0`. Pela regra: param desab, vend diferentes, executor Aliq > 0 → só executor recebe.
6. **Cenário `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ` (Teste 26)**: O nome refere-se ao **executor** ter `Aliquota == 0`. O vendedor da OS **deve** ter `Aliquota > 0`. Pela regra: param desab, vend diferentes, executor Aliq == 0 → ninguém recebe.
7. **Seleção de vendedor_OS para cenários vend≠**: A query de seleção do vendedor da OS **deve** filtrar pela condição de alíquota exigida no cenário. Seleção genérica causa falsos negativos/positivos.
8. **⚠️ Ponto de atenção — MISTA HAB vend≠, VendOS SEM cpv**: A documentação diz "ambos usam Aliquota Geral Mista" quando VendOS não consta na cpv. O código atual usa AliquotaExecucao do cpv do executor + Aliquota Geral para VendOS. Pode precisar de ajuste futuro se o ERP realmente usar Aliquota Geral para ambos neste caso.
9. **⚠️ Comportamento "sem registro" vs "registro com valor 0"**: Quando param **desabilitado** + vendedores **diferentes** (Diferenciada e Mista), o **vendedor da OS NÃO gera nenhum registro** em `comissoesservico` — independente de o executor ter `Aliquota > 0` ou `Aliquota = 0`. O **executor** sempre gera registro (com valor calculado se Aliq > 0, ou com valor 0 se Aliq = 0). Cenários afetados: `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ` (Teste 25), `PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ` (Teste 26), `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__*` (Testes 37-39), `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__*` (Testes 40-42), `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__*` (Testes 52-54).
10. **⚠️ Campo `ComissaoVendedor` — Param HABILITADO**: Quando o parâmetro está habilitado, o ERP gera **2 registros** separados em `comissoesservico` para distinguir vendedor (ComissaoVendedor=1, usa cpv.Aliquota) e executor (ComissaoVendedor IS NULL, usa cpv.AliquotaExecucao). Isso acontece mesmo quando vendedor e executor são o **mesmo funcionário**. As keywords `Verifica Comissão Serviço Gerada Por Papel` e `Busca Valor Comissão Serviço Gerada Por Papel` filtram por esse campo.
11. **⚠️ Quem inserir na tela de comissões — Param HAB, vendedores diferentes**: A grid da tela de comissões só exibe registros com ValorComissao > 0. Portanto, nos cenários HAB com vendedores diferentes, quem deve ser inserido/pesquisado na tela depende de quem **efetivamente tem comissão > 0**:
    - **Executor AliqExec > 0** → insere o **executor** (`Quando insiro o técnico executor de serviço comissionado`), `Total_Comissao_OS = comissao_executor`
    - **Executor AliqExec = 0 e VendOS Aliq > 0** → insere o **vendedor OS** (`Quando insiro o vendedor comissionado`), `Total_Comissao_OS = comissao_vendedor_os`
    - **Ambos = 0** → `${Cenario_Sem_Comissao_Servico} = ${True}`, pula grid e baixa
    - Cenários afetados: Testes 30-33 (DIF HAB vend≠) e Testes 47-51, 55-58 (MISTA HAB vend≠). Quando ambos recebem (Testes 30, 47, 57, 58), o executor é inserido na tela e o vendedor OS é validado apenas via BD.
12. **⚠️ Seleção de serviço vinculada ao vendedor/cenário — MISTA**: Na linha mista, a seleção do serviço deve garantir que o serviço está vinculado (`servicos.TabelaComissao`) à **mesma linha mista** onde o vendedor/executor tem a condição de alíquota exigida no cenário. Se o serviço for de outra linha mista, a query `Consulta alíquotas serviço por vendedor` (que usa `s.TabelaComissao = cl.Codigo`) retornará a alíquota **errada** (de outra linha). Cenários SEM_CPV são exceção — qualquer serviço mista serve, pois a alíquota vem da `comissaoporlinha.Aliquota` geral.
13. **⚠️ Regra Mista — cpv vs Alíquota Geral**: Na linha mista, quando o vendedor **está** na tabela `comissaoporlinha_vendedor` vinculado a uma linha mista, usa-se a `cpv.Aliquota` desse vendedor, **independente** de ser 0 ou maior. Se `cpv.Aliquota = 0`, comissão = 0 — **NÃO há fallback** para a Alíquota Geral Mista. O fallback **só** acontece quando o vendedor **NÃO está** na tabela cpv.
14. **⚠️ Executor SEM cpv — Param DESABILITADO, vendedores diferentes (Mista)**: Quando o executor **NÃO consta** na tabela `comissaoporlinha_vendedor`, o ERP usa a `Aliquota Geral Mista` (`comissaoporlinha.Aliquota`) para calcular a comissão do executor. O vendedor da OS **NÃO gera registro** (regra padrão do param desab). Cenários: `PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__*` (Testes 52-54).
15. **⚠️ Executor SEM cpv — Param HABILITADO, vendedores diferentes (Mista)**: Quando o executor **NÃO consta** na tabela cpv, o ERP usa a `Aliquota Geral Mista` como `AliquotaExecucao` do executor. O vendedor da OS é avaliado independentemente: se tem cpv, usa `cpv.Aliquota`; se não tem cpv, usa `Aliquota Geral Mista`. Cenários: `PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__*` (Testes 56-58).
