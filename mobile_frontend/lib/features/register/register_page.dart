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
      body: Mutation(
        options: MutationOptions(
          document: gql(createUserMutation),
          onCompleted: (dynamic resultData) {
            if (resultData == null) {
              return;
            }

            print("Cadastro realizado com sucesso.");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro realizado com sucesso.')),
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
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            const Text(
                              "CRIAR\nCONTA",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                height: 0.95,
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 8,
                              endIndent: 325,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            const Text(
                              "NOME DE USUÁRIO",
                              style: TextStyle(
                                fontSize: 14,
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
                            const Text(
                              "E-MAIL",
                              style: TextStyle(
                                fontSize: 14,
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
                            const Text(
                              "SENHA",
                              style: TextStyle(
                                fontSize: 14,
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
                            const Text(
                              "ENDEREÇO",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppTextField(
                              controller: _address,
                              hint: 'Rua, Número, Complemento, Bairro',
                              validator: Validators.compose([
                                Validators.required(
                                  'O endereço é obrigatório.',
                                ),
                                Validators.maxLength(
                                  250,
                                  'O endereço deve ter no máximo 250 caracteres.',
                                ),
                              ]),
                              multiline: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  color: const Color(0xE2E2E2E2),
                  padding: EdgeInsets.only(
                    top: 40,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.paddingOf(context).bottom + 18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            runMutation({
                              "createUserInput": {
                                "username": _username.text,
                                "email": _email.text,
                                "address": _address.text,
                                "passwordHash":
                                    _password.text, // hash no backend
                              },
                            });
                          } // deu certo
                        },
                        child: const Text('FINALIZAR CADASTRO'),
                      ),
                      const SizedBox(height: 12),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PASSO 01/01", style: TextStyle(fontSize: 10)),
                          Text(
                            "STATUS: PENDENTE",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
