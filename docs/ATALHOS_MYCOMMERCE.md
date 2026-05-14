# Atalhos do myCommerce

Este documento lista todos os atalhos de teclado disponíveis no sistema myCommerce para uso nos testes de automação.

---

## 1. Atalhos de Navegação

| Atalho | Ação | Uso Comum |
|--------|------|------------|
| `F1` | Ajuda | Abrir help |
| `F2` | Tecla F2 | - |
| `F3` | Pesquisar | Pesquisar registros |
| `F4` | Tecla F4 | - |
| `F5` | Atualizar | Atualizar dados da tela |
| `F6` | Tecla F6 | - |
| `F7` | Tecla F7 | - |
| `F8` | Tecla F8 | - |
| `F9` | Tecla F9 | - |
| `F10` | Tecla F10 | - |
| `F11` | Fullscreen | Tela cheia |
| `F12` | Tecla F12 | - |
| `ESC` | Cancelar/Voltar | Cancelar operação ou retornar |
| `ENTER` | Confirmar | Confirmar seleção ou ação |
| `TAB` | Próximo Campo | Ir para o próximo campo |
| `SHIFT+TAB` | Campo Anterior | Voltar ao campo anterior |

---

## 2. Atalhos com ALT (Menu)

| Atalho | Ação |
|--------|------|
| `ALT + A` | Adicionar / Incluir |
| `ALT + E` | Editar / Alterar |
| `ALT + X` | Excluir / Apagar |
| `ALT + F` | Finalizar |
| `ALT + G` | Gravar / Gerar |
| `ALT + S` | Sim / Confirmar |
| `ALT + N` | Não / Cancelar |
| `ALT + D` | Detalhes |
| `ALT + U` | Visualizar / Ver |
| `ALT + V` | Venda Parcial |
| `ALT + R` | Retornar / Voltar |
| `ALT + I` | Incluir (alternativo) |
| `ALT + C` | Confirmar (alternativo) |
| `ALT + P` | Produto |
| `ALT + L` | Cliente |
| `ALT + O` | Ordem de Serviço |
| `ALT + B` | Botão |
| `ALT + M` | Mais opções |
| `ALT + K` | Atalho |

---

## 3. Atalhos por Módulo

### 3.1 Comercial

| Módulo | Atalho | Descrição |
|--------|--------|------------|
| Vendas | `F11` | Abre tela de vendas |
| Condicional | `F11` | Abre condicional |
| Ordem de Serviço | `F3`| Acesso via menu |
| Devolução | `F6` | Acesso via menu |
| Orçamento | `CTRL + O` | Acesso via menu |
| Doação | - | Acesso via menu |

### 3.2 Financeiro

| Módulo | Atalho | Descrição |
|--------|--------|------------|
| Caixa | - | Acesso via menu |
| Comissões | - | Acesso via menu |
| Contas a Pagar | - | Acesso via menu |
| Contas a Receber | - | Acesso via menu |

### 3.3 Emissão

| Módulo | Atalho | Descrição |
|--------|--------|------------|
| Nota Fiscal | - | Acesso via menu |
| Carregamento | - | Acesso via menu |
| Ordem de Entrega | - | Acesso via menu |

### 3.4 Cadastros

| Cadastro | Atalho | Descrição |
|----------|--------|------------|
| Clientes e Fornecedores | `F9` | Abre tela de clientes |
| Vendedores e Funcionários | - | Acesso via menu |
| Produtos | - | Acesso via menu |
| Serviços | - | Acesso via menu |

---

## 4. Atalhos em Grid

| Atalho | Ação |
|--------|------|
| `ENTER` | Confirmar seleção na linha |
| `SPACE` | Marcar/desmarcar item |
| `HOME` | Ir para primeira linha |
| `END` | Ir para última linha |
| `PAGE UP` | Página anterior |
| `PAGE DOWN` | Próxima página |
| `SETA CIMA` | Linha anterior |
| `SETA BAIXO` | Próxima linha |

---

## 5. Atalhos de Edição

| Atalho | Ação |
|--------|------|
| `CTRL + C` | Copiar |
| `CTRL + V` | Colar |
| `CTRL + X` | Recortar |
| `CTRL + Z` | Desfazer |
| `CTRL + Y` | Refazer |
| `CTRL + A` | Selecionar tudo |
| `DELETE` | Excluir caractere |
| `BACKSPACE` | Excluir caractere anterior |

---

## 6. Atalhos de Dados

### 6.1 CPF/CNPJ

Ao inserir CPF ou CNPJ:
- Digite apenas números (sem pontuação)
- O sistema formata automaticamente
- `ENTER` valida o documento

### 6.2 Valores Monetários

- Use ponto como separador decimal
- O sistema formata com vírgula automaticamente

### 6.3 Datas

- Use formato DD/MM/AAAA
- O sistema pode aceitar MM/AAAA

---

## 7. Atalhos em Campos de Pesquisa

### 7.1 Campo Código

| Ação | Comportamento |
|------|----------------|
| Digitar código + `ENTER` | Busca diretamente pelo código |
| Digitar código parcial + `ENTER` | Lista opções |
| `F3` | Abre pesquisa avançada |

### 7.2 Campo CPF/CNPJ

| Ação | Comportamento |
|------|----------------|
| Digitar CPF (11 dígitos) + `ENTER` | Busca cliente pelo CPF |
| Digitar CNPJ (14 dígitos) + `ENTER` | Busca cliente pelo CNPJ |
| CPF não encontrado | Exibe aviso |

---

## 8. Atalhos de Impressão

| Atalho | Ação |
|--------|------|
| `CTRL + P` | Imprimir |
| `CTRL + F` | Impressão rápida |

---

## 9. Uso nos Testes de Automação

Nos testes Robot Framework, use `ImageHorizonLibrary`:

```robot
# Pressionar tecla especial
Press Special Key    F11
Press Special Key    ENTER
Press Special Key    TAB

# Pressionar combinação
Press Combination    KEY.ALT    KEY.A    # Adicionar
Press Combination    KEY.ALT    KEY.G    # Gravar
Press Combination    KEY.ALT    KEY.F    # Finalizar
Press Combination    KEY.ALT    KEY.S    # Sim
Press Combination    KEY.ALT    KEY.X    # Excluir
```

---

## 10. Atalhos Mais Usados em Testes

| Prioridade | Atalho | Keyword no Robot |
|-----------|--------|------------------|
| 🔴 Alto | `ALT + A` | `Press Combination KEY.ALT KEY.A` |
| 🔴 Alto | `ALT + G` | `Press Combination KEY.ALT KEY.G` |
| 🔴 Alto | `ALT + S` | `Press Combination KEY.ALT KEY.S` |
| 🔴 Alto | `ALT + F` | `Press Combination KEY.ALT KEY.F` |
| 🟡 Médio | `F3` | `Press Special Key F3` |
| 🟡 Médio | `F5` | `Press Special Key F5` |
| 🟡 Médio | `ENTER` | `Press Special Key ENTER` |
| 🟢 Baixo | `ESC` | `Press Special Key ESC` |
| 🟢 Baixo | `TAB` | `Press Special Key TAB` |

---

## 11. Identificando Atalhos Desconhecidos

Para descobrir novos atalhos:

1. Observe a **letra sublinhada** nos menus e botões
2. A letra sublinhada = atalho `ALT + <LETRA>`
3. Teste manualmente no sistema
4. Documente o novo atalho encontrado

---

## 12. Referências

- Use sempre `ImageHorizonLibrary` para teclas
- Combine `Press Special Key` e `Press Combination` conforme necessário
- Teste os atalhos antes de usar nos casos de teste