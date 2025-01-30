*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    variables.robot

*** Keywords ***
# USUÁRIO EMAIL INVÁLIDO 
Dado que eu tenho um payload com email inválido
    ${payload}=    Create Dictionary    email=invalid@example.com    password=123456
    Set Test Variable    ${payload}

Quando eu envio uma requisição POST para /login com email inválido
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${API_URL}/login    json=${payload}    headers=${headers}    expected_status=any
    Set Test Variable    ${response}

Então a resposta deve ter status 401
    Should Be Equal As Strings    ${response.status_code}    401

E o corpo da resposta deve conter a mensagem "Email e/ou senha inválidos"
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${response_body}    message    Email e/ou senha inválidos


# USUÁRIO VÁLIDO
Dado que eu tenho um payload válido para login
    ${payload}=    Create Dictionary    email=fulano@example.com    password=123456
    Set Test Variable    ${payload}

Quando eu envio uma requisição POST para /login com credenciais válidas
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${API_URL}/login    json=${payload}    headers=${headers}    expected_status=any
    Set Test Variable    ${response}

Então a resposta deve ter status 200
    Should Be Equal As Strings    ${response.status_code}    200

E o corpo da resposta deve conter o token de autenticação
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_body}    authorization

    # Extração do token de autenticação
    ${token}=    Get From Dictionary    ${response_body}    authorization
    Set Test Variable    ${token}
    Log    "Token de autenticação: ${token}"

# USUÁRIO SENHA INCORRETA
Dado que eu tenho um payload com senha inválida
    ${payload}=    Create Dictionary    email=fulano@example.com    password=senha_invalida
    Set Suite Variable    ${payload}

Quando eu envio uma requisição POST para /login
    Create Session    serverest    ${API_URL}
    ${response}=    POST On Session    serverest    /login    json=${payload}    expected_status=401
    Set Suite Variable    ${response}

Então a resposta deve ter um status 401
    Should Be Equal As Strings    ${response.status_code}    401

E o corpo da resposta deve conter uma mensagem "Email e/ou senha inválidos"
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_body}    message
    Should Be Equal As Strings    ${response_body['message']}    Email e/ou senha inválidos

# ---------------------------------------------------------------------------------------------------- 


# CADASTRO DE USUÁRIO

Dado que faço uma requisição POST para "/usuarios" com os dados válidos
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=fulano@example.com
    ...    password=123456
    ...    administrador=true
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${API_URL}/usuarios    json=${payload}    headers=${headers}    expected_status=any
    Set Test Variable    ${response}

Então o status code deve ser 201
    Should Be Equal As Strings    ${response.status_code}    201

E a resposta deve conter a mensagem "Cadastro realizado com sucesso"
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${response_body}    message    Cadastro realizado com sucesso