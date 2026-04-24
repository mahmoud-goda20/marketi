import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/forget_password_with_email_screen.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/custom_form_field.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/register_screen.dart';
import 'package:marketi/feature/auth/presentation/ui/widgets/social_login.dart';
import 'package:marketi/feature/main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameOrEmailController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (context) => AuthCubit(getIt<AuthRepo>()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: AppStyle.lightBlue100,
                  ),
                ),
              );
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppStyle.green,
                  content: Text(
                    "Login successful!",
                    style: AppStyle.body2.copyWith(color: AppStyle.background),
                  ),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return MainScreen();
                  },
                ),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppStyle.red,
                  content: Text(
                    state.errorMessage,
                    style: AppStyle.body2.copyWith(color: AppStyle.background),
                  ),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(22),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Image.asset('assets/images/Logo_Splash_Screen.png'),
                        const SizedBox(height: 35),
                        CustomFormField(
                          controller: usernameOrEmailController,
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              return "Please enter your username or email";
                            } else if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(p0.trim())) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<UiCubit, UiState>(
                          builder: (context, state) {
                            return CustomFormField(
                              controller: passwordController,
                              hintText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              suffixIcon: state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTapSuffix: () {
                                context
                                    .read<UiCubit>()
                                    .togglePasswordVisibility();
                              },
                              isPassword: !state.isPasswordVisible,
                              validator: (p0) {
                                if (p0 == null || p0.trim().isEmpty) {
                                  return "Please enter your password";
                                } else if (p0.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<UiCubit, UiState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: state.isRememberMe,
                                      onChanged: (_) {
                                        context
                                            .read<UiCubit>()
                                            .toggleRememberMe();
                                      },
                                      activeColor: AppStyle.lightBlue100,
                                    ),
                                    Text(
                                      "Remember me",
                                      style: AppStyle.body2.copyWith(
                                        color: AppStyle.navy,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ForgetPasswordWithEmailScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot password?",
                                style: AppStyle.body2.copyWith(
                                  color: AppStyle.lightBlue100,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authCubit.login(
                                usernameOrEmailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          buttonTitle: "Log In",
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Are you new in Marketi ?",
                              style: AppStyle.body2.copyWith(
                                color: AppStyle.navy,
                                fontSize: 12,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Register Now !",
                                style: AppStyle.body2.copyWith(
                                  color: AppStyle.lightBlue100,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
