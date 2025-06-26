import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/conf/theme/theme.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String? hintText;
  final bool isPassword;

  const TextInput({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.icon,
    this.hintText,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isPasswordVisible = false;
  String textValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.grey,
              ),
              Gap(10),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: widget.controller,
                  onChanged: (value) => setState(() {
                    textValue = value;
                  }),
                  obscureText: widget.isPassword && !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.isPassword)
                IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
            ],
          ),
          if (widget.isPassword)
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: FlutterPasswordStrength(
                password: textValue,
                height: 5,
                radius: 10,
                strengthCallback: (strength) {
                  // You can use this callback to show password strength
                  // final value = widget.controller.text;
                  // print('Password strength: $strength for value: $value');
                  // Handle password strength logic here if needed
                },
              ),
            ),
        ],
      ),
    );
  }
}
