import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/text_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void _showInputValues() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;

    // You can handle the input values here, e.g., send them to a server
    print(
      'Email: $email, Password: $password, Username: $username',
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
                TextInput(
                  controller: _usernameController,
                  icon: Icons.person,
                  hintText: 'Username',
                ),
                Gap(20),
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
                  text: "Register",
                  onPressed: () {
                    //Handle registration logic here
                    _showInputValues();
                  },
                ),
                Gap(10),
                AuthPrompt(
                  text: "Already have an account?",
                  linkText: "Click here to login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
