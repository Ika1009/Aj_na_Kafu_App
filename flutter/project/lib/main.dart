import 'package:flutter/material.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/theme.dart';
import 'package:project/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aj Na Kafu',
      theme: AppTheme.lightTheme(context),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
