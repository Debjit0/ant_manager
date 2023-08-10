import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    required this.hintText,
    required this.controller,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
