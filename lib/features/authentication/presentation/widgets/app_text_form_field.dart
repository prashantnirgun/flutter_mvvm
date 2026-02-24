import 'package:flutter/material.dart';
import 'package:bpp/core/theme/constants.dart';

class AppTextFormField extends StatelessWidget {
  final Key? fieldKey;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextFormField({
    super.key,
    this.fieldKey,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        fillColor: AppColors.fieldFill,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: BorderSide(
            color: AppColors.fieldFill,
            width: AppDimensions.fieldBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
