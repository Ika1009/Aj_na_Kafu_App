// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/todo.dart';
import 'package:project/assets/colors.dart'

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme,
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/todo': (context) => ToDoPage(),
      },
    );
  }
}