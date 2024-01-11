// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController myController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width80Percent = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        toolbarHeight: 200,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,  // Assuming a white background
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
                color: Theme.of(context).colorScheme.secondary,  // Ensure the Container has a background color
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
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),

                    controller: emailController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),

                    controller: passwordController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),  // Gap between the two input fields
            ElevatedButton(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                    // Store a reference to ScaffoldMessenger before the async gap
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    try {
                      print("STARTED");
                      var response = await http.post(
                        Uri.parse('https://bonanza.mycpanel.rs/ajnakafu/login.php'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'email': emailController.text,
                          'password': passwordController.text,
                        }),
                      );
                      print("Response status: ${response.statusCode}");
                      print("Response body: ${response.body}");

                      if (response.statusCode == 200) {
                        final responseData = json.decode(response.body);
                        if (responseData['status'] == 'success') {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text('Login Successful')),
                          );
                          // Navigate to another screen if needed
                        } else {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text('Login Failed: ${responseData['message']}')),
                          );
                        }
                      } else {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Server error: ${response.statusCode}')),
                        );
                      }
                    } catch (e) {
                      print(e.toString());
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('An error occurred')),
                      );
                    }
                  },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Continue with social media",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Center horizontally
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Icon(
                    Icons.apple, 
                    color: Colors.white, 
                  ),
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