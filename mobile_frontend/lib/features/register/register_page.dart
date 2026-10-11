import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/validators/validators.dart';
import 'widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _address = TextEditingController();

  final String createUserMutation = """
    mutation CreateUser(\$createUserInput: CreateUserInput!) {
      createUser(createUserInput: \$createUserInput) {
        id
        username
        email
        address
      }
    }
  """;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ECOSOL DIGITAL')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Mutation(
          options: MutationOptions(
            document: gql(createUserMutation),
            onCompleted: (dynamic resultData) {
              print("Cadastro realizado com sucesso.");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cadastro realizado com sucesso.'),
                ),
              );
            },
            onError: (error) => {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Erro no registro de usuário.')),
              ),
            },
          ),
          builder: (RunMutation runMutation, QueryResult? result) {
            return Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  Text(
                    "Criar Conta",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        "Usuário",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTextField(
                        controller: _username,
                        hint: 'Ex: usuario123',
                        validator: Validators.compose([
                          Validators.required(
                            'O nome de usuário é obrigatório.',
                          ),
                          Validators.maxLength(
                            100,
                            'O nome de usuário deve ter no máximo 100 caracteres.',
                          ),
                        ]),
                      ),
                      Text(
                        "E-mail",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTextField(
                        controller: _email,
                        hint: 'nome@exemplo.com.br',
                        validator: Validators.compose([
                          Validators.required('O e-mail é obrigatório.'),
                          Validators.email('Formato de e-mail inválido.'),
                          Validators.maxLength(
                            250,
                            'O e-mail deve ter no máximo 250 caracteres.',
                          ),
                        ]),
                      ),
                      Text(
                        "Senha",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTextField(
                        controller: _password,
                        hint: '********',
                        validator: Validators.compose([
                          Validators.required('A senha é obrigatória.'),
                          Validators.maxLength(
                            50,
                            'A senha deve ter no máximo 50 caracteres.',
                          ),
                        ]),
                        obscure: true,
                      ),
                      Text(
                        "Endereço",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTextField(
                        controller: _address,
                        hint: 'Rua, Número, Complemento, Bairro',
                        validator: Validators.compose([
                          Validators.required('O endereço é obrigatório.'),
                          Validators.maxLength(
                            250,
                            'O endereço deve ter no máximo 250 caracteres.',
                          ),
                        ]),
                        multiline: true,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        runMutation({
                          "createUserInput": {
                            "username": _username.text,
                            "email": _email.text,
                            "address": _address.text,
                            "passwordHash": _password.text, // hash no backend
                          },
                        });
                      } // deu certo
                    },
                    child: const Text('FINALIZAR CADASTRO'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
