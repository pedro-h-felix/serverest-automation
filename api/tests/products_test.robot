*** Settings ***
Resource    ../resources/api_resources_products.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Login com Credenciais Válidas e Criação de Produto
    [Documentation]    Testa o cenário de login com credenciais válidas e cria um produto
    Dado que eu tenho um payload válido para login
    Quando eu envio uma requisição POST para /login com credenciais válidas
    Então a resposta deve ter status 200
    E o corpo da resposta deve conter o token de autenticação
    Dado que eu tenho um payload válido para criar um produto
    Quando eu envio uma requisição POST para /produtos
    Então a resposta deve ter status 201
    E o corpo da resposta deve conter a mensagem "Cadastro realizado com sucesso"


Buscar produto por ID
    [Documentation]    Busca o produto diretamente pelo ID
    Realizar Login e Armazenar Token
    Dado que eu tenho um ID de produto válido
    Quando eu envio uma requisição GET para /produtos/_id
    Então a resposta deve ter um status 200
    E o corpo da resposta deve conter os dados do produto

Deletar Produto
    [Documentation]    Testa a exclusão de um produto com ID válido
    E que eu estou autenticado na API
    Dado que eu tenho um ID de produto válido para deletar
    Quando eu envio uma requisição DELETE para /produtos/${PRODUTO_ID}
    Então a resposta deve ter status 200
    E o corpo da resposta deve conter a mensagem "Registro excluído com sucesso"