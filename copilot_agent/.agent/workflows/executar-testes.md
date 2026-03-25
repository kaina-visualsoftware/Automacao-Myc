---
description: Executar testes automatizados do projeto mycommerce-automacao
---

# Executar Testes

## Pré-requisitos
- Python 3.9.13+ instalado e no PATH
- Robot Framework instalado: `pip install robotframework`
- SikuliLibrary instalada: `pip install robotframework-SikuliLibrary`
- ImageHorizonLibrary instalada: `pip install robotframework-imagehorizonlibrary`
- FakerLibrary instalada: `pip install robotframework-faker`
- DatabaseLibrary instalada: `pip install robotframework-databaselibrary`
- MySQL Connector instalado: `pip install mysql-connector-python`
- Java 8+ instalado e no PATH
- myCommerce ERP aberto e logado (ou Login como primeiro teste)
- Python Path configurado no VS Code (ver readme.md)

## Verificar Instalação

1. **Verificar Python**:
```powershell
python --version
```

2. **Verificar Robot Framework**:
```powershell
robot --version
```

3. **Verificar bibliotecas instaladas**:
```powershell
pip list | Select-String "robot"
```

4. **Verificar Java**:
```powershell
java -version
```

## Executar Testes

### Opção 1 — Executar um arquivo específico

5. Executar um arquivo de test case:
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ .\TestsCases\<Modulo>\<SubModulo>\<Arquivo>.robot
```

**Exemplo concreto:**
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Opção 2 — Executar teste específico por tag

6. Para executar apenas um teste:
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ -i Teste01 .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Opção 3 — Executar a partir de um teste específico

7. Para executar a partir do teste 3 em diante:
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ -i Teste03 -i Teste04 -i Teste05 .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Opção 4 — Executar todos os testes via script Python

8. Executar o executor automático completo:
```powershell
cd C:\Automacao\mycommerce-automacao
python Executar_Automacao.py
```

> ⚠️ **IMPORTANTE**: Este script requer permissão de administrador e executa automaticamente (`runas`).
> ⚠️ **IMPORTANTE**: Clicar na tela do myCommerce após iniciar a execução para garantir foco.

## Analisar Resultados

9. Após a execução, verificar os relatórios gerados:
   - `results/report.html` — Relatório resumido
   - `results/log.html` — Log detalhado com screenshots de falha

10. Para abrir o relatório no navegador:
```powershell
Start-Process "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\results\report.html"
```

## Diagnóstico de Falhas

11. Se um teste falhar:
    - Verificar em qual keyword ocorreu a falha (no `log.html`)
    - Verificar se é problema de imagem (screenshot esperado vs real)
    - Isolar o teste por tag e re-executar
    - Fazer o processo manualmente para verificar se o erro é do ERP ou da automação
    - Verificar se o ERP está respondendo (pode ter travado)
    - Verificar se as imagens em `images/` correspondem à versão atual do myCommerce
