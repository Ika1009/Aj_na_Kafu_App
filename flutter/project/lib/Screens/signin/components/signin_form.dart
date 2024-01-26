import 'package:flutter/material.dart';
import 'package:project/components/snackbars.dart';
import 'package:project/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          MySnackBars.warningSnackBar(
            e.toString(),
          )
        );
      }
  }

  @override
  void dispose() { 
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                color: Color(0xFF757575), // dzektor da doda boju i da se zameni
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
                  color: Color(0xFF757575), // dzektor da doda boju i da se zameni
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
            onPressed: () async {
              await login();
            },
            child: const Text(
              "Sign In",
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
