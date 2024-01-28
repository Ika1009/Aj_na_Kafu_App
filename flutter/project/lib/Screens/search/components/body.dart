import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/models/search_tile.dart';
import 'package:project/screens/profile/user_profile.dart';
import 'package:project/screens/search/components/search_card.dart';
import 'package:project/services/users_manager.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

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

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: TextFormField(
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
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: friendsManager.getAllUsers(),
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
                  return const Text('');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, Map<String, dynamic> users, User currentUser) {
    var searchData = Search(
      username: users['username'],
      fullName: "${users['firstName']} ${users['lastName']}",
      image: "${users['imageUrl']}",
    );

    return SearchCard(
      search: searchData, 
      press: () {   
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => UserProfileScreen(
             userFirstName: users['firstName'],
             userLastName: users['lastName'],
             userUsername: users['username'],
             userDescription: users['description'],
             userPhoneNumber: users['phoneNumber'],
             userDateOfBirth: users['dateOfBirth'],
             userEmail: users['email'],
             userImage: users['imageUrl'],
             userID: users['uid'],
           ),
         ),
       );
      },
    );
  }
}