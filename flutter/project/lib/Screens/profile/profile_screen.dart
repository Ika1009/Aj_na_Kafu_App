//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_input/image_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/components/signin_check.dart';
import 'package:project/constants.dart';
import 'package:project/models/user_data.dart';
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
  UserData? currentUser;
  XFile? profileImage; 
  final bool _isUploading = false;
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
    UserData? fetchedUser = await userService.getCurrentUserData();
    setState(() {
      currentUser = fetchedUser;
      if (currentUser != null) {
        profileImage = XFile(currentUser!.imageUrl);
      }
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Read the image file as bytes
        Uint8List imageBytes = await pickedFile.readAsBytes();
        setState(() {
          profileImage = pickedFile;
          imageData = imageBytes;
        });
      }
    } catch (e) {
      //print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        automaticallyImplyLeading: false, 
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.2),
          child: Container(
            color: const Color(0xFF757575),
            height: 0.2,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileAvatar(
                radius: 60,
                allowEdit: true,
                image: profileImage,
                backgroundColor: const Color(0xFFE0F8E8),
                addImageIcon: GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add_a_photo,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
                removeImageIcon: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close,
                      color: backgroundColor,
                    ),
                  ),
                ),
                onImageRemoved: () {
                  setState(() {
                    profileImage = null;
                  });
                },
              ),
              const SizedBox(height: defaultPadding),
              Text(
                currentUser?.firstName ?? "Loading...",
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
              const SizedBox(height: defaultPadding * 4),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentColor),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {}, // doncic da napise novu funkciju za update podataka
                child: _isUploading
                    ? const CircularProgressIndicator(color: backgroundColor)
                    : const Text(
                        "Ažuriraj",
                        style: TextStyle(
                          color: backgroundColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authService.signOut();
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInCheck()),
          );
        },
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
