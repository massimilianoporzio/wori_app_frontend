import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/core/theme.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DeafultColor.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onPressed: () {
              // Implement attachment functionality
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Gap(10),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onPressed: () {
              // Implement send functionality
            },
          ),
        ],
      ),
    );
  }
}
