*** Settings ***
Library    OperatingSystem
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py

Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# ── Caminhos ───────────────────────────────────────────────────────────────


# ── Telas ──────────────────────────────────────────────────────────────────
${MENU_CADASTRO}                            menu_Cadastro.png
${TELA_EMPRESAS}                            tela_Empresas.png


# ── Avisos ─────────────────────────────────────────────────────────────────


# ── Componentes ────────────────────────────────────────────────────────────


#── Arquivos ───────────────────────────────────────────────────


# ── Variáveis de Runtime ───────────────────────────────────────────────────


${CODIGO}                                ${EMPTY}
*** Keywords ***