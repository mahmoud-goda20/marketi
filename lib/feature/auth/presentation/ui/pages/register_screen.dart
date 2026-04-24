import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/custom_form_field.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/social_login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Registration successful!")));
            // Hide loading indicator and navigate to the next screen
            Navigator.of(context).pop(); // Hide loading dialog
          } else if (state is AuthFailure) {
            // Hide loading indicator and show error message
            Navigator.of(context).pop(); // Hide loading dialog
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          return Scaffold(
            backgroundColor: AppStyle.background,
            appBar: AppBar(
              backgroundColor: AppStyle.background,
              automaticallyImplyLeading: false,
              leading: ArrowBack(),
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(22),
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Logo_Splash_Screen.png',
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          controller: fullNameController,
                          hintText: 'Full Name',
                          prefixIcon: Icons.person_sharp,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        CustomFormField(
                          controller: userNameController,
                          hintText: 'User Name',
                          prefixIcon: Icons.person_sharp,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              return 'Please enter your user name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        CustomFormField(
                          controller: phoneNumberController,
                          hintText: '+20 1234567890',
                          prefixIcon: Icons.phone_sharp,
                          keyboardType: TextInputType.phone,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            // Simple phone number validation
                            if (p0.trim().length != 11) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 14),
                        CustomFormField(
                          controller: emailController,
                          hintText: 'example@gmail.com',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            // Simple email validation
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(p0)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        BlocBuilder<UiCubit, UiState>(
                          builder: (context, state) {
                            return CustomFormField(
                              controller: passwordController,
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              validator: (p0) {
                                if (p0 == null || p0.trim().isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (p0.trim().length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              isPassword: !state.isPasswordVisible,
                              suffixIcon: state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTapSuffix: () {
                                context
                                    .read<UiCubit>()
                                    .togglePasswordVisibility();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        BlocBuilder<UiCubit, UiState>(
                          builder: (context, state) {
                            return CustomFormField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
                              prefixIcon: Icons.lock,
                              validator: (p0) {
                                if (p0 == null || p0.trim().isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (p0 != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              isPassword: !state.isConfirmPasswordVisible,
                              suffixIcon: state.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTapSuffix: () {
                                context
                                    .read<UiCubit>()
                                    .toggleConfirmPasswordVisibility();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                        CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authCubit.register(
                                userNameController.text.trim(),
                                phoneNumberController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                confirmPasswordController.text.trim(),
                              );
                            }
                          },
                          buttonTitle: 'Sign Up',
                        ),
                        const SizedBox(height: 18),
                        Text(
                          "Or Continue with",
                          style: AppStyle.body2.copyWith(
                            color: AppStyle.navy,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SocialLogin(),
                      ],
                    ),
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
