import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/congratulation_screen.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/custom_form_field.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String email;
  CreateNewPasswordScreen({super.key, required this.email});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: AppStyle.lightBlue100),
            ),
          );
        } else if (state is AuthPasswordReset) {
          if (Navigator.canPop(context)) Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CongratulationScreen()),
          );
        } else if (state is AuthFailure) {
          if (Navigator.canPop(context)) Navigator.of(context).pop();
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
            title: const Text('Create New Password'),
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
                      'assets/images/Illustration_Create_New_Password.svg',
                      height: 250,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'New password must be different from last password',
                      style: AppStyle.body2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    CustomFormField(
                      controller: _newPasswordController,
                      hintText: 'New Password',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: (p0) {
                        if (p0 == null || p0.trim().isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (p0.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    CustomFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: (p0) {
                        if (p0 == null || p0.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (p0 != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    CustomButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().resetPassword(
                                  email,
                                  _newPasswordController.text.trim(),
                                  _confirmPasswordController.text.trim(),
                                );
                              }
                            },
                      buttonTitle: 'Save Password',
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
