import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              Text('Signup', style: TextStyle(fontSize: 35)),
              SizedBox(height: 10),
              Text('Create your account', style: TextStyle(fontSize: 20)),
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
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    controller: usernameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
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
                    obscureText: true,
                    controller: passwordController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(
                "Signup",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // here goes function for signup
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
              "Signup with social media",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            // Social media buttons (if needed)
          ],
        ),
      ),
    );
  }
}
