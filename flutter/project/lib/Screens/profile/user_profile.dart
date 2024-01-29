import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/backgrounds/background.dart';
import 'package:project/constants.dart';
import 'package:project/models/user_model.dart';
import 'package:project/services/current_user_service.dart';

class UserProfileScreen extends StatefulWidget {
  static String routeName = "/user_profile";
  final String userFirstName;
  final String userLastName;
  final String userID;
  final String userFullName;
  final String userImage;
  final String userUsername;
  final String userDateOfBirth;
  final String userDescription;

  const UserProfileScreen({
    Key? key,
    required this.userFirstName,
    required this.userLastName,
    required this.userUsername,
    required this.userDescription,
    required this.userDateOfBirth,
    required this.userImage,
    required this.userID,
  })  : userFullName = '$userFirstName $userLastName',
        super(key: key);

  @override
  State<UserProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<UserProfileScreen> {
  UserModel? currentUser;
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
    ));
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    UserService userService = UserService();
    UserModel? fetchedUser = await userService.getCurrentUserModel();
    setState(() {
      currentUser = fetchedUser;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  widget.userImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Text(
                widget.userUsername,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Text(
                widget.userFullName,
              ),
            ),
            const Divider(
              height: 34,
              thickness: 0.2,
              indent: 24,
              endIndent: 24,
              color: Color(0xFF757575),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 5), // You can customize the padding values here
              child: Text(
                widget.userDescription,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 26),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Icon(
                          Icons.calendar_today_rounded,
                          color: secondaryColor,
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          widget.userDateOfBirth,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
            GestureDetector(
              onTap: () {
                /*authService.signOut(); // umesto sign out treba send friend request
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInCheck()),
                );*/
              },
              child: const Text.rich(
                TextSpan(
                  text: "Dodaj prijatelja", // ovde treba u zavisnosti da li ste prijatlji da pise : dodaj prijatelja, poslat zahtev, prijatelji
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
