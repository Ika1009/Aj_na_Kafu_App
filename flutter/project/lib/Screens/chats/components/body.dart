import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/chat_tile.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:project/services/users_manager.dart';
import 'package:project/screens/chats/components/chat_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsersManager friendsManager = UsersManager();

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
                    return _buildUserListItem(context, snapshot.data![index], currentUser);
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

  Widget _buildUserListItem(BuildContext context, Map<String, dynamic> users, User currentUser) {
    var chatData = Chat(
      name: users['firstName'],
      lastMessage: 'Klikni za ćaskanje sa ${users['firstName']}', // ovde treba poslednja poruka ako je moguce
      image: "assets/images/profile1.png", // ovde treba slika od usera
      time: "sada", // ovde kad je poslata ta poslenja poruka ako je moguce
      isActive: false,
    );

    return ChatCard(
      chat: chatData, 
      press: () {   
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => MessagesScreen(
             receiverFirstName: users['firstName'],
             receiverLastName: users['lastName'],
             receiverID: users['uid'],
           ),
         ),
       );
      },
    );
  }
}