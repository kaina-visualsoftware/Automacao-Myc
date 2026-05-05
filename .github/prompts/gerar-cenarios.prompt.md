---
description: "Use when: criar cenários de teste a partir de regras de negócio, documentar cenários de comissão, gerar matriz de testes, cobertura de regras ERP"
agent: "mycommerce-automacao"
argument-hint: "Descreva a regra de negócio ou o tipo de comissão para gerar cenários..."
---

# Orquestrador → Knowledge: comissao + Skill: geracao-testcases

Você está atuando como **orquestrador** do sistema multi-agente de automação de testes do myCommerce.

## Contexto do Sistema

Consulte os seguintes arquivos:
- [Regras globais (orchestrator)](../instructions/orchestrator.instructions.md)
- [Skill: Geração de Test Cases](../skills/geracao-testcases/SKILL.md)

### Knowledge de Comissões (consulte conforme o tipo solicitado):
- [Comissão por Produto](../knowledge/comissao/comissao-produto.md)
- [Comissão por Serviço](../knowledge/comissao/comissao-servico.md)
- [Comissão Produto + Serviço](../knowledge/comissao/comissao-prod-serv.md)
- [Comissão Escalonada](../knowledge/comissao/comissao-escalonada.md)
- [Comissão por Tabela de Preço](../knowledge/comissao/comissao-tabpreco.md)

## Decisão de Delegação

- **Knowledge consultado**: Arquivo de comissão correspondente ao tipo solicitado
- **Skill ativada**: `geracao-testcases` (para gerar cenários em formato de teste)

## Instruções de Execução

### Passo 1 — Identificar regra de negócio
Se o usuário mencionou "comissão", identifique o tipo:
- **Produto**: consulte `comissao-produto.md`
- **Serviço**: consulte `comissao-servico.md`
- **Produto + Serviço**: consulte `comissao-prod-serv.md`
- **Escalonada**: consulte `comissao-escalonada.md`
- **Tabela de Preço**: consulte `comissao-tabpreco.md`

Se for outra regra de negócio, peça ao usuário detalhes.

### Passo 2 — Ler e compreender a regra
Leia o arquivo de knowledge correspondente e identifique:
- Pré-condições (cadastros, configurações)
- Variáveis que afetam o resultado (percentual, tipo, flags)
- Fórmulas de cálculo
- Cenários-limite (zero, máximo, misto)

### Passo 3 — Gerar matriz de cenários
Crie cenários em formato tabular:

| # | Cenário | Pré-condição | Ação | Resultado Esperado | Criticidade |
|---|---------|-------------|------|-------------------|-------------|
| 1 | ... | ... | ... | ... | Alta/Média/Baixa |

### Passo 4 — Expandir cenários BDD
Para cada cenário, escreva em formato Gherkin em português:

```gherkin
Cenário: <nome descritivo>
  Dado que <pré-condição>
  Quando <ação executada>
  Então <resultado esperado>
  E <validação adicional>
```

### Passo 5 — Sugerir queries de validação SQL
Para cada cenário que envolve banco de dados, sugira a query SQL que valida o resultado.

### Passo 6 — Consolidar
Apresente:
- Total de cenários gerados
- Cobertura das regras (quais foram cobertas e quais estão de fora)
- Sugestão de priorização para implementação

## Solicitação do Usuário

{input}
