import 'package:flutter/material.dart';
import 'package:project/components/snackbars.dart';
import 'package:project/models/user_data.dart';

import '../../../constants.dart';

class AccountSetup2 extends StatefulWidget {
  final Function(UserData) onNextPage;
  final UserData userData;
  const AccountSetup2({Key? key, required this.onNextPage, required this.userData}) : super(key: key);

  @override
  State<AccountSetup2> createState() => _AccountSetup2State();
}

class _AccountSetup2State extends State<AccountSetup2> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zdravo, ${data.username}!',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
            ),
          ),
          const Text(
            'Odlično, još samo nekoliko koraka...',
            style: TextStyle(
              color: Color(0xFF757575), // dzektor da doda boju
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
              hintText: "Broj telefona",
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
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
              hintText: "Opis...",
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
          const SizedBox(height: defaultPadding * 4),
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
            onPressed: () {
              String phoneNumber = phoneNumberController.text.trim();
              String description = descriptionController.text.trim();

              // Regular expression to check for valid phone number format
              RegExp validPhoneNumber = RegExp(r'^(?:\+381|381|06)\d{6,}$');

              try {
                // Check for valid phone number format and prefix
                if (!validPhoneNumber.hasMatch(phoneNumber)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBars.warningSnackBar(
                      "Nevažeći broj telefona",
                      "Broj telefona mora početi sa '+381', '381' ili '06', i sadržati barem 7 cifara.",
                    ),
                  );
                  return; // Stop further execution
                }

                // Check for a valid description (you can customize this check based on your requirements)
                if (description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBars.warningSnackBar(
                      "Opis je obavezan",
                      "Molimo vas da unesete opis",
                    ),
                  );
                  return; // Stop further execution
                }

                // Proceed with further actions
                widget.userData.phoneNumber = phoneNumber;
                widget.userData.description = description;
                widget.onNextPage(widget.userData);
              } catch (e) {
                // Handle exceptions if necessary
                ScaffoldMessenger.of(context).showSnackBar(
                  MySnackBars.warningSnackBar(
                    "Došlo je do greške",
                    "Molimo vas da pokušate ponovo kasnije",
                  ),
                );
              }
            },

            child: const Text(
              "Nastavi",
              style: TextStyle(
                color: backgroundColor,
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