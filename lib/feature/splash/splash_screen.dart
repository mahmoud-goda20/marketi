import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/main/main_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final token = PreferenceManager.instance.getString('token');
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              token == null ? const OnboardingScreen() : MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/Logo_Splash_Screen.png')),
    );
  }
}
