# Cenários Combinados — Comissão por Linha: Produto + Serviço na mesma OS

## Visão Geral

Este documento descreve os **36 cenários de teste** (Testes 73–108) que validam a comissão por linha quando a OS contém **produto e serviço simultaneamente**, com cenários **independentes** para cada um.

### Premissa

Cada teste utiliza a OS com produto e serviço incluso (`montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço`). O **mesmo vendedor** atua como vendedor da OS e executor do serviço.

### Variáveis de Controle

| Variável | Finalidade |
|---|---|
| `${Cenario_Comissao_Linha}` | Cenário de **produto** (PROD__*). Define a alíquota/tipo de comissão do produto. |
| `${Cenario_Comissao_Linha_Servico}` | Cenário de **serviço** (PARAM_DESAB__* ou PARAM_HAB__*). Quando `${None}` (default), usa fallback para `${Cenario_Comissao_Linha}`. |
| `${Tipo_Comissao_Linha_Servico}` | Tipo de linha de serviço (ex: `Diferenciada Por Vendedor`, `Mista`). Quando `${None}`, usa fallback para `${Tipo_Comissao_Linha}`. |
| `${Cenario_Sem_Comissao_Produto}` | `${True}` quando produto não gera comissão (cpv.Aliq=0). |
| `${Cenario_Sem_Comissao_Servico}` | `${True}` quando serviço não gera comissão. |

### Mecanismo de Fallback (KeyComissoes1.robot)

Nas keywords `E seleciono a comissão de serviços` e `Calcula comissão por linha de serviço - apenas 1 serviço`, as variáveis de serviço são resolvidas com:

```robotframework
${cenario_serv}    Set Variable If    $Cenario_Comissao_Linha_Servico is not None    ${Cenario_Comissao_Linha_Servico}    ${Cenario_Comissao_Linha}
${tipo_linha_serv}    Set Variable If    $Tipo_Comissao_Linha_Servico is not None    ${Tipo_Comissao_Linha_Servico}    ${Tipo_Comissao_Linha}
```

Isso garante compatibilidade total com os **72 testes existentes** (que não setam as novas variáveis).

---

## Cenários de Produto Utilizados

| ID do Cenário | Tipo de Linha | Condição | Gera Comissão? |
|---|---|---|---|
| `PROD__DIF_POR_VEND__COM_ALIQ` | Diferenciada | `cpv.Aliquota > 0` | ✅ Sim |
| `PROD__DIF_POR_VEND__SEM_ALIQ` | Diferenciada | `cpv.Aliquota = 0` | ❌ Não |
| `PROD__MISTA__COM_ALIQ` | Mista | `cpv.Aliquota > 0` | ✅ Sim |
| `PROD__MISTA__COM_ALIQ_ZERO` | Mista | `cpv.Aliquota = 0` | ❌ Não |
| `PROD__MISTA__SEM_REG_CPLV` | Mista | Sem registro cpv → usa Geral | ✅ Sim |

## Cenários de Serviço Utilizados (Mesmo Vendedor)

### Diferenciada, Param Desab (OS_COMISSAO_VENDEDOR_EXECUTOR = 0)

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ` | cpv.Aliq > 0 | ✅ Sim |
| `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ` | cpv.Aliq = 0 | ❌ Não |

### Diferenciada, Param Hab (OS_COMISSAO_VENDEDOR_EXECUTOR = 1)

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC` | Aliq > 0, AliqExec = 0 | ✅ Sim |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC` | Aliq = 0, AliqExec > 0 | ✅ Sim |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ` | Aliq > 0, AliqExec > 0 | ✅ Sim |
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ` | Aliq = 0, AliqExec = 0 | ❌ Não |

### Mista, Param Desab (OS_COMISSAO_VENDEDOR_EXECUTOR = 0)

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ` | cpv.Aliq > 0 | ✅ Sim |
| `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO` | cpv.Aliq = 0 | ❌ Não |
| `PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | Sem cpv → usa Geral | ✅ Sim |

### Mista, Param Hab (OS_COMISSAO_VENDEDOR_EXECUTOR = 1)

| ID do Cenário | Condição | Gera Comissão? |
|---|---|---|
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO` | Aliq > 0, AliqExec = 0 | ✅ Sim |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC` | Aliq = 0, AliqExec > 0 | ✅ Sim |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ` | Aliq > 0, AliqExec > 0 | ✅ Sim |
| `PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | Sem cpv → 2×Geral | ✅ Sim |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO` | Aliq = 0, AliqExec = 0 | ❌ Não |

---

## Matriz de Testes

### Grupo A — Produto Diferenciada × Serviço Diferenciada, Param Desab (4 testes)

| Teste | Cenário Produto | Cenário Serviço | Prod Gera? | Serv Gera? |
|---|---|---|---|---|
| **73** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ` | ✅ | ✅ |
| **74** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ` | ✅ | ❌ |
| **75** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ` | ❌ | ✅ |
| **76** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ` | ❌ | ❌ |

### Grupo B — Produto Diferenciada × Serviço Diferenciada, Param Hab (8 testes)

| Teste | Cenário Produto | Cenário Serviço | Prod Gera? | Serv Gera? |
|---|---|---|---|---|
| **77** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC` | ✅ | ✅ |
| **78** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC` | ✅ | ✅ |
| **79** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ` | ✅ | ✅ |
| **80** | `PROD__DIF_POR_VEND__COM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ` | ✅ | ❌ |
| **81** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC` | ❌ | ✅ |
| **82** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC` | ❌ | ✅ |
| **83** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ` | ❌ | ✅ |
| **84** | `PROD__DIF_POR_VEND__SEM_ALIQ` | `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ` | ❌ | ❌ |

### Grupo C — Produto Mista × Serviço Mista, Param Desab (9 testes)

| Teste | Cenário Produto | Cenário Serviço | Prod Gera? | Serv Gera? |
|---|---|---|---|---|
| **85** | `PROD__MISTA__COM_ALIQ` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ` | ✅ | ✅ |
| **86** | `PROD__MISTA__COM_ALIQ` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO` | ✅ | ❌ |
| **87** | `PROD__MISTA__COM_ALIQ` | `PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ✅ | ✅ |
| **88** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ` | ❌ | ✅ |
| **89** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO` | ❌ | ❌ |
| **90** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ❌ | ✅ |
| **91** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ` | ✅ | ✅ |
| **92** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO` | ✅ | ❌ |
| **93** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ✅ | ✅ |

### Grupo D — Produto Mista × Serviço Mista, Param Hab (15 testes)

| Teste | Cenário Produto | Cenário Serviço | Prod Gera? | Serv Gera? |
|---|---|---|---|---|
| **94** | `PROD__MISTA__COM_ALIQ` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO` | ✅ | ✅ |
| **95** | `PROD__MISTA__COM_ALIQ` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC` | ✅ | ✅ |
| **96** | `PROD__MISTA__COM_ALIQ` | `PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ` | ✅ | ✅ |
| **97** | `PROD__MISTA__COM_ALIQ` | `PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ✅ | ✅ |
| **98** | `PROD__MISTA__COM_ALIQ` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO` | ✅ | ❌ |
| **99** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO` | ❌ | ✅ |
| **100** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC` | ❌ | ✅ |
| **101** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ` | ❌ | ✅ |
| **102** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ❌ | ✅ |
| **103** | `PROD__MISTA__COM_ALIQ_ZERO` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO` | ❌ | ❌ |
| **104** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO` | ✅ | ✅ |
| **105** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC` | ✅ | ✅ |
| **106** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ` | ✅ | ✅ |
| **107** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV` | ✅ | ✅ |
| **108** | `PROD__MISTA__SEM_REG_CPLV` | `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO` | ✅ | ❌ |

---

## Cenários Novos Adicionados (branches em KeyComissoes1.robot)

Dois cenários novos foram criados na keyword `Valida Comissão Linha Serviço` para cobrir os casos onde **param habilitado + mesmo vendedor + ambas alíquotas = 0**:

| ID do Cenário | Tipo | Descrição |
|---|---|---|
| `PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ` | Diferenciada | Aliq=0 e AliqExec=0 → ninguém recebe |
| `PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO` | Mista | cpv.Aliq=0 e cpv.AliqExec=0 → ninguém recebe |

Ambos validam no BD que os registros existem com `ValorComissao = 0` para vendedor e executor.

---

## Fluxo de Cada Teste

```
[Setup]
  → Set ${Cenario_Comissao_Linha} = cenário de produto
  → Set ${Cenario_Comissao_Linha_Servico} = cenário de serviço
  → Set PARAMS_PRE_CONDICOES com OS_COMISSAO_VENDEDOR_EXECUTOR 0|1
  → (Opcional) Set ${Cenario_Sem_Comissao_Produto} = ${True}
  → (Opcional) Set ${Cenario_Sem_Comissao_Servico} = ${True}
  → Montador cria OS com prod+serv

[Passos]
  1. Dado que acesso a tela de comissões
  2. Quando insiro o vendedor comissionado
  3. E seleciono a comissão de produtos    ← usa ${Cenario_Comissao_Linha}
  4. E baixo a comissao recém recebida     ← pula se Sem_Comissao_Produto
  5. E vou para a aba de servicos
  6. E seleciono a comissão de serviços    ← usa ${Cenario_Comissao_Linha_Servico}
  7. E baixo a comissao recém recebida     ← pula se Sem_Comissao_Servico
  8. E saio da tela(Comissoes)
```

---

## Arquivos Modificados

| Arquivo | Alteração |
|---|---|
| `KeyComissoes1.robot` | Adicionadas variáveis `${Cenario_Comissao_Linha_Servico}` e `${Tipo_Comissao_Linha_Servico}` (default `${None}`). Modificadas keywords `E seleciono a comissão de serviços` e `Calcula comissão por linha de serviço - apenas 1 serviço` com lógica de fallback. Adicionadas 2 branches novas na keyword `Valida Comissão Linha Serviço`. |
| `Teste_Comissoes1.robot` | 36 novos casos de teste (Testes 73–108) organizados em 4 grupos (A–D). |

---

## Resumo por Grupo

| Grupo | Tipo Produto | Tipo Serviço | Parâmetro | Qtd Testes |
|---|---|---|---|---|
| **A** | Diferenciada | Diferenciada | Desabilitado | 4 |
| **B** | Diferenciada | Diferenciada | Habilitado | 8 |
| **C** | Mista | Mista | Desabilitado | 9 |
| **D** | Mista | Mista | Habilitado | 15 |
| | | | **Total** | **36** |
