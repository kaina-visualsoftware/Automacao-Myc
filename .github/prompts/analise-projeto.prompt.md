---
description: Workflow passo a passo para análise completa do projeto de automação — mapeia módulos, keywords e cobertura
---

# Workflow: Análise Completa do Projeto

## Objetivo
Gerar um relatório consolidado da cobertura de testes do projeto.

## Pré-requisitos
- Acesso ao diretório `C:\Automacao\mycommerce-automacao`

---

## Passos

### Passo 1 — Mapear módulos de Test Cases
Listar todos os diretórios dentro de `Testes_BancoAleatorio/TestsCases/` para identificar os módulos cobertos.

### Passo 2 — Listar arquivos de teste por módulo
Para cada módulo encontrado, listar os arquivos `.robot` de Test Cases.

### Passo 3 — Verificar espelhamento Keywords ↔ TestsCases
Listar todos os diretórios dentro de `Testes_BancoAleatorio/KeyWords/` e verificar se cada módulo tem correspondência em `TestsCases/`.

### Passo 4 — Inventariar componentes compartilhados
Listar arquivos em `Testes_BancoAleatorio/utils/` e `Testes_BancoAleatorio/libs/`.

### Passo 5 — Contar test cases por arquivo
Para cada arquivo `.robot` de Test Cases, contar o número de test cases:
```powershell
Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases" -Recurse -Filter "*.robot" | ForEach-Object { $count = (Select-String -Path $_.FullName -Pattern "^Teste\s" | Measure-Object).Count; "$($_.Name): $count testes" }
```

### Passo 6 — Contar imagens disponíveis
```powershell
(Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\images" -Filter "*.png" | Measure-Object).Count
```

### Passo 7 — Gerar relatório consolidado
Compilar resultados em tabela com:
- Total de módulos cobertos
- Total de test cases
- Total de keywords files
- Total de imagens
- Módulos sem cobertura (se houver)
- Recomendações de melhoria

### Passo 8 — Detalhar módulo específico (opcional)
Se o usuário solicitar detalhamento, consultar a skill `analise-codigo` para análise individual.

---

## Saída Esperada
Relatório consolidado em formato de tabela com totais e recomendações.
