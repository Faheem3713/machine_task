import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.text,
      this.isObscure = false,
      required this.validator,
      required this.controller});
  final String text;
  final bool isObscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: text),
        validator: validator,
      ),
    );
  }
}
