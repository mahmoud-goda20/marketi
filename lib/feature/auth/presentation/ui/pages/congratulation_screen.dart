import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/login_screen.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/Illustration_Congratulations.svg',
              height: 250,
            ),
            const SizedBox(height: 25),
            Text(
              'Congratulations!',
              style: AppStyle.title2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            Text(
              'You have updated the password. please login again with your latest password',
              style: AppStyle.body2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              buttonTitle: 'Go to Log In',
            ),
          ],
        ),
      ),
    );
  }
}
