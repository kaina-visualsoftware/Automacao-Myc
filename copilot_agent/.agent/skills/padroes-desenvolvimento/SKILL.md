---
name: Padrões de Desenvolvimento
description: Define como se desenvolve no projeto de automação Desktop do myCommerce — padrões, arquitetura e checklist
---

# Skill: Padrões de Desenvolvimento

## Nome
`padroes-desenvolvimento`

## Quando Usar
- Quando o usuário perguntar **"como desenvolver aqui?"**
- Quando precisar entender a **arquitetura** e **padrões** do projeto
- Antes de criar qualquer código novo (consultada automaticamente pela skill `geracao-testcases`)

## Entrada
- Pergunta sobre padrões, arquitetura ou processo de desenvolvimento

## Saída
- Explicação dos padrões relevantes, com exemplos do projeto

## Regras
1. Todo código gerado deve seguir as 10 regras globais do `orchestrator.md`
2. Nunca sugerir código que misture implementação em Test Cases
3. Sempre indicar keywords reutilizáveis antes de criar novas
4. Sempre usar BDD em português

---

## Arquitetura do Projeto

```
Executar_Automacao.py
  └─ Login (obrigatório)
       └─ Itera TestsCases/
            └─ Test Case .robot
                 └─ Keywords .robot
                      ├─ utils.robot (compartilhadas)
                      ├─ SikuliLibrary (visual)
                      ├─ DatabaseLibrary (MySQL)
                      └─ libs/ (Python)
```

---

## Fluxo de Desenvolvimento (Passo a Passo)

### Passo 1 — Identificar o Módulo do ERP
Determinar qual funcionalidade do myCommerce será testada:
- **Comercial**: Vendas, Condicional, Devolução, Doação, Orçamento, Ordem de Serviço
- **Financeiro**: Caixa, Contas a Pagar, Contas a Receber
- **Emissão**: Notas Fiscais, Ordem de Entrega
- **Faturamento**: Faturamento de vendas
- **Pré-Venda**: Pedidos

### Passo 2 — Criar Estrutura de Diretórios (se necessário)
Diretórios espelhados:
```
Testes_BancoAleatorio/
├── KeyWords/<Módulo>/<SubMódulo>/
└── TestsCases/<Módulo>/<SubMódulo>/
```

### Passo 3 — Capturar Imagens
1. Abrir o myCommerce no módulo a ser testado
2. Capturar (Win + Shift + S) cada elemento:
   - **Telas**: `tela_NomeDaTela.png` — barra de título
   - **Botões**: `btn_NomeDoBotao.png`
   - **Inputs**: `input_NomeDoInput.png`
   - **Modais**: `modal_NomeDoModal.png`
   - **Avisos**: `aviso_NomeDoAviso.png`
   - **Labels**: `lb_NomeDoLabel.png`
   - **Rows**: `row_NomeDaRow.png`
3. Salvar em `Testes_BancoAleatorio/images/`
4. As imagens devem ser **o menor recorte possível**

### Passo 4 — Criar Arquivo de Keywords
Localização: `KeyWords/<Módulo>/<SubMódulo>/Key<Nome><N>.robot`
- Settings completos (Libraries, Resources, Variables)
- Variáveis de imagem com prefixos corretos
- Keywords BDD em português
- Queries SQL de validação

### Passo 5 — Criar Arquivo de Test Cases
Localização: `TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome><N>.robot`
- Documentation, Resource, Suite Setup/Teardown
- Tags sequenciais
- Apenas chamadas a Keywords (sem implementação)

### Passo 6 — Testar
```powershell
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ .\TestsCases\<Módulo>\<SubMódulo>\Teste_<Nome>.robot
```

---

## Padrões de Código

### Keywords — Convenções
1. **BDD em Português**: `Dado que`, `Quando`, `Então`, `E`
2. **Argumentos embutidos no nome**: `Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})`
3. **Namespacing**: `NomeArquivo.NomeKeyword` quando houver ambiguidade
4. **Sleep antes de ações**: `Sleep    ${SLEEP_BAIXO}` antes de combinações de tecla
5. **Wait após ações**: `Wait Until Screen Contain` após navegar para outra tela
6. **Queries SQL para validação**: `Query` para obter dados, `Check If Exists/Not Exists` para validar

### Test Cases — Convenções
1. Sem implementação direta — apenas chamam Keywords
2. Tags sequenciais: `[Tags]    Teste01`, `Teste02`, etc.
3. Suite Setup padrão: `Start Sikuli Process` → `Ler imagens iniciais` → `Conectar BD` → `Preparar Ambiente`
4. Suite Teardown padrão: `Stop Remote Server`

### Montador de Cenários
Para testes com pré-condições complexas, usar `montadorDeCenarios.robot`:
```robot
Resource    ../../../utils/montadorDeCenarios.robot
```

### Integração com Python (`libs/`)
Para lógica complexa, criar classe Python em `libs/`:
```python
class minhaValidacao:
    def validar_algo(self, parametro):
        return resultado
```
Importar no Robot: `Library    ../../../libs/minhaValidacao.py`

---

## Checklist de Novo Desenvolvimento

- [ ] Módulo do ERP identificado
- [ ] Diretórios espelhados criados em `KeyWords/` e `TestsCases/`
- [ ] Imagens capturadas e salvas em `images/`
- [ ] Variáveis de imagem com prefixo correto (`${TELA_}`, `${AVISO_}`, etc.)
- [ ] Keywords criadas com BDD em português
- [ ] Test Cases criados com Tags sequenciais
- [ ] Suite Setup e Teardown configurados
- [ ] Conexão com BD configurada
- [ ] Teste executado e validado localmente
