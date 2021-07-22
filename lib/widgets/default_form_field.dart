import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String labelText;
  final Widget icon;
  final TextInputType? keyboardType;
  final bool obscure;
  final TextInputAction? action;
  final ValueChanged<String>? onSubmit;
  DefaultFormField({
    required this.validator,
    required this.controller,
    required this.icon,
    required this.labelText,
    this.keyboardType,
    this.obscure = false,
    this.action,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: action,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscure,
      onFieldSubmitted: onSubmit,
    );
  }
}
