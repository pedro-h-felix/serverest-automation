*** Settings ***
Resource    ../resources/frontend_product_resources.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Cadastrar Novo Produto
    [Documentation]    Testa o processo de cadastro de um novo produto após login.
    [Tags]    produto    frontend    cadastro
    Abrir Navegador
    Fazer Login
    Cadastrar Produto
    Fechar Navegador

Excluir Produto
    [Documentation]    Testa o processo de excluir um produto da lista após login.
    [Tags]    produto    frontend    exclusao
    Abrir Navegador
    Fazer Login
    Listar Produtos
    Excluir Produto
    Fechar Navegador