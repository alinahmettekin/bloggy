import 'dart:developer';

import 'package:bloggy/core/common/widgets/loader.dart';
import 'package:bloggy/core/utils/show_snackbar.dart';
import 'package:bloggy/core/widgets/custom_field.dart';
import 'package:bloggy/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggy/features/auth/presentation/pages/login_page.dart';
import 'package:bloggy/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:bloggy/features/auth/presentation/widgets/info_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignupPage(),
      );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomField(hintText: 'Name', controller: _nameController),
                  const SizedBox(height: 15),
                  CustomField(hintText: 'Email', controller: _emailController),
                  const SizedBox(height: 15),
                  CustomField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  AuthGradientButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log('validate true');
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: _emailController.text.trim(),
                                name: _nameController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, LoginPage.route()),
                    child: InfoSpan(
                      message: 'Already have an account? ',
                      routeName: 'Log In',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
