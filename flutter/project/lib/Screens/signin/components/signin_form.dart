import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
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
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print("Network Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
              hintText: "Enter your email...",
              hintStyle: TextStyle(
                color: Color(0xFF709E76), // dzektor da doda boju i da se zameni
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                hintText: "Enter you password...",
                hintStyle: TextStyle(
                  color: Color(0xFF709E76), // dzektor da doda boju i da se zameni
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(accentColor),
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 62)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), 
                ),
              ),
            ),
            onPressed: () async {
              await login();
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
