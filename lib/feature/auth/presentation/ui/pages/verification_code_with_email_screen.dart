import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/create_new_password_screen.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeWithEmailScreen extends StatelessWidget {
  VerificationCodeWithEmailScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.background,
      appBar: AppBar(
        title: const Text('Verificatie Code'),
        backgroundColor: AppStyle.background,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: ArrowBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/Illustration_Verification_Code_With_Email.svg',
                height: 250,
              ),
              const SizedBox(height: 40),
              Text.rich(
                TextSpan(
                  text: 'Please enter the 4 digit code sent to: ',
                  style: AppStyle.body2,
                  children: [
                    TextSpan(
                      text: 'example@gmail.com',
                      style: AppStyle.body2.copyWith(
                        color: AppStyle.lightBlue100,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              //otp input fields
              Pinput(
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: AppStyle.title,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppStyle.lightBlue700, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: AppStyle.title,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppStyle.lightBlue100, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: AppStyle.title,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppStyle.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (p) {},
              ),
              const SizedBox(height: 20),
              CustomButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreateNewPasswordScreen(),
                ));
              }, buttonTitle: 'Verify Code'),
            ],
          ),
        ),
      ),
    );
  }
}
