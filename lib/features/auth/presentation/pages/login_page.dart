import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showInputValues() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // You can handle the input values here, e.g., send them to a server
    print(
      'Email: $email, Password: $password',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Enter your credentials to continue"),
                  ],
                ),
                Gap(40),
                TextInput(
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: 'Email',
                ),
                Gap(20),
                TextInput(
                  controller: _passwordController,
                  icon: Icons.lock,
                  isPassword: true,
                  hintText: 'Password',
                ),
                Gap(20),
                AuthButton(
                  text: "Login",
                  onPressed: () {
                    //Handle registration logic here
                    _showInputValues();
                  },
                ),
                Gap(10),
                AuthPrompt(
                  text: "Does not have an account yet?",
                  linkText: "Click here to register",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
