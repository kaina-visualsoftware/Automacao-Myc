# Troubleshooting — Guia de Problemas Comuns

Este documento lista os problemas mais comuns encontrados nos testes de automação e suas soluções.

---

## 1. Problemas de Imagem (Sikuli)

### 1.1 "Image not found" / Timeout em Wait Until Screen Contain

**Sintoma:**
```
Timeout: Image 'tela_xxx.png' not found in screen
```

**Causas possíveis:**
- Imagem capturada em resolução diferente
- Elemento ainda não apareceu na tela
- Popup bloqueando a visualização

**Soluções:**
1. **Verificar resolução**: Use 1920x1080 para capturar e executar
2. **Aumentar timeout**: Mude de 10 para 25 segundos
3. **Re-capturar imagem**: Capture novamente o elemento
4. **Verificar popup**: Trate popups antes de buscar a imagem

```robot
# Exemplo de timeout maior
Wait Until Screen Contain    ${TELA_OS}    25
```

---

### 1.2 Clica no lugar errado

**Sintoma:**
- O teste clica, mas no elemento errado
- O teste segue o fluxo mas não encontra o próximo elemento

**Causas possíveis:**
- Imagem não é única (existe em outro lugar da tela)
- Captura muito grande, incluindo elementos próximos

**Soluções:**
1. **Reduza a área de captura**: Use o menor recorte possível
2. **Use elemento mais distinto**: Escolha parte única do elemento
3. **Adicione contexto**: Capture uma área um pouco maior

---

### 1.3 Imagem funciona no teste A mas não no teste B

**Sintoma:**
- A mesma imagem funciona em um teste, falha em outro

**Causas possíveis:**
- Ordem de carregamento diferente
- Popup ou modal diferente antes da ação
- Resolução diferente

**Soluções:**
1. **Adicione verificação anterior**: Aguarde elemento anterior antes
2. **Trate popups**: Adicione verificação de popups entre operações
3. **Use same screen**: Verifique se está na mesma tela

---

## 2. Problemas de Banco de Dados

### 2.1 "Connection refused" ao conectar no banco

**Sintoma:**
```
ConnectionError: Connection refused
```

**Causas possíveis:**
- MySQL não está rodando
- Porta incorreta
- IP do servidor errado

**Soluções:**
1. **Verificar MySQL**: `net start mysql` ou `services.msc`
2. **Verificar porta**: Confirme a porta no arquivo de configuração
3. **Verificar IP**: Confirme o IP do servidor no Config.ini

---

### 2.2 Query retorna vazio

**Sintoma:**
```
Query returned no rows
```

**Causas possíveis:**
- Dados não existem no banco
- Filtro errado na query
- Banco de dados errado

**Soluções:**
1. **Execute a query manualmente** no MySQL Workbench
2. **Verifique os filtros** WHERE da query
3. **Verifique se é o banco certo** (produção vs homologação)

---

### 2.3 "Access denied" ao conectar

**Sintoma:**
```
Access denied for user 'root'@'localhost'
```

**Causas possíveis:**
- Usuário ou senha errados
- Usuário sem permissão

**Soluções:**
1. **Verifique credentials** no arquivo de configuração
2. **Verifique permissões** do usuário no MySQL

---

## 3. Problemas de Execução

### 3.1 "python is not recognized as an internal or external command"

**Sintoma:**
```
'python' is not recognized
```

**Causas possíveis:**
- Python não está no PATH
- Python não foi instalado para todos os usuários

**Soluções:**
1. **Verificar instalação**: `where python`
2. **Adicionar ao PATH**: Instale o Python marcando "Add to PATH"
3. **Reinicie o terminal** após instalação

---

### 3.2 "robot is not recognized as an internal or external command"

**Sintoma:**
```
'robot' is not recognized
```

**Causas possíveis:**
- Robot Framework não foi instalado

**Soluções:**
```powershell
pip install robotframework
```

---

### 3.3 "Java is not recognized as an internal or external command"

**Sintoma:**
```
'java' is not recognized
```

**Causas possíveis:**
- Java não está instalado
- JAVA_HOME não está configurado

**Soluções:**
1. **Instale o JDK**: Baixe e instale JDK 8+
2. **Configure JAVA_HOME**: Adicione às variáveis de sistema
3. **Reinicie o terminal**

---

## 4. Problemas de Login

### 4.1 Login não funciona

**Sintoma:**
- O teste faz login mas o sistema não reconhece

**Causas possíveis:**
- Credenciais incorretas
- Usuário sem acesso ao módulo
- Banco de dados diferente

**Soluções:**
1. **Execute manualmente** o login para confirmar
2. **Verifique as credenciais** no arquivo de configuração
3. **Verifique permissões** do usuário no myCommerce

---

### 4.2 "Start Sikuli Process" falha

**Sintoma:**
```
Start Sikuli Process    FAILED
```

**Causas possíveis:**
- Java não está configurado
- SikuliLibrary não está instalada

**Soluções:**
1. **Verifique Java**: `java -version`
2. **Verifique SikuliLibrary**: `pip list | Select-String sikuli`
3. **Verifique JAVA_HOME**: `echo $env:JAVA_HOME`

---

## 5. Problemas de Timing

### 5.1 Ação executada antes do tempo

**Sintoma:**
- O sistema ainda estava processando
- O elemento não estava pronto

**Soluções:**
1. **Adicione Sleep antes** da ação:
```robot
Sleep    ${SLEEP_BAIXO}
Click    ${BTN_SALVAR}
```

2. **Use Wait Until** após navegação:
```robot
Wait Until Screen Contain    ${TELA_NOVA}    ${TEMPO_TELA}
```

---

### 5.2 Campo não aceita digitação

**Sintoma:**
- Input Text não funciona
- O texto aparece em outro campo

**Causas possíveis:**
- Campo não está em foco
- Campo está desabilitado

**Soluções:**
1. **Clique no campo** antes de digitar:
```robot
Click    ${INPUT_CAMPO}
Input Text    ${EMPTY}    texto
```

2. **Use Double Click** para focar:
```robot
Double Click    ${INPUT_CAMPO}
Input Text    ${EMPTY}    texto
```

---

## 6. Problemas de Popup

### 6.1 Popup inesperado bloqueia execução

**Sintoma:**
- Teste falha ao aparecer popup não esperado
- Mensagem de erro não tratada

**Soluções:**
1. **Use keywords de validação de aviso**:
```robot
validacaoAviso.Verifica avisos presentes ao incluir cliente
```

2. **Adicione tratamento** antes de cada ação crítica:
```robot
Run Keyword And Continue On Failure    validacaoAviso.TratarAvisos
```

---

### 6.2 Popup de senha de supervisor

**Sintoma:**
- Sistema pede senha ao excluir/alterar
- Teste não trata a solicitação

**Soluções:**
1. **Use a keyword pronta**:
```robot
Valida solicitação de senha do usuário supervisor
```

2. **Adicione no fluxo** onde necessário:
```robot
Quando excluo o item
    Press Combination    KEY.ALT    KEY.X
    Wait Until Screen Contain    ${AVISO_CONFIRMAR}
    Press Combination    KEY.ALT    KEY.S
    Valida solicitação de senha do usuário supervisor
```

---

## 7. Problemas de Variáveis

### 7.1 Variável não recebe valor

**Sintoma:**
- A variável está vazia ou ${NONE}
- Query não retornou dados

**Soluções:**
1. **Verifique a query** no debug:
```robot
Log    ${resultado}
```

2. **Use Set Test Variable** para garantir escopo:
```robot
${codigo}    Set Variable    ${resultado[0][0]}
Set Test Variable    ${CODIGO}    ${codigo}
```

---

### 7.2 Caminho relativo errado

**Sintoma:**
- Resource não encontrado
- Arquivo não encontrado

**Soluções:**
1. **Verifique o nível do diretório**:
```
../../../utils/utils.robot  (3 níveis acima)
../../utils/utils.robot    (2 níveis acima)
```

2. **Ajuste o caminho** conforme a profundidade do arquivo

---

## 8. Problemas de Execução em Suite

### 8.1 Primeiro teste passa, segundo falha

**Sintoma:**
- O login funciona no primeiro teste
- O segundo teste não encontra elementos

**Causas possíveis:**
- ERP foi fechado entre testes
- Sessão expirou

**Soluções:**
1. **Use o executor principal** `Executar_Automacao.py`
2. **Adicione tratamento** no Suite Teardown do teste seguinte

---

### 8.2 Teste falha e para toda a execução

**Sintoma:**
- Um teste falha e os seguintes não executam

**Soluções:**
1. **Use --continue-on-failure**:
```powershell
robot --continue-on-failure -d .\results\ .\TestsCases\...
```

2. **Ou use o executor principal** que já trata isso

---

## 9. Checklist de Debug

Quando um teste falhar, siga esta ordem:

1. [ ] **Leia o erro**: Qual keyword falhou?
2. [ ] **Identifique a tela**: Onde o teste estava?
3. [ ] **Verifique imagem**: A imagem existe e está correta?
4. [ ] **Teste manualmente**: O sistema ainda funciona assim?
5. [ ] **Verifique banco**: Os dados existem?
6. [ ] **Adicione logs**: Print variables para debug
7. [ ] **Isole o teste**: Execute apenas o teste que falhou

---

## 10. Comandos Úteis de Debug

### Verificar variáveis

```robot
Log    ${MINHA_VARIAVEL}
Log Many    ${VAR1}    ${VAR2}    ${VAR3}
```

### Verificar screen

```robot
Screen Should Contain    ${IMAGEM}
Run Keyword And Continue On Failure    Screen Should Not Contain    ${AVISO_ERRO}
```

### Testar query

```robot
${resultado}    Query    SELECT * FROM tabela WHERE condicao
Log    ${resultado}
Should Not Be Empty    ${resultado}
```

---

## 11. Contato e Suporte

Para problemas não listados:
1. Verifique a documentação em `.opencode/guides/`
2. Analise testes existentes do mesmo módulo
3. Execute o teste manualmente para reproduzir o erro
4. Documente o problema e a solução encontrada

---

## 12. Referências

- `.opencode/skills/padroes-desenvolvimento/SKILL.md` — Padrões do projeto
- `.opencode/guides/guia-desenvolvimento-manual.md` — Guia completo
- `docs/ATALHOS_MYCOMMERCE.md` — Atalhos do sistema