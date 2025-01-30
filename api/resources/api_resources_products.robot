*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    SeleniumLibrary
Library    OperatingSystem
Resource    variables.robot

*** Keywords ***

# LOGIN 
Realizar Login e Armazenar Token
    [Documentation]    Realiza o login e armazena o token em uma variável de suite
    ${payload}=    Create Dictionary    email=fulano@example.com    password=123456
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${API_URL}/login    json=${payload}    headers=${headers}    expected_status=200
    ${token}=    Set Variable    ${response.json()["authorization"]}
    Set Suite Variable    ${token}  # Armazena o token em uma variável de suite

Dado que eu tenho um payload válido para login
    ${payload}=    Create Dictionary    email=fulano@example.com    password=123456
    Set Test Variable    ${payload}

Quando eu envio uma requisição POST para /login com credenciais válidas
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${API_URL}/login    json=${payload}    headers=${headers}    expected_status=200
    Set Test Variable    ${response}

Então a resposta deve ter status 200
    Status Should Be    200    ${response}

E o corpo da resposta deve conter o token de autenticação
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_body}    authorization
    ${token}=    Get From Dictionary    ${response_body}    authorization
    Should Not Be Empty    ${token}
    Set Test Variable    ${token}
    Log    Token de autenticação: ${token}

Dado que eu tenho um payload válido para criar um produto
    ${produto_payload}=    Create Dictionary    nome=JacaJamanta   preco=100.0    descricao=Produto de teste    quantidade=10
    Set Test Variable    ${produto_payload}

Quando eu envio uma requisição POST para /produtos
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${token}
    ${response}=    POST    ${API_URL}/produtos    json=${produto_payload}    headers=${headers}    expected_status=201
    Log    ${response.content}  # Exibe o corpo da resposta
    Log    ${response.status_code}  # Exibe o status code
    Set Test Variable    ${response}

Então a resposta deve ter status 201
    Status Should Be    201    ${response}

E o corpo da resposta deve conter a mensagem "Cadastro realizado com sucesso"
    ${response_body}=    ${response.json()}
    Log    ${response.content}
    Log    ${response.status_code}
    Dictionary Should Contain Key    ${response_body}    message
    Should Be Equal As Strings    ${response_body["message"]}    Cadastro realizado com sucesso

# VALIDAÇÃO DE ID

Dado que eu tenho um ID de produto válido
    [Documentation]    Define um ID de produto válido para a busca
    ${produto_id}=    Set Variable    12345  # Substitua por um ID válido ou obtenha dinamicamente
    Set Test Variable    ${produto_id}

Quando eu envio uma requisição GET para /produtos/_id
    [Documentation]    Envia uma requisição GET para buscar o produto pelo ID
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${token}
    ${response}=    GET    ${API_URL}/produtos/${produto_id}    headers=${headers}    expected_status=any
    Set Test Variable    ${response}

Então a resposta deve ter um status 200
    [Documentation]    Verifica se a resposta tem status code 200
    Log    Status Code Recebido: ${response.status_code}  # Exibe o status code da resposta
    Log    Corpo da Resposta: ${response.content}  # Exibe o corpo da resposta
    Log    Cabeçalhos da Resposta: ${response.headers}  # Exibe os cabeçalhos da resposta
    Should Be Equal As Strings    ${response.status_code}    200

E o corpo da resposta deve conter os dados do produto
    [Documentation]    Verifica se o corpo da resposta contém os dados do produto
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_body}    nome
    Dictionary Should Contain Key    ${response_body}    preco
    Dictionary Should Contain Key    ${response_body}    descricao
    Dictionary Should Contain Key    ${response_body}    quantidade
    Log    Dados do produto: ${response_body}


#  DELETAR PRODUTO

Dado que eu tenho um ID de produto válido para deletar
    [Documentation]    Pré-condição: Cria um produto e obtém seu ID
    Create Session    api    ${API_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${produto_data}=    Create Dictionary
    ...    nome=Produto Teste
    ...    preco=100
    ...    descricao=Descrição do produto teste
    ...    quantidade=10
    ${response}=    POST On Session    api    /produtos    json=${produto_data}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    ${PRODUTO_ID}=    Set Variable    ${response.json()["_id"]}
    Set Test Variable    ${PRODUTO_ID}    ${PRODUTO_ID}

E que eu estou autenticado na API
    [Documentation]    Autentica na API e obtém o token
    ${auth_data}=    Create Dictionary
    ...    email=${EMAIL}
    ...    password=${PASSWORD}
    ${response}=    POST On Session    api    /login    json=${auth_data}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${TOKEN}=    Set Variable    ${response.json()["authorization"]}
    Set Test Variable    ${TOKEN}    ${TOKEN}

Quando eu envio uma requisição DELETE para /produtos/${PRODUTO_ID}
    [Documentation]    Envia uma requisição DELETE para o endpoint de produtos
    ${headers}=    Create Dictionary
    ...    Authorization=${TOKEN}
    ...    Content-Type=application/json
    ${response}=    DELETE On Session    api    /produtos/${PRODUTO_ID}    headers=${headers}
    Set Test Variable    ${response}    ${response}    

E o corpo da resposta deve conter a mensagem "Registro excluído com sucesso"
    [Documentation]    Verifica se a mensagem de sucesso está no corpo da resposta
    ${response_body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_body}    message
    Should Be Equal As Strings    ${response_body["message"]}    Registro excluído com sucesso