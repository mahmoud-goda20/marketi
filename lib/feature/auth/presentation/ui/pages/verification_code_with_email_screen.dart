import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/create_new_password_screen.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeWithEmailScreen extends StatefulWidget {
  final String email;
  const VerificationCodeWithEmailScreen({super.key, required this.email});
  @override
  State<VerificationCodeWithEmailScreen> createState() =>
      _VerificationCodeWithEmailScreenState();
}

class _VerificationCodeWithEmailScreenState
    extends State<VerificationCodeWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  String? _pinCode;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopScope(
              canPop: false,
              child: Center(
                child: CircularProgressIndicator(color: AppStyle.lightBlue100),
              ),
            ),
          );
        } else if (state is AuthCodeVerified) {
          // Hide loading dialog safely
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AuthCubit>(),
                child: CreateNewPasswordScreen(email: widget.email),
              ),
            ),
          );
        } else if (state is AuthFailure) {
          // Hide loading dialog safely
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppStyle.red,
              content: Text(state.errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppStyle.background,
          appBar: AppBar(
            title: const Text('Verification Code'),
            backgroundColor: AppStyle.background,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            leading: const ArrowBack(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                            text: widget.email,
                            style: AppStyle.body2.copyWith(
                              color: AppStyle.lightBlue100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // OTP Input
                    Pinput(
                      controller: _codeController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: AppStyle.title,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppStyle.lightBlue700,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: AppStyle.title,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppStyle.lightBlue100,
                            width: 2,
                          ),
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
                      errorPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: AppStyle.title.copyWith(color: AppStyle.red),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppStyle.red, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the code';
                        }
                        if (value.length != 6) {
                          return 'Code must be 6 digits';
                        }
                        return null;
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) {
                        setState(() => _pinCode = pin);
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().verifyEmailCode(
                            widget.email,
                            pin,
                          );
                        }
                      },
                      onChanged: (value) {
                        setState(() => _pinCode = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().verifyEmailCode(
                                  widget.email, // ✅
                                  _pinCode ?? _codeController.text,
                                );
                              }
                            },
                      buttonTitle: 'Verify Code',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
