import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'WORI - a chat app',
          style: Theme.of(context).textTheme.titleLarge,
          // style: GoogleFonts.alegreyaSans(
          //   fontSize: FontSizes.large,
          //   color: DeafultColor.wihteText,
          // ),
        ),
      ),
    );
  }
}
