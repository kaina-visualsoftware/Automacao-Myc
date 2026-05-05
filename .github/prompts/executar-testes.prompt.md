---
description: Workflow passo a passo para executar testes automatizados e diagnosticar falhas
---

# Workflow: Executar Testes

## Objetivo
Guiar a execução de testes e o diagnóstico de falhas.

## Pré-requisitos
- Python 3.9.13+ instalado e no PATH
- Robot Framework e bibliotecas instaladas
- Java 8+ instalado e no PATH
- myCommerce ERP aberto (ou Login como primeiro teste)

---

## Passos — Verificação de Ambiente

### Passo 1 — Verificar Python
```powershell
python --version
```

### Passo 2 — Verificar Robot Framework
```powershell
robot --version
```

### Passo 3 — Verificar bibliotecas
```powershell
pip list | Select-String "robot"
```

### Passo 4 — Verificar Java
```powershell
java -version
```

---

## Passos — Execução

### Passo 5 — Executar arquivo específico
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ .\TestsCases\<Modulo>\<SubModulo>\<Arquivo>.robot
```

### Passo 6 — Executar teste por tag (alternativa)
```powershell
robot -d .\results\ -i Teste01 .\TestsCases\<Modulo>\<SubModulo>\<Arquivo>.robot
```

### Passo 7 — Executar a partir de um teste específico (alternativa)
```powershell
robot -d .\results\ -i Teste03 -i Teste04 -i Teste05 .\TestsCases\<Modulo>\<SubModulo>\<Arquivo>.robot
```

### Passo 8 — Executar todos via script (alternativa)
```powershell
cd C:\Automacao\mycommerce-automacao
python Executar_Automacao.py
```

> **IMPORTANTE**: Clicar na tela do myCommerce após iniciar a execução para garantir foco.

---

## Passos — Análise de Resultados

### Passo 9 — Verificar relatórios
- `results/report.html` — Relatório resumido
- `results/log.html` — Log detalhado com screenshots de falha

### Passo 10 — Abrir relatório
```powershell
Start-Process "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\results\report.html"
```

---

## Passos — Diagnóstico de Falhas

### Passo 11 — Identificar tipo de falha

| Tipo de Falha | Sintoma | Solução |
|---|---|---|
| Imagem não encontrada | `Wait Until Screen Contain` timeout | Re-capturar imagem na resolução correta |
| Elemento em posição errada | Clicou no lugar errado | Verificar unicidade da imagem |
| Aviso inesperado | Popup apareceu e bloqueou | Adicionar tratamento em `validacaoAviso.robot` |
| Dados do banco | Query não retorna resultados | Verificar se o banco tem os dados necessários |
| Timing | Ação executada rápido demais | Aumentar `Sleep` antes da ação |
| Foco da janela | Teclas foram para outra janela | Adicionar `Click` na tela antes da ação |

### Passo 12 — Isolar e re-executar
```powershell
robot -d .\results\ -i <TagDoTesteFalho> .\TestsCases\<Modulo>\<SubModulo>\<Arquivo>.robot
```

### Passo 13 — Verificar manualmente
Executar o mesmo fluxo manualmente no myCommerce para verificar se o sistema mudou.

---

## Saída Esperada
- Resultado de execução (PASS/FAIL)
- Em caso de falha: diagnóstico e sugestão de correção
