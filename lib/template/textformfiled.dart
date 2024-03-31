import 'package:flutter/material.dart';

class Textformfiled extends StatelessWidget {
  final String hintText;
  final Color color;
  final FormFieldValidator validator;
  const Textformfiled(
      {required this.hintText,
      required this.color,
      required this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          fillColor: color,
          filled: true),
    );
  }
}
