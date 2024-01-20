import 'package:flutter/material.dart';
import 'package:project/backgrounds/background_setup_2.dart';

import '../../constants.dart';

class AccountSetupScreen2 extends StatelessWidget {
  static String routeName = "/complete_setup";
  const AccountSetupScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final String username = args is String ? args : 'User';
    return Scaffold(
      body: AccountSetupBackground(
        progressText: '2/3',
        progressValue: 2/3,
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
              const Text(
                'DESCRIPTION:',
                style: TextStyle(
                  color: primaryColor, // dzektor da doda boju
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: defaultPadding / 5),
              SizedBox(
                height: 120,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                    hintText: "Lorem Ipsum...",
                    hintStyle: const TextStyle(
                      color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                      fontWeight: FontWeight.w600,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
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
              const SizedBox(height: defaultPadding),
              const Text(
                'DATE OF BIRTH:',
                style: TextStyle(
                  color: primaryColor, // dzektor da doda boju
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: defaultPadding / 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                        hintText: "27",
                        hintStyle: const TextStyle(
                          color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                        hintText: "January",
                        hintStyle: const TextStyle(
                          color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 46),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                        hintText: "2005",
                        hintStyle: const TextStyle(
                          color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                      ),
                    ),
                  ),
                ],
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
                  // nastavlja account setup
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