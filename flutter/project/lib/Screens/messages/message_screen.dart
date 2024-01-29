import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/screens/messages/components/message_bubble.dart';
import 'package:project/services/chat_service.dart';

class MessagesScreen extends StatefulWidget {
  static String routeName = "/messages";
  final String receiverFirstName;
  final String receiverLastName;
  final String receiverUsername;
  final String receiverImagePath;
  final String receiverID;
  final String receiverFullName;
  
  const MessagesScreen({
    Key? key,
    required this.receiverFirstName,
    required this.receiverLastName,
    required this.receiverUsername,
    required this.receiverImagePath,
    required this.receiverID,
  })  : receiverFullName = '$receiverFirstName $receiverLastName',
        super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.receiverImagePath),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receiverFullName,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.receiverUsername,
                style: const TextStyle(fontSize: 12), 
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, _firebaseAuth.currentUser!.uid), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool userOrSender = data['senderId'] == _firebaseAuth.currentUser!.uid;

    var alignment = (userOrSender)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        child: Column(
          crossAxisAlignment: 
              (userOrSender)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: 
              (userOrSender)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            MessageBubble(
              message: data['message'],
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? secondaryColor
                  : const Color(0xFFF5F5F5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: null,
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                hintText: "Ukucaj poruku...",
                hintStyle: const TextStyle(
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),
    
          IconButton(
            onPressed: sendMessage, 
            icon: const Icon(
              Icons.arrow_right_alt_rounded,
              size: 30,
            )
          ),
        ],
      ),
    );
  }
}