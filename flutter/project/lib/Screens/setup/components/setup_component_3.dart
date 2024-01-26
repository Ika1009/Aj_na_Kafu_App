import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/models/user_data.dart';
import 'package:image_input/image_input.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class AccountSetup3 extends StatefulWidget {
  final UserData userData;
  const AccountSetup3({Key? key, required this.userData}) : super(key: key);

  @override
  State<AccountSetup3> createState() => _AccountSetup3State();
}

class _AccountSetup3State extends State<AccountSetup3> {
  List<XFile> images = [];
  XFile? profileImage = XFile('assets/images/placeholder-image.png');

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          profileImage = pickedFile;
        });
      }
    } catch (e) {
      // Handle any errors
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;
      void finishRegistration(BuildContext context, UserData userData) async {
      // Call your AuthService to create a new user account
      // This is just a sample, you would replace with your actual AuthService implementation
      final authService = AuthService(); // Assuming you have an instance of your AuthService
      try {
        await authService.signUpWithEmailAndPassword(
          data.userName,
          data.email,
          data.password,
          userData.firstName,
          userData.lastName,
          userData.dateOfBirth,
          userData.phoneNumber,
          userData.description,
        );
        // If registration is successful, navigate to the next screen or show a success message
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // If registration fails, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${data.userName}',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
            ),
          ),
          const Text(
            'Great, just few more steps...',
            style: TextStyle(
              color: Color(0xFF757575), // dzektor da doda boju
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          ProfileAvatar(
            radius: 100,
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
                  padding: EdgeInsets.all(8.0),
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
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: backgroundColor,
                ),
              ),
            ),
            onImageChanged: (XFile? image) {
              //save image to cloud and get the url
              //or
              //save image to local storage and get the path
              String? tempPath = image?.path;
              print(tempPath);
            },
            onImageRemoved: () {
              setState(() {
                profileImage = null;
              });
            },
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
            onPressed: () => finishRegistration(context, widget.userData), // Bind the onPressed event
            child: const Text(
              "Finish",
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}