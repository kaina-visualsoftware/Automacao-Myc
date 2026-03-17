---
description: Análise completa do projeto de automação — mapeia módulos, keywords e cobertura
---

# Análise Completa do Projeto

## Pré-requisitos
- Acesso ao diretório `C:\Automacao\mycommerce-automacao`

## Passos

1. Listar todos os diretórios dentro de `Testes_BancoAleatorio/TestsCases/` para identificar os módulos cobertos.

2. Para cada módulo encontrado, listar os arquivos `.robot` de Test Cases.

3. Listar todos os diretórios dentro de `Testes_BancoAleatorio/KeyWords/` e verificar espelhamento com `TestsCases/`.

4. Listar arquivos em `Testes_BancoAleatorio/utils/` e anotar keywords compartilhadas.

5. Listar arquivos em `Testes_BancoAleatorio/libs/` e anotar bibliotecas Python.

6. Para cada arquivo `.robot` de Test Cases, contar o número de test cases usando grep por linhas que começam com `Teste`:
```powershell
Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases" -Recurse -Filter "*.robot" | ForEach-Object { $count = (Select-String -Path $_.FullName -Pattern "^Teste\s" | Measure-Object).Count; "$($_.Name): $count testes" }
```

7. Listar imagens em `Testes_BancoAleatorio/images/` e contar quantas existem:
```powershell
(Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\images" -Filter "*.png" | Measure-Object).Count
```

8. Gerar relatório consolidado com:
   - Total de módulos cobertos
   - Total de test cases
   - Total de keywords files
   - Total de imagens
   - Módulos sem cobertura (se houver)
   - Recomendações de melhoria

9. Consultar a skill `analise-codigo` para detalhamento de qualquer módulo específico que o usuário solicitar.
