# Regras de Nomenclatura — Padrões do Projeto

Este documento define todas as regras de nomenclatura para arquivos, variáveis, keywords e imagens no projeto mycommerce-automacao.

---

## 1. Nomenclatura de Arquivos

### 1.1 Arquivos de Keywords

**Padrão:**
```
Key<Nome><N>.robot
```

**Regras:**
- `Key` maiúsculo
- `<Nome>` em CamelCase (iniciando com maiúscula)
- `<N>` = número sequencial (1, 2, 3...)

**Exemplos:**
```
✅ KeyCondicional1.robot
✅ KeyOrdemDeServico1.robot
✅ KeyComissoes1.robot
✅ KeyVendas2.robot

❌ keyCondicional1.robot  (minúsculo)
❌ Key_condicional1.robot  (underscore)
❌ KeyCondicional.robot   (sem número)
```

---

### 1.2 Arquivos de Test Cases

**Padrão:**
```
Teste_<Nome><N>.robot
```

**Regras:**
- `Teste_` maiúsculo
- `<Nome>` em CamelCase
- `<N>` = número sequencial

**Exemplos:**
```
✅ Teste_Condicional1.robot
✅ Teste_OrdemDeServico1.robot
✅ Teste_Comissoes1.robot

❌ teste_condicional.robot  (minúsculo)
❌ TesteCondicional1.robot  (sem underscore)
❌ Teste_Condicional.robot  (sem número)
```

---

### 1.3 Arquivos de Utils

**Padrão:**
```
<nome>.robot
```

**Exemplos:**
```
✅ utils.robot
✅ validacaoAviso.robot
✅ montadorDeCenarios.robot
✅ parametros_pre_condicoes.robot
```

---

### 1.4 Arquivos de Bibliotecas Python

**Padrão:**
```
<nome>.py
```

**Exemplos:**
```
✅ validaParametros.py
✅ validaComissoes.py
✅ leituraConfig.py
```

---

## 2. Nomenclatura de Imagens

### 2.1 Prefixos Obrigatórios

| Prefixo | Uso | Exemplo |
|---------|-----|---------|
| `tela_` | Telas/janelas | `tela_OrdemServico.png` |
| `bt_` | Botões | `bt_Adicionar.png` |
| `btn_` | Botões (alternativo) | `btn_Salvar.png` |
| `input_` | Campos de entrada | `input_CPF.png` |
| `lb_` | Labels/rótulos | `lb_Cliente.png` |
| `aviso_` | Avisos/alertas | `aviso_Erro.png` |
| `modal_` | Modais/popups | `modal_Confirmar.png` |
| `row_` | Linhas de grid | `row_Item.png` |
| `aba_` | Abas | `aba_Dados.png` |
| `icone_` | Ícones | `icone_Salvar.png` |

---

### 2.2 Regras de Nomenclatura

**Exemplos corretos:**
```
✅ tela_OrdemServico.png
✅ bt_Adicionar.png
✅ bt_Excluir.png
✅ input_CPFCliente.png
✅ lb_RazaoSocial.png
✅ aviso_ClienteNaoEncontrado.png
✅ modal_ConfirmarExclusao.png
✅ row_ProdutoSelecionado.png

❌ OS.png              (sem prefixo)
❌ botao_adicionar.png (minúsculo)
❌ BT_Adicionar.png   (maiúsculo demais)
❌ telai.png           (juntado)
```

---

## 3. Nomenclatura de Variáveis

### 3.1 Variáveis de Imagem

**Padrão:**
```
${PREFIX_NOME}
```

**Exemplos:**
```robot
${TELA_OS}                  tela_OrdemServico.png
${BT_ADICIONAR}             bt_Adicionar.png
${INPUT_CPF}                input_CPF.png
${AVISO_ERRO}               aviso_Erro.png
${MODAL_CONFIRMAR}          modal_Confirmar.png
```

---

### 3.2 Variáveis de Banco de Dados

**Padrão:**
```
${DB<nome>}
```

**Exemplos:**
```robot
${DBHost}
${DBName}
${DBPass}
${DBPort}
${DBUser}
```

---

### 3.3 Variáveis de Tempo

**Padrão:**
```
${SLEEP_<NIVEL>}
${TEMPO_<TIPO>}
```

**Exemplos:**
```robot
${SLEEP_BAIXO}    0.7
${SLEEP_MEDIO}    1.5
${SLEEP_ALTO}     3
${TEMPO_TELA}     25
```

---

### 3.4 Variáveis de Cenário

**Padrão:**
```
${Cenario_<DESCRICAO>}
${Tipo_<DESCRICAO>}
```

**Exemplos:**
```robot
${Cenario_Comissao_Linha}
${Tipo_Comissao_Linha}
${Cenario_Sem_Comissao_Produto}
```

---

## 4. Nomenclatura de Keywords

### 4.1 Keywords BDD

**Padrão:**
```
Dado que <ação>
Quando <ação>
Então <ação>
E <ação>
```

**Regras:**
- Verbos no infinitivo
- Primeira letra maiúscula
- Args entre parênteses quando necessário

**Exemplos:**
```robot
✅ Dado que acesso a tela de vendas
✅ Quando insiro o vendedor comissionado
✅ E seleciono a comissão de produtos
✅ Então baixo a comissão recebida
✅ Quando insiro um produto normal informando a quantidade(${Quantidade})

❌ acessar a tela de vendas  (infinitivo)
❌ ACESSAR A TELA           (maiúsculo)
❌ insiro produto           (sem E/Quando)
```

---

### 4.2 Keywords Utilitárias

**Padrão:**
```
<Verbo> <Objeto>
```

**Exemplos:**
```robot
✅ Ler imagens iniciais
✅ Adicionar Vendedor e Cliente
✅ Inserir produto normal
✅ Validar parâmetros após incluir produto

❌ ler_imagens_iniciais  (underscore)
❌ LerImagensIniciais   (CamelCase)
```

---

### 4.3 Keywords de Validação

**Padrão:**
```
Verifica <algo>
Valida <algo>
Busca <algo>
```

**Exemplos:**
```robot
✅ Verifica Comissão Serviço Gerada Por Papel
✅ Valida solicitação de senha do usuário supervisor
✅ Busca valor comissão serviço gerada por papel
✅ Verifica avisos presentes ao incluir cliente
```

---

## 5. Nomenclatura de Tags

### 5.1 Tags de Teste

**Padrão:**
```
Teste<NN>
```

**Exemplos:**
```robot
[Tags]    Teste01
[Tags]    Teste02
[Tags]    Teste03
```

---

### 5.2 Tags de Categoria

**Padrão:**
```
<Categoria>
```

**Exemplos:**
```robot
[Tags]    Smoke
[Tags]    Regression
[Tags]    Acceptance
[Tags]    OrdemServico
```

---

## 6. Nomenclatura de Módulos

### 6.1 Estrutura de Diretórios

**Padrão:**
```
<Módulo>/<SubMódulo>/
```

**Exemplos:**
```
✅ Comercial/Condicional/
✅ Comercial/OrdemDeServico/
✅ Financeiro/Comissoes/
✅ Emissao/Carregamento/Venda/

❌ comercial/Condicional/     (minúsculo)
❌ Comercial/condicional/     (minúsculo)
❌ Comercial/Condicional/     (espaço)
```

---

## 7. Regras Gerais

### 7.1 CamelCase

Use CamelCase para:
- Nomes de arquivos (`KeyNome1.robot`)
- Nomes de variáveis (`${TELA_Vendas}`)
- Nomes de keywords (`Dado que Acesso`)

### 7.2 snake_case

Use snake_case para:
- Variáveis em Python
- Nomes de arquivos de biblioteca Python

### 7.3 Não Use

- Acentuação em nomes de arquivos
- Caracteres especiais (ç, ã, etc.)
- Espaços em nomes de arquivos
- Underscore em nomes de variáveis Robot (exceto em Python)

---

## 8. Checklist de Validação

Antes de criar um novo arquivo, verifique:

- [ ] Nome do arquivo segue o padrão (`Key<Nome>N.robot` / `Teste_<Nome>N.robot`)?
- [ ] Imagens têm o prefixo correto (`tela_`, `bt_`, `input_`, etc.)?
- [ ] Variáveis de imagem usam `${}`?
- [ ] Keywords estão em BDD português?
- [ ] Tags estão em sequencial (`Teste01`, `Teste02`, etc.)?
- [ ] Caminhos relativos estão corretos?

---

## 9. Referências

- `docs/ESTRUTURA_TESTES.md` — Estrutura completa dos testes
- `.opencode/skills/padroes-desenvolvimento/SKILL.md` — Padrões de desenvolvimento