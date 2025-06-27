import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/text_input.dart';
import 'package:wori_app_frontend/features/messages/presentation/pages/messages_page.dart';

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
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MessagesPage()),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
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
                        final email = _emailController.text.isNotEmpty
                            ? _emailController.text
                            : null;
                        final password = _passwordController.text.isNotEmpty
                            ? _passwordController.text
                            : null;

                        if (email == null && password == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter either email or password.',
                              ),
                            ),
                          );
                          return;
                        }
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            email: email,
                            password: password!,
                          ),
                        );
                        _showInputValues();
                      },
                    ),
                    Gap(10),
                    AuthPrompt(
                      text: "Does not have an account yet?",
                      linkText: "Click here to register",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
