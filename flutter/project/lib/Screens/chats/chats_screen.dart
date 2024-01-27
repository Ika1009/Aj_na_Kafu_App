import 'package:project/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ćaskanja',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        automaticallyImplyLeading: false, 
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.2),
          child: Container(
            color: const Color(0xFF757575),
            height: 0.2,
          ),
        ),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }
}
