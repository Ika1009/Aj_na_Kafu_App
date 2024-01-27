import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/home/home_screen.dart';
import '../screens/signin/signin_screen.dart';

class SignInCheck extends StatelessWidget {
  const SignInCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
