import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/services/chat_service.dart';

import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  static String routeName = "/messages";
  final String receiverFirstName;
  final String receiverLastName;
  final String receiverID;
  final String receiverFullName;

  const MessagesScreen({
    Key? key,
    required this.receiverFirstName,
    required this.receiverLastName,
    required this.receiverID,
  })  : receiverFullName = '$receiverFirstName $receiverLastName',
        super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile2.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(receiverFullName,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
  
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // Sending the message here
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID, _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text(widget.receiverFullName)),
    body: Column(
      children: [
        // messages
        //Expanded(
          //child: _buildMessageList(),
        //), // Expanded


      ],
    ), // Column
  ); // Scaffold
}

// build message list

// build message item

// build message input

}
