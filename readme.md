## Olá! Esse é o projeto de automação Desktop criado pelo Jaime Junior <a href="https://github.com/vs-cqp/SikuliProject"><img src="https://user-images.githubusercontent.com/29931326/125177555-2e78db00-e1b3-11eb-9e49-409c4f649cf5.gif" width="30px">

___
# SikuliProject
Projeto de automação Desktop usando Robot Framework com SikuliLibrary
___
## Tecnologias utilizadas
[![Python](https://skills.thijs.gg/icons?i=py)](https://pt.wikipedia.org/wiki/Python)
[![RobotFramework](https://user-images.githubusercontent.com/93720316/199823510-321d8a8d-8d1a-47ef-aed7-bfe270ba2871.png)](https://pt.wikipedia.org/wiki/RobotFramework)
[![Vscode](https://user-images.githubusercontent.com/93720316/199822711-919922e2-2249-477f-9a68-0e81db260666.png)](https://pt.wikipedia.org/wiki/Vscode)
[![Git](https://skills.thijs.gg/icons?i=git)](https://pt.wikipedia.org/wiki/Git)
[![Java](https://user-images.githubusercontent.com/95437662/206203569-2b5766da-09ab-4784-a347-76e409c83779.png)](https://pt.wikipedia.org/wiki/Java_(linguagem_de_programação))

___
## Requisitos
Para rodar os testes automatizados é necessário:
* Vscode
* Python 3.9.13 ou superior
* Robotframework==5.0.1
* Robotframework-SikuliLibrary==2.0.3
* Robotframework-imagehorizonlibrary==1.0
* Robotframework-faker==5.0.0
* Robotframework-databaselibrary==1.2.4
___
### Instalando o Python :smiley:
Instalar o **Python** para Windows e incluí-lo ao path na hora da instalação. 

**OBSERVAÇÃO**:
> Caso não seja feito na hora da instalação, basta adicionar depois indo nas variáveis de ambiente 
___
### Instalando o Robot Framework :smiley:
<code style="color : black">> pip install robotframework </code>
___
### Instalando a SikuliLibrary :smiley:
<code style="color : black">> pip install robotframework-SikuliLibrary </code>
___
### Instalando a ImageHorizonLibrary :relaxed:
<code style="color : black">> pip install robotframework-imagehorizonlibrary </code>
___
### Instalando a FakerLibrary :relaxed:
<code style="color : black">> pip install robotframework-faker </code>
___
### Instalando a DatabaseLibrary :relaxed:
<code style="color : black">> pip install robotframework-databaselibrary </code>



## Como rodar os testes
Os testes estão divididos por **pastas**, e, dentro dessas pastas, tem o(s) arquivo(s) relacionado(s) àquele teste. Siga os seguintes comandos:
* Entre na pasta que está com os testes por meio do terminal do Visual Studio Code
* Vou utilizar a pasta **Comercial** como exemplo. Dentro dela, há várias outras pastas, mas tomaremos a pasta de condicional para executar os testes.
* Dentro de condicional há os arquivos condicional.robot e condicional1.robot. Vamos utilizar o primeiro
* No terminal digite:

<code style="color : black">> robot -d .\results\ .\Comercial\Condicional\condicional.robot </code>

Aperte ENTER

Para rodar somente um teste específico, basta usar uma tag da seguinte forma:

<code style="color : black">> robot -d .\results\ -i teste7 .\Comercial\Condicional\condicional.robot </code>

**OBSERVAÇÃO**: 
É necesário clicar na tela após pressionar ENTER ou o teste falhará

## Como proceder quando algum teste falhar?
* Primeiro, observar em que keyword deu a falha
* Segundo, verificar se é problema de imagem. Que imagem deveria ser exibida antes de chegar naquele ponto?
* Terceiro, isole o teste por meio de tags. Se foi o teste 7 que falhou, não é necessário rodar tudo de novo, mas sim do teste 7 em diante
* Em quarto lugar, faça o mesmo processo manualmente para checar se o problema ocorre ou não

## Como incluir mais testes?
* Se o teste em questão for de um novo menu que não seja abordado por nenhuma das pastas existentes, será necessário criar uma pasta com o nome do menu, e dentro dessa pasta colocar o nome do arquivo
* Por conseguinte, o nome do arquivo terá obrigatoriamente a extensão ".robot".
* A estrutura do arquivo seguirá o seguinte modelo:

> **Settings**

Nessa parte do arquivo é onde ficam as librarys e as suítes

> **Variables**

Nessa parte é onde ficam as variáveis. É possível colocar as variáveis em outras partes do código (inclusive em um arquivo em outra pasta), mas é necessário atentar-se ao fato de em algumas situações a variável acaba se tornando uma variável local e não uma que valha para o teste inteiro (o arquivo em questão)