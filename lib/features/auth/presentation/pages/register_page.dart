import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wori_app_frontend/features/auth/presentation/pages/login_page.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:wori_app_frontend/features/auth/presentation/widgets/text_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(40),
                          Text("Create your account"),
                        ],
                      ),
                    ),
                    Gap(5),

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
                        final email = _emailController.text.isNotEmpty
                            ? _emailController.text
                            : null;
                        final password = _passwordController.text.isNotEmpty
                            ? _passwordController.text
                            : null;
                        final username = _usernameController.text.isNotEmpty
                            ? _usernameController.text
                            : null;
                        if (email == null ||
                            password == null ||
                            username == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill in all fields.',
                              ),
                            ),
                          );
                        }
                        context.read<AuthBloc>().add(
                          RegisterRequested(
                            email: email!,
                            username: username!,
                            password: password!,
                          ),
                        );
                      },
                    ),
                    Gap(10),
                    AuthPrompt(
                      text: "Already have an account?",
                      linkText: "Click here to login",
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
