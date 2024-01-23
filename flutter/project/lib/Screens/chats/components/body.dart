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
// Widget _buildUserList() {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('users').snapshots(),
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

//   // Assuming _auth is an instance of FirebaseAuth
//   if (FirebaseAuth.instance.currentUser!.email != data['email']) {
//     return ListTile(
//       title: Text(data['email']),
//       onTap: () { // ovde treba da otvori stranu za chatovanje sa UID }
//     );
//   } else {
//     return Container(); // Return an empty container if it's the current user
//   }
// }