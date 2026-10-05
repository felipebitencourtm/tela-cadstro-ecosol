import 'package:flutter/material.dart';
import '../../../core/validators/validators.dart'; 

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscure = false,
    this.multiline = false,
  });

  final TextEditingController controller;
  final String hint;
  final Validator validator;
  final bool obscure;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      maxLines: multiline ? null : 1,
      expands: multiline,
      textAlignVertical: multiline ? TextAlignVertical.top : null,
      decoration: InputDecoration(hintText: hint),
    );

    return multiline
        ? SizedBox(height: 160, child: field)
        : field;
  }
}