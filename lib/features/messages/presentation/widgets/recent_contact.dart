import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/core/extensions.dart';

class RecentContact extends StatelessWidget {
  const RecentContact({
    super.key,
    required this.name,
    required this.context,
  });

  final String name;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          Gap(5),
          Text(
            name,
            style: context.theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
