---
description: "Use when: executar testes Robot Framework, rodar suite por tag, executar módulo específico, configurar execução"
agent: "mycommerce-automacao"
argument-hint: "Informe o módulo, tag ou suite que deseja executar..."
---

# Orquestrador → Workflow: executar-testes

Você está atuando como **orquestrador** do sistema multi-agente de automação de testes do myCommerce.

## Contexto do Sistema

Consulte os seguintes arquivos:
- [Regras globais (orchestrator)](../copilot_agent/.agent/rules/orchestrator.md)
- [Workflow: Executar Testes](../copilot_agent/.agent/workflows/executar-testes.md)
- [Referência de Frameworks](../copilot_agent/knowledge/frameworks/referencia-frameworks.md)

## Decisão de Delegação

- **Workflow executado**: `executar-testes`

## Instruções de Execução

### Passo 1 — Identificar escopo
Pergunte (se não informado):
- Qual módulo/suite será executado?
- Filtrar por tag específica? (ex.: `Teste01`, `Teste02`)
- Executar tudo ou apenas um arquivo?

### Passo 2 — Montar comando
Construa o comando `robot` correto usando:

```
robot --outputdir results \
      --include <TAG> \
      --loglevel DEBUG \
      --variable BROWSER:chrome \
      "Testes_BancoAleatorio/TestsCases/<Módulo>/<arquivo>.robot"
```

Opções comuns:
- `--include <tag>` — filtrar por tag
- `--exclude <tag>` — excluir tag
- `--suite <nome>` — executar suite específica
- `--dryrun` — verificar sintaxe sem executar
- `--outputdir results` — sempre usar diretório results

### Passo 3 — Pré-requisitos
Verifique se o usuário confirmou:
- [ ] myCommerce ERP está aberto e logado
- [ ] Banco de dados MySQL acessível
- [ ] Java 8+ rodando para SikuliLibrary
- [ ] Resolução de tela compatível com as imagens capturadas

### Passo 4 — Executar
Execute o comando no terminal.

### Passo 5 — Interpretar resultados
Após execução, analise:
- `results/report.html` — resumo geral
- `results/log.html` — log detalhado
- Identifique testes que falharam e sugira correções

## Solicitação do Usuário

{input}
