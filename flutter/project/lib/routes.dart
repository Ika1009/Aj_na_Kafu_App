import 'package:flutter/widgets.dart';
import 'package:project/Screens/chats/chats_screen.dart';
import 'package:project/screens/login/login_screen.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/signup/signup_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName:(context) => const SignUpScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(), 
  ChatsScreen.routeName: (context) => const ChatsScreen(),
  MessagesScreen.routeName:(context) => const MessagesScreen(),
};
