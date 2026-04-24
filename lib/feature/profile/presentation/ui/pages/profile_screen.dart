import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketi/core/helper/app_notifiers.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final name = PreferenceManager.instance.getString('name');
  String? imagePath;

  @override
  void initState() {
    super.initState();
    imagePath = PreferenceManager.instance.getString('profile_image');
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppStyle.lightBlue100),
              title: Text(
                'Gallery',
                style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _pick(ImageSource.gallery);
              },
            ),
            const Divider(
              color: AppStyle.lightBlue100,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppStyle.lightBlue100),
              title: Text(
                'Camera',
                style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _pick(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      await PreferenceManager.instance.setString('profile_image', picked.path);
      AppNotifiers.profileImage.value = picked.path;
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: AppStyle.background,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : const AssetImage(
                                'assets/images/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.webp',
                              )
                              as ImageProvider,
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppStyle.background,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppStyle.lightBlue100,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(name!, style: AppStyle.title2),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.person, color: AppStyle.darkBlue900),
                title: Text(
                  'Account Preferences',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppStyle.darkBlue900,
                ),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(Icons.payment, color: AppStyle.darkBlue900),
                title: Text(
                  'Subscription & Payment',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppStyle.darkBlue900,
                ),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.notification_important,
                  color: AppStyle.darkBlue900,
                ),
                title: Text(
                  'App Notifications',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: Switch(value: false, onChanged: (val) {}),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.dark_mode_outlined,
                  color: AppStyle.darkBlue900,
                ),
                title: Text(
                  'Dark Mode',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: Switch(value: false, onChanged: (val) {}),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.star_border_outlined,
                  color: AppStyle.darkBlue900,
                ),
                title: Text(
                  'Rate Us',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppStyle.darkBlue900,
                ),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.feedback_outlined,
                  color: AppStyle.darkBlue900,
                ),
                title: Text(
                  'Provide Feedback',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppStyle.darkBlue900,
                ),
              ),
              const Divider(color: AppStyle.darkBlue900, thickness: 2),
              ListTile(
                leading: const Icon(Icons.logout_outlined, color: AppStyle.red),
                title: Text(
                  'Logout',
                  style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppStyle.darkBlue900,
                ),
                onTap: () {
                  PreferenceManager.instance.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
