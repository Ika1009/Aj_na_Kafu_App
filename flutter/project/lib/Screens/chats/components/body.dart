import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/Chat.dart';
import 'package:project/models/friendships_manager.dart';
import 'package:project/screens/chats/components/chat_card.dart';
import 'package:project/screens/messages/message_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendsManager friendsManager = FriendsManager();

    // Getting the current user from Firebase
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if currentUser is null and handle accordingly
    if (currentUser == null) {
      // Return a widget that handles this case, like a login prompt or an error message
      return const Center(
        child: Text('User not logged in.'),
      );
    }

    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: friendsManager.getFriendsOfUser(currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildUserListItem(context, snapshot.data![index]);
                  },
                );
              } else {
                return const Text('No friends found');
              }
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildUserListItem(BuildContext context, Map<String, dynamic> users) {
  var chatData = Chat(
    name: users['firstName'],
    lastMessage: 'Tap to chat with ${users['firstName']}',
    image: "assets/images/profile1.png",
    time: "3m ago",
    isActive: false,
  );

  return ChatCard(
    chat: chatData, 
    press: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MessagesScreen(),
      ),
    ),
  );
}