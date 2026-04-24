import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class TittlesInHome extends StatelessWidget {
  const TittlesInHome({
    super.key,
    required this.tittle, required this.onPressed,
  });
  final String tittle;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tittle, style: AppStyle.title),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'View all',
            style: AppStyle.body2.copyWith(
              color: AppStyle.lightBlue100,
            ),
          ),
        ),
      ],
    );
  }
}
