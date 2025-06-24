import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wori_app_frontend/core/extensions.dart';
import 'package:wori_app_frontend/core/theme.dart';
import 'package:wori_app_frontend/features/messages/presentation/widgets/message_tile.dart';
import 'package:wori_app_frontend/features/messages/presentation/widgets/recent_contact.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: context.theme.primaryColor,
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Implement more options functionality here
            },
          ),
        ],
      ),
      body: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 400,

            maxWidth: 800,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Recent Contacts',
                    style: context.theme.textTheme.bodySmall,
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  height: 100,

                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      RecentContact(name: 'Barry', context: context),
                      RecentContact(name: 'Perez', context: context),
                      RecentContact(name: 'Alvin', context: context),
                      RecentContact(name: 'Dan', context: context),
                      RecentContact(name: 'Frank', context: context),
                      RecentContact(name: 'Gioggy', context: context),
                      RecentContact(name: 'Gioggy', context: context),
                      RecentContact(name: 'Gioggy', context: context),
                      RecentContact(name: 'Gioggy', context: context),
                    ],
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: DeafultColor.messageListPage,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    // color: Colors.lightGreen,
                    child: ListView(
                      children: [
                        MessageTile(
                          name: 'Danny H',
                          lastMessage: 'Ciao ciao ciao ahahahahaha',
                          time: "08:43",
                        ),
                        MessageTile(
                          name: 'Bobby R',
                          lastMessage: 'Ciao ciao ciao ahahahahaha',
                          time: "08:43",
                        ),
                        MessageTile(
                          name: 'Mike H',
                          lastMessage: 'Ciao ciao ciao ahahahahaha',
                          time: "08:43",
                        ),
                        MessageTile(
                          name: 'Fabrice H',
                          lastMessage: 'Ciao ciao ciao ahahahahaha',
                          time: "08:43",
                        ),
                        MessageTile(
                          name: 'Fabio L',
                          lastMessage: 'Ciao ciao ciao ahahahahaha',
                          time: "08:43",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
