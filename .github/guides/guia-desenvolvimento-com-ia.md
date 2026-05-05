# Guia: Como Desenvolver Testes com Assistência de IA

> **Público-alvo**: Desenvolvedores que usam o sistema de agentes IA integrado ao IDE para criar testes.

---

## O que é o Sistema de Agentes?

O projeto possui um **sistema multi-agente** no diretório `.github/` que funciona como um copiloto especializado. Ele conhece:

- Toda a **estrutura do projeto** (pastas, arquivos, padrões)
- Os **frameworks** (Robot Framework, SikuliLibrary, ImageHorizonLibrary, DatabaseLibrary)
- As **convenções** (BDD em português, prefixos de imagem, namespacing)
- As **keywords reutilizáveis** em `utils/`
- A **integração com banco** MySQL do myCommerce

---

## Estrutura do Sistema de Agentes

```
.github/
├── agents/
│   └── mycommerce-automacao.agent.md  ← Agente principal
├── instructions/
│   └── orchestrator.instructions.md    ← Regras globais e delegação
├── prompts/
│   ├── analisar-codigo.prompt.md       ← Análise de código e cobertura
│   ├── consultar-framework.prompt.md   ← Referência para knowledge de frameworks
│   ├── gerar-testcase.prompt.md        ← Templates e geração de .robot
│   ├── gerar-cenarios.prompt.md        ← Cenários de comêssão e regras de negócio
│   ├── orquestrador.prompt.md          ← Seleção automática de skill/workflow
│   ├── analise-projeto.prompt.md       ← Análise completa do projeto
│   ├── criar-testcase.prompt.md        ← Criação end-to-end de teste
│   └── executar-testes.prompt.md       ← Execução e diagnóstico
├── skills/
│   ├── analise-codigo/SKILL.md
│   ├── documentacao-frameworks/SKILL.md
│   ├── geracao-testcases/SKILL.md
│   └── padroes-desenvolvimento/SKILL.md
├── knowledge/
│   ├── comissao/                        ← Regras de negócio de comissão
│   └── frameworks/                      ← Referência de APIs dos frameworks
└── guides/
    ├── guia-desenvolvimento-manual.md   ← Guia manual
    └── guia-desenvolvimento-com-ia.md   ← Este arquivo
```

---

## Diferença: Manual vs. Com IA

| Aspecto | Manual | Com IA |
|---|---|---|
| Quem escreve o código? | Você, linha por linha | A IA gera seguindo os padrões |
| Precisa conhecer Robot Framework? | Sim, profundamente | Básico para revisão |
| Keywords existentes? | Precisa procurar manualmente | A IA já sabe quais existem |
| Naming conventions? | Precisa consultar documentação | A IA aplica automaticamente |

---

## Passo a Passo: Criando um Teste com IA

### Passo 1 — Identifique o que Testar
Tenha claro: qual módulo, quais operações, cenários especiais.

### Passo 2 — Acione o Workflow
Use o workflow `/criar-testcase` ou descreva em linguagem natural:
```
"Crie um teste automatizado para o módulo de Cadastro de Fornecedores. 
O atalho para abrir é F9. Preciso testar: inclusão, edição e exclusão."
```

### Passo 3 — Responda as Perguntas da IA
A IA pode perguntar sobre atalhos, tabelas do banco, popups específicos.

### Passo 4 — Revise o Código Gerado
Use o [Checklist de Revisão](#checklist-de-revisão) abaixo.

### Passo 5 — Capture as Imagens
A IA lista quais `.png` precisam ser capturadas. Capture e salve em `images/`.

### Passo 6 — Execute e Valide
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ -i Teste01 .\TestsCases\<Módulo>\<SubMódulo>\Teste_<Nome>1.robot
```

### Passo 7 — Itere com a IA
Se falhar, descreva o erro para a IA corrigir.

---

## Usando as Skills

### Análise de Código
```
"Analise o arquivo KeyCondicional1.robot. Quais keywords ele define?"
```

### Documentação de Frameworks
```
"Como uso o Wait Until Screen Contain do SikuliLibrary?"
```

### Padrões de Desenvolvimento
```
"Quais são as regras de nomenclatura de imagens neste projeto?"
```

### Geração de Test Cases
```
"Gere um template de Keywords para o módulo Financeiro/Boletos"
```

---

## Exemplos de Prompts Eficientes

```
✅ "Crie um teste para vendas com produto com desconto de 10%, 
   finalizando com a forma de pagamento 30 DIAS."

✅ "O Teste 03 falhou com timeout na imagem tela_OS.png. Como corrijo?"

✅ "Analise o montadorDeCenarios.robot e me diga quais cenários existem."

❌ "Faz um teste" → Falta informação
❌ "Corrige o erro" → Qual erro? Qual arquivo?
```

---

## Checklist de Revisão

### Settings
- [ ] SikuliLibrary, ImageHorizonLibrary, DatabaseLibrary importadas
- [ ] Resource para utils.robot e validacaoAviso.robot
- [ ] Variables para leituraConfig.py

### Variáveis
- [ ] `${IMAGENS}` aponta para `./Testes_BancoAleatorio/images`
- [ ] Variáveis de DB presentes
- [ ] Sleeps padrão definidos
- [ ] Variáveis de imagem com prefixo correto

### Keywords
- [ ] `Ler imagens iniciais` presente
- [ ] Nomes em BDD português
- [ ] Sleep antes de combinações de tecla
- [ ] Wait após navegar para outra tela
- [ ] Namespacing para keywords ambíguas

### Test Cases
- [ ] Resource apontando para Keywords correto
- [ ] Suite Setup/Teardown configurados
- [ ] Tags sequenciais
- [ ] Sem implementação direta

### Caminhos
- [ ] Caminhos relativos `../../../` corretos
- [ ] Diretórios espelhados entre KeyWords/ e TestsCases/

---

## O que a IA Faz vs. O que Você Faz

### A IA faz:
- Gerar código `.robot` completo com todas as convenções
- Escolher keywords reutilizáveis
- Gerar queries SQL
- Configurar Setup/Teardown
- Listar imagens necessárias
- Diagnosticar falhas

### Você faz:
- Descrever o que testar
- **Capturar imagens .png** (essencial!)
- Revisar o código gerado
- Executar o teste
- Dar foco na tela do myCommerce
- Reportar falhas
- Informar atalhos do ERP

---

> **Referência**: Para entender COMO tudo funciona internamente (sem IA), consulte o guia [guia-desenvolvimento-manual.md](./guia-desenvolvimento-manual.md).
