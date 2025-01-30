*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot

*** Keywords ***
Abrir Navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    ServeRest    timeout=5s

Fazer Login
    Input Text    xpath=//input[@data-testid='email']    ${VALID_EMAIL}
    Input Text    xpath=//input[@data-testid='senha']    ${VALID_PASSWORD}
    Click Button    xpath=//button[@data-testid='entrar']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Bem Vindo ')]    timeout=2s

Cadastrar Produto
    Click Element    xpath=//a[@data-testid='cadastrarProdutos']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Cadastro de Produtos')]    timeout=10s
    Preencher Formulario Produto
    Clicar Em Cadastrar

Preencher Formulario Produto
    Input Text    xpath=//input[@data-testid='nome']    ${NOME_PRODUTO}
    Input Text    xpath=//input[@data-testid='preco']    ${PRECO_PRODUTO}
    Input Text    xpath=//textarea[@data-testid='descricao']    ${DESCRICAO_PRODUTO}
    Input Text    xpath=//input[@data-testid='quantity']    ${QUANTIDADE_PRODUTO}

Clicar Em Cadastrar
    Click Button    xpath=//button[@data-testid='cadastarProdutos']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Lista dos Produtos')]    timeout=10s

Fechar Navegador
    Close Browser


# EXCLUIR PRODUTO 
Listar Produtos
    Click Element    xpath=//a[@data-testid='listarProdutos']    
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Lista dos Produtos')]    timeout=5s

Excluir Produto
    Wait Until Element Is Visible  xpath=//button[contains(text(),'Excluir')][1]  10s
    Click Element  xpath=//button[contains(text(),'Excluir')][1]   
    
    