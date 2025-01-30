*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    variables.robot

*** Keywords ***

# CADASTRO DE USUÁRIO
*** Keywords ***
Dado que faço uma requisição POST para "/usuarios" com os dados válidos
    ${payload}=    Create Dictionary
    ...    nome=Beltrano da Silva
    ...    email=beltrano@example.com
    ...    password=123456
    ...    administrador=true
    ${headers}=    Create Dictionary    Content-Type=application/json

    ${response}=    POST    ${API_URL}/usuarios    json=${payload}    headers=${headers}    expected_status=any

    Log    "Status Code: ${response.status_code}"
    Log    "Response Body: ${response.json()}"

    Set Test Variable    ${response}

Então o status code deve ser 201
    Should Be Equal As Strings    ${response.status_code}    201

E a resposta deve conter a mensagem "Cadastro realizado com sucesso"
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${response_body}    message    Cadastro realizado com sucesso

# BUSCAR USUARIO POR ID 

Criar Sessão API
    Create Session    servrest    ${API_URL}

Buscar Usuário
    [Arguments]    ${user_id}
    ${response}    GET On Session   servrest    /usuarios/${user_id}
    RETURN    ${response}


# EXCLUIR USUÁRIO POR ID

Login API
    [Arguments]    ${email}    ${senha}
    ${data}    Create Dictionary    email=${email}    password=${senha}
    ${response}    POST On Session    servrest    /login    json=${data}
    ${json}    Set Variable    ${response.json()}
    ${token}    Set Variable If    "${response.status_code}" == "200"    ${json}[authorization]    None
    Set Global Variable    ${TOKEN}    ${token}
    RETURN    ${token}

Deletar Usuário
    [Arguments]    ${user_id}
    ${headers}    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}    DELETE On Session    servrest    /usuarios/${user_id}    headers=${headers}
    RETURN    ${response}