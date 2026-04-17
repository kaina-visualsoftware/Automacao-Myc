# Guia de Configuração do Servidor — Automação MyCommerce

Este documento descreve toda a configuração do ambiente no servidor Windows Server para que **múltiplos usuários** possam executar e desenvolver testes de automação.

---

## Visão Geral do Ambiente

| Item                  | Detalhe                                                        |
|-----------------------|----------------------------------------------------------------|
| **Sistema Operacional** | Windows Server                                               |
| **Projeto**           | `C:\Automacao\mycommerce-automacao`                            |
| **Python**            | 3.12 — deve ser instalado **para todos os usuários**           |
| **Java**              | JDK 25.0.2 — `C:\Program Files\Java\jdk-25.0.2`               |
| **IDE**               | VS Code com extensão **RobotCode** (`d-biehl.robotcode`)      |

---

## 1. Pré-requisitos do Sistema

### 1.1 Python (system-wide)

O Python **deve** estar instalado para todos os usuários do servidor, não apenas para um perfil.

**Como verificar:**
```powershell
where python
# Correto:   C:\Python312\python.exe  ou  C:\Program Files\Python312\python.exe
# Errado:    C:\Users\<usuario>\AppData\Local\Programs\Python\...  (per-user)
```

**Se estiver per-user, reinstalar:**
1. Baixar o instalador do Python 3.12 em https://www.python.org/downloads/
2. Executar **como Administrador**
3. Marcar **"Install for all users"**
4. Marcar **"Add Python to PATH"**
5. Caminho sugerido: `C:\Python312\`

> **Por que isso importa?** As dependências são instaladas diretamente no Python global. Se ele estiver no perfil de um usuário, os demais não conseguirão usá-lo.

### 1.2 Java (system-wide)

O Java é necessário para a **SikuliLibrary** (automação visual baseada em reconhecimento de imagem).

**Configuração atual:**
- Caminho: `C:\Program Files\Java\jdk-25.0.2`
- Variável de ambiente `JAVA_HOME`: configurada nas **Variáveis do Sistema** (acessível a todos)

**Como verificar:**
```powershell
java -version
echo $env:JAVA_HOME
# Deve retornar: C:\Program Files\Java\jdk-25.0.2
```

> Se `JAVA_HOME` estiver apenas nas variáveis de **usuário**, mova-a para as variáveis do **Sistema**.

### 1.3 Permissões da pasta do projeto

A pasta `C:\Automacao\` deve ter permissões adequadas:

| Grupo/Usuário | Permissão necessária                              |
|---------------|---------------------------------------------------|
| **Users**     | Ler & Executar, Listar conteúdo, Ler              |
| **Desenvolvedores** | Ler & Executar + **Modificar** (para criar testes) |
| **Administrators** | Controle Total                                  |

**Como configurar:**
1. Clique direito em `C:\Automacao\` → Propriedades → Segurança → Editar
2. Adicionar o grupo "Users" com permissões de leitura
3. Para quem for editar/criar testes, adicionar permissão de Escrita/Modificar

---

## 2. Dependências Python (requirements.txt)

As dependências do projeto estão centralizadas em `requirements.txt`:

| Pacote                                | Propósito                                                    |
|---------------------------------------|--------------------------------------------------------------|
| `robotframework`                      | Framework principal de automação de testes                   |
| `robotframework-sikulilibrary`        | Automação visual por reconhecimento de imagem (requer Java)  |
| `robotframework-imagehorizonlibrary`  | Automação visual complementar (baseada em PyAutoGUI)         |
| `robotframework-databaselibrary`      | Interação com banco de dados MySQL nos testes                |
| `mysql-connector-python`              | Driver MySQL (conector oficial Oracle)                       |
| `pymysql`                             | Driver MySQL alternativo (usado na conexão do DatabaseLibrary) |

### Libs que NÃO são necessárias (removidas)

| Pacote                              | Motivo da remoção                                    |
|-------------------------------------|------------------------------------------------------|
| `robotframework-faker`              | Não é utilizada em nenhum arquivo `.robot` do projeto |
| `robotframework-assertion-engine`   | Era dependência do faker — não necessária             |
| `pytest`                            | Não há testes pytest — os testes são Robot Framework  |

### Instalar/Atualizar dependências

Para instalar/atualizar as dependências após alterar o `requirements.txt`:
```powershell
cd C:\Automacao\mycommerce-automacao
pip install -r requirements.txt
```

Para fixar versões (caso alguma atualização quebre algo):
```
# Exemplo em requirements.txt:
robotframework==7.1
```

---

## 3. Configuração do VS Code

### 3.1 Extensões necessárias

Ao abrir o projeto no VS Code, ele sugerirá automaticamente as extensões recomendadas (configuradas em `.vscode/extensions.json`):

| Extensão                   | ID                      | Propósito                                   |
|----------------------------|-------------------------|---------------------------------------------|
| **RobotCode**              | `d-biehl.robotcode`    | Syntax highlighting, autocomplete, execução de testes Robot Framework |
| **Python**                 | `ms-python.python`     | Suporte a Python, interpretador, debugging  |

> **Nota:** A extensão antiga "Robot Framework Language Server" da Robocorp foi **descontinuada** e removida do Marketplace. A **RobotCode** é a substituta oficial e mantida ativamente.

### 3.2 Configurações do Workspace (.vscode/settings.json)

As configurações já estão definidas no projeto:

```json
{
    "python.defaultInterpreterPath": "python",
    "python.testing.unittestEnabled": false,
    "[robotframework]": {
        "editor.defaultFormatter": "d-biehl.robotcode"
    },
    "files.associations": {
        "*.robot": "robotframework",
        "*.resource": "robotframework"
    }
}
```

**O que cada configuração faz:**
- `python.defaultInterpreterPath` → usa o Python global do sistema
- `files.associations` → garante que arquivos `.robot` e `.resource` sejam reconhecidos com syntax highlighting
- `editor.defaultFormatter` → usa RobotCode para formatar arquivos Robot

### 3.3 Primeiro acesso de um novo usuário

1. Abrir VS Code
2. Abrir a pasta `C:\Automacao\mycommerce-automacao`
3. VS Code perguntará se deseja instalar as extensões recomendadas → **Sim**
4. Aguardar as extensões instalarem
5. Abrir um arquivo `.robot` → verificar se o syntax highlighting funciona (texto colorido)
6. No terminal integrado, verificar se o Python está funcionando:
   ```powershell
   python --version
   robot --version
   ```

---

## 4. Estrutura do Projeto

```
mycommerce-automacao/
├── .vscode/                       # Configurações do VS Code (versionado)
│   ├── settings.json              # Configurações do workspace
│   └── extensions.json            # Extensões recomendadas
├── requirements.txt               # Dependências Python do projeto
├── Executar_Automacao.py          # Script orquestrador (executa todos os testes)
├── readme.md                      # Documentação geral do projeto
│
├── Testes_BancoAleatorio/         # PASTA PRINCIPAL DOS TESTES
│   ├── images/                    # Imagens PNG para reconhecimento visual (Sikuli)
│   ├── libs/                      # Bibliotecas Python customizadas
│   │   ├── leituraConfig.py       # Lê Config.ini do MyCommerce
│   │   ├── estoque.py             # Validação de estoque
│   │   ├── validaComissoes.py     # Cálculos de comissão
│   │   ├── validaParametros.py    # Validação de parâmetros do sistema
│   │   ├── validaTelasIni.py      # Valida Telas.ini
│   │   └── verificacoesExtras.py  # Verificações auxiliares
│   ├── utils/                     # Keywords reutilizáveis comuns
│   │   ├── myCommerce.robot       # Abrir/fechar/login MyCommerce
│   │   ├── utils.robot            # Utilitários gerais de UI
│   │   ├── validacaoAviso.robot   # Validação de alertas
│   │   ├── montadorDeCenarios.robot
│   │   ├── parametros_pre_condicoes.robot
│   │   └── parametros_admin_sistema.robot
│   ├── KeyWords/                  # Keywords organizadas por módulo
│   │   ├── Comercial/             # Vendas, Condicional, Devolução, etc.
│   │   ├── Financeiro/            # Caixa, Comissões, Contas a Pagar
│   │   ├── Login/
│   │   └── ...
│   └── TestsCases/                # Casos de teste (mesma estrutura de módulos)
│       ├── Comercial/
│       ├── Financeiro/
│       ├── Login/
│       └── ...
│
├── copilot_agent/                 # Documentação e sistema de agentes IA
├── results/                       # Resultados de execuções anteriores
└── sikuli_captured/               # Prints capturados pelo Sikuli
```

---

## 5. Troubleshooting

### Arquivo .robot sem coloração/formatação
- Verifique se a extensão **RobotCode** está instalada
- Verifique se no canto inferior direito do VS Code aparece "Robot Framework" como linguagem

### `robot` não é reconhecido como comando
- Verifique se o robotframework foi instalado: `pip list | Select-String robot`
- Verifique se o Python está no PATH: `where python`

### Erro de Java ao executar testes com Sikuli
- Verifique: `java -version`
- Verifique: `echo $env:JAVA_HOME` → deve apontar para `C:\Program Files\Java\jdk-25.0.2`
- Se não funcionar, verifique se `JAVA_HOME` está nas variáveis do **Sistema** (não do usuário)

### Outro usuário não consegue executar testes
- Provavelmente o Python base está instalado per-user. Veja seção 1.1
- Verifique as permissões da pasta conforme seção 1.3

### Erro de permissão ao acessar o projeto
- Verifique as permissões da pasta `C:\Automacao\` conforme seção 1.3

---

## 6. Histórico de Configuração

| Data       | O que foi feito                                                              |
|------------|-----------------------------------------------------------------------------|
| 17/04/2026 | Criação do `requirements.txt` com as 6 dependências necessárias             |
| 17/04/2026 | Criação do `.vscode/extensions.json` (RobotCode + Python recomendadas)      |
| 17/04/2026 | Atualização do `.vscode/settings.json` (associação de `.robot`, RobotCode)  |
| 17/04/2026 | Atualização do `readme.md` (requisitos, instruções via venv)                |
| 17/04/2026 | Remoção das libs desnecessárias: faker, assertion-engine, pytest            |
| 17/04/2026 | Adição da `robotframework-databaselibrary` (usada em 19+ arquivos .robot)  |
| 17/04/2026 | Substituição da extensão descontinuada (Robocorp) pela RobotCode            |
| 17/04/2026 | Java configurado system-wide: `JAVA_HOME = C:\Program Files\Java\jdk-25.0.2` |

---

## Pendências

- [ ] Reinstalar Python **para todos os usuários** (atualmente está per-user em `C:\Users\Administrator\...`)
- [ ] Instalar dependências globalmente: `pip install -r requirements.txt`
- [ ] Verificar permissões de `C:\Automacao\` para o grupo "Users"
- [ ] Testar acesso com outro usuário do servidor (login + execução de teste)
