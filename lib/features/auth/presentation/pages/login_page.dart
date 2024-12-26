import 'package:bloggy/core/common/widgets/loader.dart';
import 'package:bloggy/core/utils/show_snackbar.dart';
import 'package:bloggy/core/widgets/custom_field.dart';
import 'package:bloggy/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggy/features/auth/presentation/pages/signup_page.dart';
import 'package:bloggy/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:bloggy/features/auth/presentation/widgets/info_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            if (state is AuthSuccess) {
              // Navigator.pushReplacement(context, HomePage.route());
            }

            return Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 15),
                  CustomField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  AuthGradientButton(
                    buttonText: 'Log In',
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, SignupPage.route());
                    },
                    child: InfoSpan(
                      message: 'Dont\'t have an account? ',
                      routeName: 'Sign Up',
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
