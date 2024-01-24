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
// UserManager userManager = UserManager();

// Widget _buildUserList() {
//   return StreamBuilder<QuerySnapshot>(
//     // Stream only the users who are in the current user's friends list
//     stream: FirebaseFirestore.instance.collection('users')
//       .where(FieldPath.documentId, whereIn: userManager.friends)
//       .snapshots(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return const Text('Error');
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Text('Loading...');
//       }
//       return ListView(
//         children: snapshot.data!.docs
//             .map<Widget>((doc) => _buildUserListItem(doc))
//             .toList(),
//       );
//     },
//   );
// }

// Widget _buildUserListItem(DocumentSnapshot document) {
//   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

//   return ListTile(
//     title: Text(data['email'] ?? 'No email'),
//     onTap: () {
//       // Here you can open the chat page with the user's UID
//       // For example: openChatPage(document.id);
//     },
//   );
// }
