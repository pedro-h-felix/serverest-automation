*** Settings ***
Resource    variables.robot
Library    SeleniumLibrary

*** Keywords ***
# LOGIN VALIDO
Abrir Navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    ServeRest    timeout=5s

Preencher Credenciais
    [Arguments]    ${email}    ${senha}
    Input Text    xpath=//input[@data-testid='email']    ${VALID_EMAIL}
    Input Text    xpath=//input[@data-testid='senha']    ${VALID_PASSWORD}

Clicar em Entrar
    Click Button    xpath=//button[@data-testid='entrar']
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Bem Vindo ')]    timeout=2s

Validar Login Com Sucesso
    Element Should Be Visible    xpath=//h1[contains(text(), 'Bem Vindo ')] 

Fechar Navegador
    Close Browser

# LOGIN INVALIDO
Preencher Credenciais com ERRO
    [Arguments]    ${EMAIL_INVALIDO}    ${VALID_PASSWORD}
    Input Text    xpath=//input[@data-testid='email']    ${EMAIL_INVALIDO}
    Input Text    xpath=//input[@data-testid='senha']    ${VALID_PASSWORD}

Clicar em Entrar com ERRO
    Click Button    xpath=//button[@data-testid='entrar']
    

Validar Mensagem de ERRO
    Wait Until Element Is Visible    xpath=//span[contains(text(), 'Email e/ou senha inválidos')]    timeout=10s
    Element Should Contain    xpath=//span[contains(text(), 'Email e/ou senha inválidos')]    Email e/ou senha inválidos

# SENHA COM INVÁLIDA

Preencher senha com ERRO
    [Arguments]    ${VALID_EMAIL}    ${SENHA}
    Input Text    xpath=//input[@data-testid='email']    ${VALID_EMAIL}
    Input Text    xpath=//input[@data-testid='senha']    ${SENHA}