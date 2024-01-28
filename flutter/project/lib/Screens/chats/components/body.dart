import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
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
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(
                  0xF0F0F0F0), // dzektor da doda boju i da se zameni
              hintText: "Pretraži",
              hintStyle: const TextStyle(
                color: Color(
                    0xFF757575), // dzektor da doda boju i da se zameni
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
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: secondaryColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: friendsManager.getFriendsOfUser(currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: secondaryColor));
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
      lastMessage: 'Klikni za ćaskanje',
      image: "${users['imageUrl']}",
      time: "1h", // ovde kad je poslata ta poslenja poruka ako je moguce
      isActive: true,
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