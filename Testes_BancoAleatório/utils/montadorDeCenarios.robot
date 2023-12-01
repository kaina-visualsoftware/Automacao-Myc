*** Settings ***
Resource    ../KeyWords/keyVendas1.robot

*** Variables ***

*** Keywords ***
Dado que realizo uma venda completa, com produto normal 
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda