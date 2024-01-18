import 'package:flutter/widgets.dart';
import 'package:project/Screens/chats/chats_screen.dart';
import 'package:project/screens/signin/signin_screen.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/signup/signup_screen.dart';
import 'package:project/screens/onboard/onboard_screen.dart';
import 'package:project/screens/launch/launch_screen.dart';
import 'package:project/screens/setup/setup_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(), 
  ChatsScreen.routeName: (context) => const ChatsScreen(),
  MessagesScreen.routeName: (context) => const MessagesScreen(),
  OnBoardScreen.routeName: (context) => const OnBoardScreen(),
  LaunchScreen.routeName: (context) => const LaunchScreen(),
  SetupScreen.routeName: (context) => const SetupScreen(),
};
