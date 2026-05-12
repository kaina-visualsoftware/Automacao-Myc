---
description: Criar um novo test case completo (Keywords + TestCase) seguindo os padrões do projeto
---

# Criar Novo Test Case

## Pré-requisitos
- Saber qual módulo/funcionalidade do ERP será testada
- Imagens das telas capturadas (ou indicação de que serão capturadas depois)

## Passos

1. **Identificar o módulo** — Perguntar ao usuário qual funcionalidade do myCommerce deseja testar. Exemplos: Venda, Condicional, Devolução, Pedido, OS, Caixa.

2. **Verificar estrutura existente** — Verificar se diretórios já existem:
```powershell
Test-Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>"
Test-Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>"
```

3. **Criar diretórios** (se necessário):
// turbo
```powershell
New-Item -ItemType Directory -Force -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>"
New-Item -ItemType Directory -Force -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>"
```

4. **Verificar numeração** — Se já existem arquivos para o módulo, identificar o próximo número:
```powershell
Get-ChildItem -Path "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\KeyWords\<Modulo>\<SubModulo>" -Filter "*.robot"
```

5. **Consultar a skill `geracao-testcases`** — Usar os templates da skill para gerar os arquivos:
   - Ler `c:\Automacao\mycommerce-automacao\.agent\skills\geracao-testcases\SKILL.md`
   - Seguir rigorosamente os templates e substituir todos os placeholders

6. **Criar arquivo de Keywords** — Gerar `KeyWords/<Modulo>/<SubModulo>/Key<Nome><N>.robot` com:
   - Settings completos (Libraries, Resources, Variables)
   - Variáveis de imagem para cada tela/elemento
   - Keywords BDD em português
   - Queries SQL de validação

7. **Criar arquivo de Test Cases** — Gerar `TestsCases/<Modulo>/<SubModulo>/Teste_<Nome><N>.robot` com:
   - Documentation
   - Resource apontando para o arquivo de Keywords criado
   - Suite Setup e Teardown padrão
   - Test Cases com Tags sequenciais

8. **Verificar referências** — Confirmar que os caminhos relativos (`../../../`) estão corretos para o nível de diretório.

9. **Listar imagens necessárias** — Informar ao usuário quais imagens `.png` precisam ser capturadas e salvas em `images/`.

10. **Validar com dry-run** (opcional):
```powershell
robot --dryrun -d .\results\ "C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio\TestsCases\<Modulo>\<SubModulo>\Teste_<Nome><N>.robot"
```

## Regras Obrigatórias
- Sempre consultar `orchestrator.md` antes de gerar código
- Nunca incluir implementação direta nos Test Cases
- Manter padrão BDD em português
- Namespacing obrigatório para keywords importadas
