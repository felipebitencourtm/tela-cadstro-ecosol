import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _address.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado com sucesso.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              AppTextField(
                controller: _username,
                hint: 'Ex: usuario123',
                validator: Validators.compose([
                  Validators.required('O nome de usuário é obrigatório.'),
                  Validators.maxLength(100, 'O nome de usuário deve ter no máximo 100 caracteres.'),
                ]),
              ),
              AppTextField(
                controller: _email,
                hint: 'nome@exemplo.com.br',
                validator: Validators.compose([
                  Validators.required('O e-mail é obrigatório.'),
                  Validators.email('Formato de e-mail inválido.'),
                  Validators.maxLength(250, 'O e-mail deve ter no máximo 250 caracteres.'),
                ]),
              ),
              AppTextField(
                controller: _password,
                hint: '********',
                validator: Validators.compose([
                  Validators.required('A senha é obrigatória.'),
                  Validators.maxLength(50, 'A senha deve ter no máximo 50 caracteres.'),
                ]),
                obscure: true,
              ),
              AppTextField(
                controller: _address,
                hint: 'Rua, Número, Complemento, Bairro',
                validator: Validators.compose([
                  Validators.required('O nome de usuário é obrigatório.'),
                  Validators.maxLength(250, 'O endereço deve ter no máximo 250 caracteres.'),
                ]),
                multiline: true,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('FINALIZAR CADASTRO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}