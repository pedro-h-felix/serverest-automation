*** Settings ***
Resource    ../resources/api_resources_users.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Cadastrar um novo usuário
    [Documentation]    Testa o cenário de cadastro de um novo usuário com dados válidos
    Dado que faço uma requisição POST para "/usuarios" com os dados válidos
    Então o status code deve ser 201
    E a resposta deve conter a mensagem "Cadastro realizado com sucesso"
   

Buscar Usuário por ID
    [Documentation]    Testa a busca de um usuário por ID
    [Tags]    api     usuarios
    Criar Sessão API 
    ${response}    Buscar Usuário    ${USER_ID}

    # Validar o status da resposta
    Should Be Equal As Numbers    ${response.status_code}    200
    
    # Verificar se o body da resposta contem os dados esperados
    ${json}    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    _id
    Dictionary Should Contain Key    ${json}    nome
    Dictionary Should Contain Key    ${json}    email
    Should Be Equal    ${json}[_id]    ${USER_ID}
    

Deletar usuário
    [Documentation]      Valida se um usuário pode ser deletado por ID 
    [Tags]    api     usuarios

    Criar Sessão API
    ${token}    Login API    ${EMAIL}    ${PASSWORD}
    Should Not Be Equal    ${token}    None    Falha ao autenticar
    
    ${response}    Buscar Usuário    ${USER_ID}
    Should Be Equal As Numbers    ${response.status_code}    200    Usuário não encontrado

    ${response}    Deletar Usuário    ${USER_ID}
    Should Contain    ${response.status_code}    200    204

    # Validar se a resposta indica sucesso
    ${json}    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}   message 
    Dictionary Should Contain Key    ${json}[message]    Registro excluído com sucesso