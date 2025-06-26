import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/core/extensions.dart';
import 'package:wori_app_frontend/conf/theme/theme.dart';
import 'package:wori_app_frontend/features/chat/domain/entities/message.dart';
import 'package:wori_app_frontend/features/chat/presentation/widgets/message_input.dart';
import 'package:wori_app_frontend/features/chat/presentation/widgets/message_widget.dart';
import 'package:wori_app_frontend/utils/utils.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: DefaultColors.wihteText,
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: Utils.getImageProvider(
                "https://picsum.photos/1280/720",
              ),
            ),
            Gap(10),
            Text(
              'Danny Hopkins',
              style: context.theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 400,
            maxWidth: 600,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    // Add more messages here
                    MessageWidget(
                      message: "Test received",
                      type: MessageType.received,
                    ),
                    MessageWidget(message: "Test sent", type: MessageType.sent),
                    MessageWidget(message: "✅️👌", type: MessageType.sent),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MessageInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
