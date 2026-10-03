# Tela de cadastro eba 

A implementar (na issue):
- Deploy executado com sucesso localmente
- É possível realizar o auto-cadastro na interface
- Os dados do cliente são inseridos no banco de dados
- A tela segue exatamente o que foi especificado no protótipo (US01.01)
- Stack foi utilizada (Back-end: Node.js, Nest.js, GraphQL, SQL (PostgreSQL), TypeScript; Front-end Mobile: Dart, Flutter; Front-end Web: React.js, HTML, CSS, TypeScript

A implementar (US01):
- Verificação do email de usuário
- Botão "Cadastrar" -> abre tela de cadastro (acho que é só essa?)
- Campos -> botão "Finalizar Cadastro"
- Validação dos campos (fronte end e backend e banco de dados? não sei)
- quando uma regra é violada, o cursor vai pro campo que foi mal preenchido
- se deu certo -> mensagem "Cadastro realizado com sucesso"
- fecha tela de cadastro e abre a de login

Regras de Validação
- Nome de usuário 100 char alfanum
- email 250 char válido como email (procurar regex para validação) alfanum
- senha campo ofuscado(***) 50 char alfanum (procurar algo sobre como armazenar a senha...)
- endereço 250 char alfanum

- deve seguir as cores da logo do projeto
- no bd deve ser gravado somente um hash da senha
