import 'package:flutter/material.dart';
import 'package:project/backgrounds/background_setup_2.dart';

import '../../../constants.dart';

class AccountSetup3 extends StatelessWidget {
  const AccountSetup3({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final String username = args is String ? args : 'User';
    return Scaffold(
      body: AccountSetupBackground(
        progressText: '3/3',
        progressValue: 3/3,
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
                'PROFILE IMAGE:',
                style: TextStyle(
                  color: primaryColor, // dzektor da doda boju
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
                  // kraj account setupa
                },
                child: const Text(
                  "Finish",
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