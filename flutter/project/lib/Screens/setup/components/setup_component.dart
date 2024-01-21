import 'package:flutter/material.dart';
import 'package:project/backgrounds/background_setup_2.dart';

import '../../../constants.dart';
import 'setup_component_2.dart';

class AccountSetup extends StatelessWidget {
  const AccountSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final String username = args is String ? args : 'User';
    return Scaffold(
      body: AccountSetupBackground(
        progressText: '1/3',
        progressValue: 1/3,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $username!',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
              const Text(
                'Great, just few more steps...',
                style: TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: defaultPadding * 4),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                  hintText: "First Name",
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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                    hintText: "Last Name",
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
              TextFormField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                  hintText: "Phone Number",
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
              const SizedBox(height: defaultPadding * 4),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(backgroundColor),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), 
                      side: const BorderSide(color: accentColor, width: 2.0), 
                    ),
                  ),
                ),
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountSetup2()),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}