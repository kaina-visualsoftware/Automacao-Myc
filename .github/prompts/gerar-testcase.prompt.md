---
description: "Use when: criar novo test case, gerar teste automatizado, novo módulo de teste, expandir cobertura de testes Robot Framework"
agent: "mycommerce-automacao"
argument-hint: "Descreva o módulo e cenários que deseja testar..."
---

# Orquestrador → Skill: geracao-testcases → Workflow: criar-testcase

Você está atuando como **orquestrador** do sistema multi-agente de automação de testes do myCommerce.

## Contexto do Sistema

Consulte os seguintes arquivos para entender o sistema:
- [Regras globais (orchestrator)](../copilot_agent/.agent/rules/orchestrator.md)
- [Skill: Geração de Test Cases](../copilot_agent/.agent/skills/geracao-testcases/SKILL.md)
- [Skill: Padrões de Desenvolvimento](../copilot_agent/.agent/skills/padroes-desenvolvimento/SKILL.md)
- [Workflow: Criar Test Case](../copilot_agent/.agent/workflows/criar-testcase.md)
- [Referência de Frameworks](../copilot_agent/knowledge/frameworks/referencia-frameworks.md)

## Decisão de Delegação

- **Skill ativada**: `geracao-testcases`
- **Workflow executado**: `criar-testcase`
- **Knowledge consultado**: `padroes-desenvolvimento` + `referencia-frameworks`

## Instruções de Execução

Siga **rigorosamente** o workflow `criar-testcase` na ordem:

### Passo 1 — Identificar o módulo
Pergunte ao usuário (se não informou): qual módulo do myCommerce será testado e quais cenários.

### Passo 2 — Verificar estrutura existente
Verifique se os diretórios já existem em `KeyWords/` e `TestsCases/`. Se existem, verifique a numeração do próximo arquivo.

### Passo 3 — Criar diretórios (se necessário)
Crie diretórios espelhados em `KeyWords/<Módulo>/<SubMódulo>/` e `TestsCases/<Módulo>/<SubMódulo>/`.

### Passo 4 — Gerar Keywords (.robot)
Gere o arquivo de Keywords seguindo o template da skill `geracao-testcases`, com:
- Todas as Libraries e Resources obrigatórias
- Variáveis de imagem com prefixos corretos (`${TELA_}`, `${AVISO_}`, `${BTN_}`, etc.)
- Keywords BDD em português (`Dado que`, `Quando`, `Então`, `E`)
- Queries SQL de validação
- Keyword `Ler imagens iniciais` obrigatória

### Passo 5 — Gerar Test Cases (.robot)
Gere o arquivo de Test Cases com:
- `Documentation`
- `Resource` apontando para o arquivo de Keywords
- `Suite Setup`: `Start Sikuli Process` → `Ler imagens iniciais` → `Conectar ao Banco de Dados` → `Preparar Ambiente MyCommerce`
- `Suite Teardown`: `Stop Remote Server`
- `[Tags]` sequenciais: `Teste01`, `Teste02`, etc.
- **Sem implementação direta** — apenas chamadas a Keywords

### Passo 6 — Listar imagens necessárias
Liste todas as imagens `.png` que o usuário precisa capturar, com nome exato e descrição.

### Passo 7 — Validar
Confirme que os caminhos relativos (`../../../`) estão corretos.

## Solicitação do Usuário

{input}
