
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppColors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField( {super.key, this.onChanged, required this.hint, required this.labelText, this.keyboardType, this.obscureText=false, this.inputFormatters, this.maxLength, this.controller});
  final String hint;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        labelText: labelText,
        hintStyle: TextStyle(fontWeight: FontWeight.w400,color: AppColors.textPrimary),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.divider,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(color: AppColors.textOrIcon),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.5),
      ),
    );
  }
}