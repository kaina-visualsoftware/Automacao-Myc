---
description: Workflow passo a passo para criar um novo test case completo (Keywords + TestCase) seguindo os padrões do projeto
---

# Workflow: Criar Novo Test Case

## Objetivo
Guiar a criação end-to-end de um novo test case, desde a identificação do módulo até a validação.

## Pré-requisitos
- Saber qual módulo/funcionalidade do ERP será testada
- Imagens das telas capturadas (ou indicação de que serão capturadas depois)

---

## Passos

### Passo 1 — Identificar o módulo
Perguntar ao usuário qual funcionalidade do myCommerce deseja testar. Exemplos: Venda, Condicional, Devolução, Pedido, OS, Caixa.

### Passo 2 — Verificar estrutura existente
Verificar se diretórios já existem:
```powershell
Test-Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>"
Test-Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>"
```

### Passo 3 — Criar diretórios (se necessário)
```powershell
New-Item -ItemType Directory -Force -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>"
New-Item -ItemType Directory -Force -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>"
```

### Passo 4 — Verificar numeração
Se já existem arquivos para o módulo, identificar o próximo número:
```powershell
Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>" -Filter "*.robot"
```

### Passo 5 — Consultar a skill `geracao-testcases`
Usar os templates da skill para gerar os arquivos. Seguir rigorosamente os templates e substituir todos os placeholders.

### Passo 6 — Criar arquivo de Keywords
Gerar `KeyWords/<Modulo>/<SubModulo>/Key<Nome><N>.robot` com:
- Settings completos (Libraries, Resources, Variables)
- Variáveis de imagem para cada tela/elemento
- Keywords BDD em português
- Queries SQL de validação

### Passo 7 — Criar arquivo de Test Cases
Gerar `TestsCases/<Modulo>/<SubModulo>/Teste_<Nome><N>.robot` com:
- Documentation
- Resource apontando para o arquivo de Keywords criado
- Suite Setup e Teardown padrão
- Test Cases com Tags sequenciais

### Passo 8 — Verificar referências
Confirmar que os caminhos relativos (`../../../`) estão corretos para o nível de diretório.

### Passo 9 — Listar imagens necessárias
Informar ao usuário quais imagens `.png` precisam ser capturadas e salvas em `images/`.

### Passo 10 — Validar com dry-run (opcional)
```powershell
robot --dryrun -d .\results\ "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>\Teste_<Nome><N>.robot"
```

---

## Regras Obrigatórias
- Sempre consultar `orchestrator.md` antes de gerar código
- Nunca incluir implementação direta nos Test Cases
- Manter padrão BDD em português
- Namespacing obrigatório para keywords importadas

## Saída Esperada
- 1 arquivo de Keywords completo
- 1 arquivo de Test Cases completo
- Lista de imagens a serem capturadas
