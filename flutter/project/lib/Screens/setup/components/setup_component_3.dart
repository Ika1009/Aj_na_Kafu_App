import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/models/user_data.dart';
import 'package:image_input/image_input.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import '../../../constants.dart';

class AccountSetup3 extends StatefulWidget {
  final UserData userData;
  const AccountSetup3({Key? key, required this.userData}) : super(key: key);

  @override
  State<AccountSetup3> createState() => _AccountSetup3State();
}

class _AccountSetup3State extends State<AccountSetup3> {
  XFile? profileImage = XFile('assets/images/placeholder-image.png');
  bool _isUploading = false;
  Uint8List? imageData;

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

  void finishRegistration(BuildContext context) async {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;
    final authService = AuthService();

    setState(() {
      _isUploading = true;
    });

    try {
      UserCredential userCredential = await authService.signUpWithEmailAndPassword(
        data.userName,
        data.email,
        data.password,
        widget.userData.firstName,
        widget.userData.lastName,
        widget.userData.dateOfBirth,
        widget.userData.phoneNumber,
        widget.userData.description,
      );

      // After successful account creation, get the UID
      String? userUID = userCredential.user?.uid;

      // Now upload the image using the UID, if an image is selected
      if (imageData != null && userUID != null) {
        try {
          String imageUrl = await authService.uploadImage(imageData!, userUID);

          // Update Firestore collection with the imageUrl that has been uploaded to the servers
          await authService.uploadUserProfileImageURL(userUID, imageUrl);

          // Optionally update user's profile or additional data with the imageUrl
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image upload failed: ${e.toString()}')),
          );
        }
      }
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } 
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    } 
    finally {
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
            'Zdravo, ${data.userName}',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
            ),
          ),
          const Text(
            'Odlično, još samo nekoliko koraka...',
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
            onPressed: _isUploading ? null : () => finishRegistration(context),
            child: _isUploading
                ? const CircularProgressIndicator(color: backgroundColor)
                : const Text(
                    "Završi",
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