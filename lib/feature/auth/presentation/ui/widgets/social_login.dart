import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/core/utils/app_style.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppStyle.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppStyle.lightBlue100, width: 1),
          ),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/Vector.svg'),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppStyle.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppStyle.lightBlue100, width: 1),
          ),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.apple, size: 33, color: AppStyle.darkBlue900),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppStyle.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppStyle.lightBlue100, width: 1),
          ),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.facebook, size: 33, color: AppStyle.darkBlue900),
          ),
        ),
      ],
    );
  }
}
