import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.grey,
          ),
          Gap(10),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: widget.controller,
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
    );
  }
}
