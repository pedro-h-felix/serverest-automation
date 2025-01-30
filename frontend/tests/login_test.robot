*** Settings ***
Resource    ../resources/frontend_login_resources.robot
Resource    ../resources/variables.robot

*** Test Cases ***
Login Com Credenciais Válidas
    [Documentation]    Testa se o login ocorre corretamente com credenciais válidas.
    [Tags]    login    frontend
    Abrir Navegador
    Preencher Credenciais    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Clicar em Entrar
    Validar Login Com Sucesso
    Fechar Navegador

Login Com Email Inválido
    [Documentation]    Testa se o login falha ao utilizar um email inválido.
    [Tags]    login    frontend
    Abrir Navegador
    Preencher Credenciais com ERRO   ${EMAIL_INVALIDO}    ${VALID_PASSWORD}
    Clicar em Entrar com ERRO
    Validar Mensagem de ERRO
    Fechar Navegador

Login com senha inválida
    [Documentation]    Testa se o login falha ao utilizar uma senha inválida.
    [Tags]    login    frontend
    Abrir Navegador
    Preencher senha com ERRO   ${VALID_EMAIL}    ${SENHA}
    Clicar em Entrar com ERRO
    Validar Mensagem de ERRO
    Fechar Navegador