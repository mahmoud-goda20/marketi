import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/custom_form_field.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/verification_code_with_email_screen.dart';
import 'package:marketi/core/widgets/arrow_back.dart';

class ForgetPasswordWithEmailScreen extends StatelessWidget {
  ForgetPasswordWithEmailScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt<AuthRepo>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppStyle.lightBlue100),
              ),
            );
          } else if (state is AuthCodeSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppStyle.green,
                content: Text("Verification code sent!"),
              ),
            );
            // Hide loading indicator and navigate to the next screen
            Navigator.of(context).pop(); // Hide loading dialog
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: VerificationCodeWithEmailScreen(
                    email: _emailController.text.trim(),
                  ),
                ),
              ),
            );
          } else if (state is AuthFailure) {
            // Hide loading indicator and show error message
            Navigator.of(context).pop(); // Hide loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppStyle.red,
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppStyle.background,
            appBar: AppBar(
              title: const Text('Forgot Password'),
              titleTextStyle: AppStyle.body2,
              backgroundColor: AppStyle.background,
              automaticallyImplyLeading: false,
              leading: ArrowBack(),
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Illustration_Forgot_Password_With_Email.svg',
                        height: 250,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Please enter your email address to receive a verification code',
                        style: AppStyle.body2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 36),
                      CustomFormField(
                        controller: _emailController,
                        hintText: 'example@gmail.com',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Simple email validation
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(p0)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Trigger the forgot password event in the AuthCubit
                            context.read<AuthCubit>().sendForgetPasswordCode(
                              _emailController.text.trim(),
                            );
                          }
                        },
                        buttonTitle: 'Send Code',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
