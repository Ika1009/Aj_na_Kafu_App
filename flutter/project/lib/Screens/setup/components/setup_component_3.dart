import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/models/user_data.dart';
import 'package:image_input/image_input.dart';

import '../../../constants.dart';

class AccountSetup3 extends StatefulWidget {
  final UserData userData;
  const AccountSetup3({Key? key, required this.userData}) : super(key: key);

  @override
  _AccountSetup3State createState() => _AccountSetup3State();
}

class _AccountSetup3State extends State<AccountSetup3> {
  XFile? _imageFile;
  bool _isUploading = false;

  // This function will be called when the user selects an image
  void onImageChanged(XFile? image) {
    setState(() {
      _imageFile = image;
    });
  }
void finishRegistration(BuildContext context) async {
  setState(() {
    _isUploading = true;
  });

  final authService = AuthService();
  try {
    UserCredential userCredential = await authService.signUpWithEmailAndPassword(
      widget.userData.userName,
      widget.userData.email,
      widget.userData.password,
      widget.userData.firstName,
      widget.userData.lastName,
      widget.userData.dateOfBirth,
      widget.userData.phoneNumber,
      widget.userData.description,
    );

    // After successful account creation, get the UID
    String? userUID = userCredential.user?.uid;

    // Now upload the image using the UID, if an image is selected
    if (_imageFile != null && userUID != null) {
      try {
        String imageUrl = await authService.uploadImage(_imageFile!, userUID);

        // Update Firestore collection with the imageUrl that has been uploaded to the servers
        await authService.updateUserProfileImage(userUID, imageUrl);

        // Optionally update user's profile or additional data with the imageUrl
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload failed: ${e.toString()}')),
        );
      }
    }

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;

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
            backgroundColor: const Color(0xFFE0F8E8),
            addImageIcon: Container(
              decoration: BoxDecoration(
                color: accentColor,
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
            removeImageIcon: Container(
              decoration: BoxDecoration(
                color: accentColor,
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
          ),
          const SizedBox(height: defaultPadding * 4),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), 
                  side: const BorderSide(color: accentColor, width: 2.0), 
                ),
              ),
            ),
            onPressed: _isUploading ? null : () => finishRegistration(context), // Disable the button when uploading
            child: _isUploading
                ? const CircularProgressIndicator() // Show a loading indicator when uploading
                : const Text(
                    "Finish",
                    style: TextStyle(
                      color: accentColor,
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