import 'package:flutter/material.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';

class AppNotifiers {
  static final profileImage = ValueNotifier<String?>(
    PreferenceManager.instance.getString('profile_image'),
  );
}