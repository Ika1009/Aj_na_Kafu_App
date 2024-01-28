import 'package:flutter/widgets.dart';
import 'package:project/Screens/chats/chats_screen.dart';
import 'package:project/Screens/map/map_screen.dart';
import 'package:project/screens/search/search_screen.dart';
import 'package:project/screens/setup/setup_screen_2.dart';
import 'package:project/screens/signin/signin_screen.dart';
import 'package:project/screens/messages/message_screen.dart';
import 'package:project/screens/profile/profile_screen.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/signup/signup_screen.dart';
import 'package:project/screens/launch/launch_screen.dart';
import 'package:project/screens/setup/setup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(), 
  ChatsScreen.routeName: (context) => const ChatsScreen(),
  MessagesScreen.routeName: (context) => 
  const MessagesScreen(
    receiverFirstName: "Ime", 
    receiverLastName: "Prezime", 
    receiverID: "123",
  ),
  LaunchScreen.routeName: (context) => const LaunchScreen(),
  SetupScreen.routeName: (context) => const SetupScreen(),
  AccountSetupScreen.routeName: (context) => const AccountSetupScreen(),
  MapScreen.routeName: (context) => const MapScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
};
