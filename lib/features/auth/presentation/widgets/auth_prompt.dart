import 'package:flutter/material.dart';
import 'package:wori_app_frontend/conf/theme/theme.dart';

class AuthPrompt extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String linkText;
  const AuthPrompt({
    super.key,
    this.onTap,
    required this.text,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                mouseCursor: SystemMouseCursors.click,
                text: ' $linkText',
                style: const TextStyle(
                  color: DefaultColors.linkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
