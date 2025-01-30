*** Settings ***
Resource    ../resources/frontend_register_resources.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Cadastro De Usuario Com Sucesso
    [Documentation]    Criação de um novo usuário.
    [Tags]    usuario    frontend    cadastro
    Abrir Navegador
    Fazer Login
    Acessar Tela De Cadastro
    Preencher Cadastro
    Confirmar Cadastro
    Fechar Navegador

Listar E Excluir Primeiro Usuario
    [Documentation]    Listar e excluir o primeiro usuário da página.
    [Tags]    usuario    frontend    excluir
    Abrir Navegador
    Fazer Login
    Acessar Tela De Listagem De Usuarios
    Excluir Primeiro Usuario
    Fechar Navegador
