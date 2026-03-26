# Cenários de Comissão por Linha — Produtos

## Visão Geral

Este documento descreve os **15 cenários de teste** (Testes 57–71) que validam a comissão por linha para **produtos**, cobrindo os tipos de linha **Diferenciada Por Vendedor** e **Mista**.

### Diferenças em relação à comissão de serviço

| Aspecto | Serviço | Produto |
|---|---|---|
| Parâmetro "Gerar comissão p/ executor" | Sim (habilita/desabilita) | **Não se aplica** |
| Campo `AliquotaExecucao` | Usado quando param. habilitado | **Não utilizado** |
| Tabela de alíquota por vendedor | `comissaoporlinha_vendedor` | `comissaoporlinha_vendedor` |
| Vínculo com linha de comissão | `servicos.CodigoComissao` | `produtos.CodigoComissao` |
| Tabela de valor base | `vendasservicos.ValorUnitario` | `vendasprodutos.ValorUnitario` |
| Tabela de comissão gerada | `vendasservicos.ValorComissao` | `vendasprodutos.ValorComissao` |
| Pré-condição do vendedor | `clientes.ComissaoVendaServicos = 1` | `clientes.ComissaoVendaProdutos = 1` |

---

## Identificadores de Cenário

| ID do Cenário | Tipo de Linha | Condição |
|---|---|---|
| `PROD__DIF_POR_VEND__COM_ALIQ` | Diferenciada Por Vendedor | `cpv.Aliquota > 0` → gera comissão |
| `PROD__DIF_POR_VEND__SEM_ALIQ` | Diferenciada Por Vendedor | `cpv.Aliquota = 0` → comissão zerada |
| `PROD__MISTA__COM_ALIQ` | Mista | Vendedor TEM registro cpv, `cpv.Aliquota > 0` → usa cpv |
| `PROD__MISTA__COM_ALIQ_ZERO` | Mista | Vendedor TEM registro cpv, `cpv.Aliquota = 0` → comissão zerada |
| `PROD__MISTA__SEM_REG_CPLV` | Mista | Vendedor NÃO TEM registro cpv → usa Alíquota Geral (`cl.Aliquota`) |

---

## Operações Testadas

Cada cenário é executado em **3 tipos de operação**:

1. **Venda de Balcão** — Venda simples com produto
2. **Ordem de Serviço com Produto e Serviço** — OS que contém ambos
3. **Ordem de Serviço somente com Produto** — OS sem serviço (novo montador)

---

## Matriz de Testes

| Teste | Cenário | Operação | Gera Comissão? | Alíquota Utilizada |
|---|---|---|---|---|
| **57** | `PROD__DIF_POR_VEND__COM_ALIQ` | Venda Balcão | ✅ Sim | `cpv.Aliquota` (> 0) |
| **58** | `PROD__DIF_POR_VEND__COM_ALIQ` | OS prod + serviço | ✅ Sim | `cpv.Aliquota` (> 0) |
| **59** | `PROD__DIF_POR_VEND__COM_ALIQ` | OS só produto | ✅ Sim | `cpv.Aliquota` (> 0) |
| **60** | `PROD__DIF_POR_VEND__SEM_ALIQ` | Venda Balcão | ❌ Não | `cpv.Aliquota` (= 0) |
| **61** | `PROD__DIF_POR_VEND__SEM_ALIQ` | OS prod + serviço | ❌ Não | `cpv.Aliquota` (= 0) |
| **62** | `PROD__DIF_POR_VEND__SEM_ALIQ` | OS só produto | ❌ Não | `cpv.Aliquota` (= 0) |
| **63** | `PROD__MISTA__COM_ALIQ` | Venda Balcão | ✅ Sim | `cpv.Aliquota` (> 0) |
| **64** | `PROD__MISTA__COM_ALIQ` | OS prod + serviço | ✅ Sim | `cpv.Aliquota` (> 0) |
| **65** | `PROD__MISTA__COM_ALIQ` | OS só produto | ✅ Sim | `cpv.Aliquota` (> 0) |
| **66** | `PROD__MISTA__COM_ALIQ_ZERO` | Venda Balcão | ❌ Não | `cpv.Aliquota` (= 0) |
| **67** | `PROD__MISTA__COM_ALIQ_ZERO` | OS prod + serviço | ❌ Não | `cpv.Aliquota` (= 0) |
| **68** | `PROD__MISTA__COM_ALIQ_ZERO` | OS só produto | ❌ Não | `cpv.Aliquota` (= 0) |
| **69** | `PROD__MISTA__SEM_REG_CPLV` | Venda Balcão | ✅ Sim | `cl.Aliquota` (geral mista) |
| **70** | `PROD__MISTA__SEM_REG_CPLV` | OS prod + serviço | ✅ Sim | `cl.Aliquota` (geral mista) |
| **71** | `PROD__MISTA__SEM_REG_CPLV` | OS só produto | ✅ Sim | `cl.Aliquota` (geral mista) |

---

## Variável de Controle: `Cenario_Sem_Comissao_Produto`

Nos cenários onde a comissão esperada é **zero** (Testes 60–62 e 66–68), a variável `${Cenario_Sem_Comissao_Produto}` é setada para `${True}` no `[Setup]` do teste. Isso faz com que:

- A keyword `E seleciono a comissão de produtos` execute a validação mas **não tente localizar** a comissão na tela (pois não existe registro com valor > 0).
- A keyword `E baixo a comissao recém recebida` **pule a baixa** (não há comissão para baixar).

---

## Fórmula de Cálculo

```
ValorComissao = ValorUnitario × (Aliquota / 100)
```

Arredondamento: `ROUND_HALF_UP` com 2 casas decimais.

A validação aceita diferença de até **R$ 0,01** (centavo) entre o valor calculado e o valor no banco.

---

## Arquivos Modificados

| Arquivo | Alteração |
|---|---|
| `montadorDeCenarios.robot` | Novo keyword: `Dado que realizo uma ordem de serviço somente com produto - A prazo` |
| `utils.robot` | Branches para 5 cenários PROD__* em: `Valida teste de comissão`, `Seleciona Vendedor Comissão Linha`, `Seleciona produto com linha cadastrada` |
| `KeyComissoes1.robot` | 8 novas keywords de consulta/cálculo/validação de produto + adaptação de `E seleciono a comissão de produtos` e `E baixo a comissao recém recebida` |
| `Teste_Comissoes1.robot` | 15 novos casos de teste (Testes 57–71) |

---

## Diagrama de Fluxo da Validação

```
E seleciono a comissão de produtos
│
├─ Cenario_Sem_Comissao_Produto = True?
│   └─ Sim → Valida Comissão Linha Produto → RETURN (sem selecionar na tela)
│
├─ Cenário começa com "PROD__"?
│   └─ Sim → Valida Comissão Linha Produto → continua seleção normal na tela
│
└─ Não → fluxo legado (cenários de serviço)
```

```
Valida Comissão Linha Produto (tipo_linha, cenario)
│
├─ PROD__DIF_POR_VEND__COM_ALIQ
│   └─ Consulta cpv.Aliquota → Calcula → Compara com BD
│
├─ PROD__DIF_POR_VEND__SEM_ALIQ
│   └─ Verifica que NÃO gerou comissão (ValorComissao = 0)
│
├─ PROD__MISTA__COM_ALIQ
│   └─ Consulta cpv.Aliquota → Calcula → Compara com BD
│
├─ PROD__MISTA__COM_ALIQ_ZERO
│   └─ Verifica que NÃO gerou comissão (ValorComissao = 0)
│
└─ PROD__MISTA__SEM_REG_CPLV
    └─ cpv = None → Consulta cl.Aliquota (geral) → Calcula → Compara com BD
```
