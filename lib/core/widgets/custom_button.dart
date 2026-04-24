import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
  });

  final Function() onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyle.lightBlue100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(buttonTitle, style: AppStyle.button),
      ),
    );
  }
}
