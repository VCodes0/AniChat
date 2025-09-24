import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.hintText,
    this.isPassword = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // For IOS
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        placeholder: hintText ?? labelText,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(prefixIcon),
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    } else {
      // For Android
      return TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }
}
