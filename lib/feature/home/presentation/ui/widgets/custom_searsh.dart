import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomSearch({
    super.key,
    required this.controller,
    this.hintText = 'What are you looking for ? ',
    this.onClear,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.placeholderStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppStyle.darkBlue900,
          size: 34,
        ),
        suffixIcon: Icon(Icons.tune, color: AppStyle.lightBlue100, size: 34),
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
      ),
    );
  }
}
