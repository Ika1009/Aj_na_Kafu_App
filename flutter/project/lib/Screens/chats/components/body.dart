import 'package:project/models/Chat.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// evo ti kod da se napravi lista korisnika koji treba se ispisu ovde
// FriendsManager friendsManager = FriendsManager();
// UserManager userManager = UserManager();


// Widget _buildUserList() {
//   return FutureBuilder<List<Map<String, dynamic>>>(
//     // Use FriendsManager to get the friends' data
//     future: friendsManager.getFriendsOfUser(userManager.uid!),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return const Text('Error');
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Text('Loading...');
//       }
//       if (snapshot.hasData) {
//         return ListView(
//           children: snapshot.data!
//               .map<Widget>((friendData) => _buildUserListItem(friendData))
//               .toList(),
//         );
//       } else {
//         return const Text('No friends found');
//       }
//     },
//   );
// }

// Widget _buildUserListItem(Map<String, dynamic> data) {
//   return ListTile(
//     title: Text(data['email'] ?? 'No email'),
//     onTap: () {
//       // Here you can open the chat page with the user's UID
//       // For example: openChatPage(data['uid']);
//     },
//   );
// }

