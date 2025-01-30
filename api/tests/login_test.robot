*** Settings ***
Resource    ../resources/variables.robot
Resource    ../resources/api_resources_login.robot

*** Test Cases ***

Login com Email Inválido
    [Documentation]    Testa o cenário de login com um email inválido
    Dado que eu tenho um payload com email inválido
    Quando eu envio uma requisição POST para /login com email inválido
    Então a resposta deve ter status 401
    E o corpo da resposta deve conter a mensagem "Email e/ou senha inválidos"

Login com Credenciais Válidas
    [Documentation]    Testa o cenário de login com credenciais válidas
    Dado que eu tenho um payload válido para login
    Quando eu envio uma requisição POST para /login com credenciais válidas
    Então a resposta deve ter status 200
    E o corpo da resposta deve conter o token de autenticação

Login com Senha Inválida
    [Documentation]    Testa o cenário de login com uma senha inválida
    Dado que eu tenho um payload com senha inválida
    Quando eu envio uma requisição POST para /login
    Então a resposta deve ter um status 401
    E o corpo da resposta deve conter uma mensagem "Email e/ou senha inválidos"