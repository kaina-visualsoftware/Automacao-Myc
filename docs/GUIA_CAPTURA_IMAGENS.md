# Guia de Captura de Imagens — SikuliLibrary

Este documento descreve como capturar e nomear corretamente as imagens para o reconhecimento visual no myCommerce.

---

## 1. O que é SikuliLibrary?

SikuliLibrary é uma biblioteca de automação que usa **reconhecimento visual de imagens** para encontrar e interagir com elementos na tela. Em vez de procurar elementos por XPath ou selectors (como em automação web), o Sikuli procura por **imagens .png** na tela.

---

## 2. Como Capturar Imagens

### Ferramenta de Captura

Use **Win + Shift + S** (Windows Snipping Tool) ou qualquer ferramenta de captura de tela.

### Resolução

- **Recomendada**: 1920x1080 (full HD)
- Todas as imagens devem ser capturadas na **mesma resolução** em que os testes serão executados
- Se a resolução mudar, as imagens podem não ser reconhecidas

### Princípio Fundamental

**Capture o menor recorte possível** que identifique o elemento exclusivamente.

---

## 3. Prefixos de Nomenclatura

Use os seguintes prefixos para nomear suas imagens:

| Prefixo | Uso | Exemplo |
|---------|-----|---------|
| `${TELA_}` | Telas/janelas (barra de título) | `${TELA_OS}` = `tela_OrdemServico.png` |
| `${BT_}` | Botões | `${BT_ADICIONAR}` = `bt_Adicionar.png` |
| `${BTN_}` | Botões (alternativo) | `${BTN_SALVAR}` = `btn_Salvar.png` |
| `${INPUT_}` | Campos de entrada | `${INPUT_CPF}` = `input_CPF.png` |
| `${LB_}` | Labels/rótulos | `${LB_CLIENTE}` = `lb_Cliente.png` |
| `${AVISO_}` | Avisos/alertas | `${AVISO_ERRO}` = `aviso_Erro.png` |
| `${MODAL_}` | Modais/popups | `${MODAL_CONFIRMAR}` = `modal_Confirmar.png` |
| `${ROW_}` | Linhas de grid | `${ROW_ITEM}` = `row_Item.png` |
| `${ABA_}` | Abas | `${ABA_DADOS}` = `aba_Dados.png` |
| `${ICONE_}` | Ícones | `${ICONE_SALVAR}` = `icone_Salvar.png` |

---

## 4. Regras de Captura

### ✅ Faça

- Capture **apenas a área necessária** do elemento
- Use elementos **estáticos** (títulos, labels, ícones fixos)
- Use cores distintas para diferenciação
- Capture em PNG com fundo transparente quando possível

### ❌ Não Faça

- **Não capture campos com valores variáveis** (CPF, nome, preço)
- **Não capture grids com dados variáveis**
- **Não capture整个 telas inteiras** (muito lento para reconhecimento)
- **Não use JPG** — sempre use PNG
- **Não use elementos muito pequenos** (risco de falsos positivos)

---

## 5. Exemplos por Tipo de Elemento

### 5.1 Tela (TELA_)

Capture apenas a **barra de título** da janela:

```
┌─────────────────────────────────────────┐
│ Ordem de Serviço          [—] [□] [X]  │  ← Capture esta área
├─────────────────────────────────────────┤
│                                         │
│         (restante da tela)              │
└─────────────────────────────────────────┘

Arquivo: tela_OrdemServico.png
```

### 5.2 Botão (BT_)

Capture o botão **inteiro com bordas**:

```
┌──────────────────┐
│     Gravar       │  ← Capture o botão inteiro
└──────────────────┘

Arquivo: bt_Gravar.png
```

### 5.3 Label (LB_)

Capture o texto **fixo** ao lado do campo:

```
┌────────────────────────┐
│ Cliente: [________]    │  ← Capture "Cliente:"
└────────────────────────┘

Arquivo: lb_Cliente.png
```

### 5.4 Input (INPUT_)

Capture uma **região pequena** ao redor do campo:

```
┌────────────────────────┐
│ CPF: [12345678901   ]  │  ← Capture área do campo
└────────────────────────┘

Arquivo: input_CPF.png
```

### 5.5 Aviso (AVISO_)

Capture o **texto completo** do aviso:

```
┌─────────────────────────┐
│ ⚠ Cliente não encontrado │  ← Capture todo o aviso
└─────────────────────────┘

Arquivo: aviso_ClienteNaoEncontrado.png
```

---

## 6. Localização das Imagens

### Diretório Principal

Todas as imagens devem ser salvas em:

```
Testes_BancoAleatorio/images/
```

**IMPORTANTE**: Não crie subpastas dentro de `images/`. Todas as imagens ficam em um único diretório.

### Referência nos Arquivos

No arquivo de Keywords, referencie as imagens assim:

```robot
*** Variables ***
${IMAGENS}    ./Testes_BancoAleatorio/images
${TELA_OS}    tela_OrdemServico.png
${BT_ADICIONAR}    bt_Adicionar.png
```

---

## 7. Testando as Imagens

### Comando de Teste

Para testar se uma imagem é reconhecida:

```robot
*** Test Cases ***
Teste de Imagem
    Add Image Path    ${IMAGENS}
    Wait Until Screen Contain    ${TELA_OS}    10
    Screen Should Contain    ${BT_ADICIONAR}
```

### Ajuste de Similiaridade

Se a imagem não está sendo reconhecida, você pode ajustar a similaridade:

```robot
# Padrão: 80% de similaridade
Set Similarity    0.8
Wait Until Screen Contain    ${IMAGEM}    10
```

---

## 8. Problemas Comuns

### Imagem não é reconhecida

| Causa | Solução |
|-------|---------|
| Captura muito grande | Reduza a área de captura |
| Captura com fundo variável | Use parte do elemento sem fundo |
| Resolução diferente | Capture na mesma resolução (1920x1080) |
| Elemento muito pequeno | Capture uma área maior ao redor |

### Clica no lugar errado

| Causa | Solução |
|-------|---------|
| imagem não é única | Use uma parte mais distintiva |
| Elementos muito similares | Adicione mais contexto à imagem |

### Timeout em Wait Until Screen Contain

| Causa | Solução |
|-------|---------|
| Tela ainda não carregou | Aumente o timeout |
| Imagem incorreta | Verifique a imagem capturada |
| Popup bloqueando | Trate o popup antes de continuar |

---

## 9. Checklist de Imagem

Antes de usar uma imagem nos testes, verifique:

- [ ] A imagem é um arquivo `.png`?
- [ ] O nome segue o prefixo correto (`TELA_`, `BT_`, etc.)?
- [ ] A captura tem o menor tamanho possível?
- [ ] A captura não tem valores variáveis?
- [ ] A imagem está no diretório `images/` (sem subpastas)?
- [ ] A imagem foi testada e funciona na resolução 1920x1080?

---

## 10. Referências

- [Documentação SikuliLibrary](https://sikulix.github.io/docs/)
- [SikuliX Quickstart](https://sikulix-2014.readthedocs.io/en/latest/quickstart.html)