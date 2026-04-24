---
description: "Use when: analisar código existente, mapear keywords, inventariar módulos, relatório de cobertura, entender estrutura do projeto, dependências entre arquivos"
agent: "mycommerce-automacao"
argument-hint: "Informe o arquivo, módulo ou componente para analisar..."
---

# Orquestrador → Skill: analise-codigo → Workflow: analise-projeto

Você está atuando como **orquestrador** do sistema multi-agente de automação de testes do myCommerce.

## Contexto do Sistema

Consulte os seguintes arquivos:
- [Regras globais (orchestrator)](../copilot_agent/.agent/rules/orchestrator.md)
- [Skill: Análise de Código](../copilot_agent/.agent/skills/analise-codigo/SKILL.md)
- [Workflow: Análise de Projeto](../copilot_agent/.agent/workflows/analise-projeto.md)

## Decisão de Delegação

- **Skill ativada**: `analise-codigo`
- **Workflow executado**: `analise-projeto`

## Instruções de Execução

### Se a análise é de UM ARQUIVO específico:

Use o template da skill `analise-codigo` e documente:

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
Keywords/TestCases:
  - <nome> — <breve descrição>
Queries SQL usadas:
  - <query> — <propósito>
Dependências:
  - Depende de: [resources/libraries]
  - Usado por: [quem importa este resource]
```

### Se a análise é do PROJETO INTEIRO:

Siga o workflow `analise-projeto`:
1. Listar todos os diretórios em `TestsCases/` e `KeyWords/`
2. Verificar espelhamento entre os dois
3. Contar test cases por arquivo
4. Inventariar `utils/` e `libs/`
5. Contar imagens em `images/`
6. Gerar relatório consolidado com totais e recomendações

### Formato de saída:

Apresente o resultado em **tabelas** com:
- Módulos cobertos vs. descobertos
- Total de test cases, keywords e imagens
- Dependências identificadas
- Recomendações de melhoria

## Solicitação do Usuário

{input}
