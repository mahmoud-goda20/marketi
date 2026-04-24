import 'package:flutter/material.dart';
import '../../../../../core/utils/app_style.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? prefixIcon;
  final VoidCallback? onTapSuffix;
  final IconData? suffixIcon;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.placeholderStyle,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppStyle.darkBlue900)
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onTapSuffix,
                child: Icon(suffixIcon, color: AppStyle.darkBlue900),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppStyle.lightBlue100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppStyle.lightBlue100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppStyle.lightBlue100, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppStyle.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppStyle.red, width: 2),
        ),
      ),
    );
  }
}
