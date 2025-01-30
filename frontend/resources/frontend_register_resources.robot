*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
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
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Bem Vindo ')]    timeout=10s

Acessar Tela De Cadastro
    Click Link    xpath=//a[@data-testid='cadastrarUsuarios']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Cadastro de usuários')]    timeout=10s

Preencher Cadastro
    ${nome}  FakerLibrary.Name
    ${email}  FakerLibrary.Email
    ${senha}  FakerLibrary.Password

    Input Text    xpath=//input[@data-testid='nome']    ${nome}
    Input Text    xpath=//input[@data-testid='email']    ${email}
    Input Text    xpath=//input[@data-testid='password']    ${senha}
    Click Button    xpath=//input[@data-testid='checkbox']    # Marcar checkbox 'administrador'
    Click Button    xpath=//button[@data-testid='cadastrarUsuario']

Confirmar Cadastro
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Lista dos usuários')]    timeout=5s
    Close Browser

Fechar Navegador
    Close Browser

# EXCLUIR USUÁRIO 

Acessar Tela De Listagem De Usuarios
    Click Link    xpath=//a[@data-testid='listarUsuarios']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Lista dos usuários')]    timeout=10s    

Excluir Primeiro Usuario
    Wait Until Element Is Visible  xpath=//button[contains(text(),'Excluir')][1]  10s
    Click Element  xpath=//button[contains(text(),'Excluir')][1]