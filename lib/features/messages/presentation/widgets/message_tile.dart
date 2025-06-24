import 'package:flutter/material.dart';
import 'package:wori_app_frontend/core/theme.dart';
import 'package:wori_app_frontend/utils/gravatars.dart';

class MessageTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;

  const MessageTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          "https://picsum.photos/1280/720",
        ),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: DeafultColor.myGrey,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Text(
        time,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: DeafultColor.myGrey,
        ),
      ),
    );
  }
}
