import 'package:flutter/material.dart';
import 'package:project/models/auth_service.dart';
import 'package:project/screens/signin/signin_screen.dart';
import 'package:provider/provider.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/user.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/question.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/logout.svg",
              press: () async {
                await authService.signOut();
                Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
