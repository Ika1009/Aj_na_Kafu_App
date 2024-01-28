import 'package:flutter/material.dart';

import 'components/body.dart';

class ChatsScreen extends StatefulWidget {
  static String routeName = "/chats";
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatsBody(),
    );
  }
}
