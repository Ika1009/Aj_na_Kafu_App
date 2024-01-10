import 'package:flutter/material.dart';
import 'package:project/util/colors.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/todo.dart';
import 'package:project/pages/object.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: colorScheme,
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/todo': (context) => ToDoPage(),
        '/object': (context) => ObjectPage(),
      },
    );
  }
}