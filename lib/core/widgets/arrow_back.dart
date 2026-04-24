import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
        color: AppStyle.background,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppStyle.lightBlue100, width: 1),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios, size: 25),
      ),
    );
  }
}
