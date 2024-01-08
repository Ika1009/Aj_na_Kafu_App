// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width80Percent = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 112, 49),
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 50),  // Adjust as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // Ensures the column only takes as much vertical space as its children
            children: <Widget>[
              Text('Login', style: TextStyle(fontSize: 35)),
              SizedBox(height: 10),
              Text('Welcome Back', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 247, 112, 49),
        toolbarHeight: 200,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,  // Assuming a white background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,  // Ensure the Container has a background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 30,
                    offset: Offset(0, 0), 
                  ),
                ],
                borderRadius: BorderRadius.circular(10), // Optional rounded corners for the container
              ),
              width: width80Percent,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email or Phone number',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),

                    controller: myController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),  // Gap between the two input fields
            ElevatedButton(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // here goes function for login
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                backgroundColor: Color.fromARGB(255, 247, 112, 49),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Continue with social media",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Center horizontally
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle first button press
                  },
                  child: Icon(Icons.facebook_outlined),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                ),
                SizedBox(width: 30),  // Gap between the two buttons
                ElevatedButton(
                  onPressed: () {
                    // Handle second button press
                  },
                  child: Icon(Icons.apple),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}