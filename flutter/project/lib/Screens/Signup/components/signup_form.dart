import 'package:flutter/material.dart';
import 'package:project/components/snackbars.dart';
import 'package:project/models/user_data.dart';
import 'package:project/screens/setup/setup_screen.dart';
import 'package:project/services/auth_service.dart';

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              hintText: "Unesi mejl...",
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
                hintText: "Unesi lozinku...",
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
              String email = emailController.text.trim();
              String password = passwordController.text.trim();

              // Regular expression to check for forbidden characters
              RegExp forbiddenChars = RegExp(r'[!#$%^&*(),?":{}|<> ]');

              try {
                // Check for forbidden characters in the email
                if (forbiddenChars.hasMatch(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBars.warningSnackBar("Nevažeća Imejl Adresa", "Nevažeći karakteri u imejl adresi"),
                  );
                  return; // Stop further execution
                }

                // Check if the email already exists
                bool emailExists = await AuthService().doesEmailExist(email);
                if (emailExists) {
                  // Show a custom Snackbar if the email already exists
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBars.warningSnackBar("Već postoji takva imejl adresa", 
                    "Molimo vas da koristite drugu imejl adresu ili se prijavite")
                  );
                } else {
                  // Proceed with the registration if the email doesn't exist
                  UserData userData = UserData(
                    email: email,
                    password: password,
                  );
                  
                  if (!context.mounted) return;
                  Navigator.pushNamed(
                    context,
                    SetupScreen.routeName,
                    arguments: userData,
                  );
                }
              } catch (e) {
                // Handle exceptions from AuthService
                ScaffoldMessenger.of(context).showSnackBar(
                  MySnackBars.warningSnackBar("Greška", "Došlo je do greške"),
                );
              }
            },

            child: const Text(
              "Registruj se",
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
