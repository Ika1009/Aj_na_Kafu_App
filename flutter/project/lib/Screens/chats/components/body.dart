import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/models/chat_tile.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:project/services/users_manager.dart';
import 'package:project/screens/chats/components/chat_card.dart';

class ChatsBody extends StatefulWidget {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
    searchController.addListener(() {
      filterUsers(searchController.text);
    });
  }

  Future<void> fetchAllUsers() async {
    try {
      allUsers = await UsersManager().getFriendsOfUser(currentUser!.uid);
      filteredUsers = allUsers;
    } catch (e) {
      //print('Failed to fetch users: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = allUsers;
      });
    } else {
      setState(() {
        filteredUsers = allUsers
          .where((user) =>
              user['firstName'].toLowerCase().contains(query.toLowerCase()) ||
              user['lastName'].toLowerCase().contains(query.toLowerCase()) ||
              user['username'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Center(
        child: Text('Korisnik nije prijavljen'),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xF0F0F0F0), 
                hintText: "Pretraži",
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
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredUsers.isNotEmpty ? ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return _buildUserListItem(context, filteredUsers[index], currentUser!);
              },
            ) : const Center(
                child: Text("Ne postoji korisnik ili niste započeli pretragu"),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, Map<String, dynamic> users, User currentUser) {
    var chatData = Chat(
      name: users['firstName'],
      lastMessage: 'Klikni za ćaskanje',
      image: "${users['imageUrl']}",
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
             receiverUsername: users['username'],
             receiverImagePath: users['imageUrl'],
             receiverID: users['uid'],
           ),
         ),
       );
      },
    );
  }
}