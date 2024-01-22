import 'package:flutter/material.dart';
import 'package:project/models/user_data.dart';

import '../../../constants.dart';

class AccountSetup3 extends StatelessWidget {
  final UserData userData;
  const AccountSetup3({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;
    // za iliju doncica ovde ti se nalaze sve varijable i dole ti je dugme finish gde ce ti se zavrsi registracija
    print(data.email);
    print(data.password);
    print(data.userName);
    print(userData.firstName);
    print(userData.lastName);
    print(userData.dateOfBirth);
    print(userData.phoneNumber);
    print(userData.description);
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${data.userName}',
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
    );
  }
}