import 'dart:io';
import 'package:flutter/material.dart';
import 'package:marketi/core/helper/app_notifiers.dart';
import 'package:marketi/core/utils/app_style.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: AppNotifiers.profileImage,
      builder: (context, image, _) {
        return Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppStyle.lightBlue100, width: 3),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppStyle.background,
            backgroundImage: image != null
                ? FileImage(File(image))
                : const AssetImage(
                        'assets/images/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.webp',
                      )
                      as ImageProvider,
          ),
        );
      },
    );
  }
}
