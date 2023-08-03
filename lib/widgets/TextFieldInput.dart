import 'package:flutter/material.dart';

class TextFiledInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPass;
  final TextInputType InputType;
  const TextFiledInput(
      {super.key,
      required this.controller,
      required this.label,
      this.isPass = false,
      required this.InputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: InputType,
      obscureText: isPass,
      decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context))),
    );
  }
}
