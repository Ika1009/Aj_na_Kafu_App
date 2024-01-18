import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    const String apiUrl = 'https://bonanza.mycpanel.rs/ajnakafu/create_account.php'; // Replace with your actual API endpoint URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successful signup
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        // Account created successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle other success cases or error cases from the API
        // You can customize the error handling based on the API response.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Handle HTTP error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign up. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
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
              fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
              hintText: "Enter your email...",
              hintStyle: const TextStyle(
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
                fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                hintText: "Enter you password...",
                hintStyle: const TextStyle(
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
              minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            onPressed: signUp, // Call the signUp function when the button is pressed
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
