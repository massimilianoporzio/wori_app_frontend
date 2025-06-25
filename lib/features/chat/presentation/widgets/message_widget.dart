import 'package:flutter/material.dart';
import 'package:wori_app_frontend/core/theme.dart';
import 'package:wori_app_frontend/features/chat/domain/entities/message.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final MessageType type;
  const MessageWidget({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: type == MessageType.received
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: type == MessageType.received
              ? DeafultColor.receiverMessage
              : DeafultColor.senderMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
