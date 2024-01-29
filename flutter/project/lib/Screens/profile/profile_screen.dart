import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/backgrounds/background.dart';
import 'package:project/components/signin_check.dart';
import 'package:project/constants.dart';
import 'package:project/models/user_model.dart';
import 'package:project/screens/profile/friend_requests.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/current_user_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FriendRequests()),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.person_add), 
      ),
      body: Background(
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                    currentUser?.imageUrl ?? "https://bonanza.mycpanel.rs/ajnakafu/images/profile_basic.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Text(
                  currentUser?.username ?? "Korisnik",
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 5),
                child: Text(
                  "${currentUser?.firstName ?? "Ime"} ${currentUser?.lastName ?? "Prezime"}",
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  "8",
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  "prijatelja",
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
                  currentUser?.description ?? "Opis",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                            Icons.email_rounded,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            currentUser?.email ?? "korisnik@gmail.com",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                            currentUser?.dateOfBirth ?? "01/01/2000",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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
                            Icons.phone_rounded,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            currentUser?.phoneNumber ?? "+38161234567",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              GestureDetector(
                onTap: () {
                  authService.signOut();
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInCheck()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Odjavi se",
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
      ),
    );
  }
}
