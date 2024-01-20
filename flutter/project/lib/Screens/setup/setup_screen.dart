import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/screens/setup/setup_screen_2.dart';

import '../../components/background_setup.dart';
import '../../constants.dart';

class SetupScreen extends StatefulWidget {
  static String routeName = "/setup";
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  TextEditingController usernameController = TextEditingController();
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      if (usernameController.text.isNotEmpty && !showButton) {
        setState(() {
          showButton = true;
        });
      } else if (usernameController.text.isEmpty && showButton) {
        setState(() {
          showButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SetupBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 74,
                height: 54,
              ),
              const Text(
                'Aj Na Kafu',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: defaultPadding * 3),
              const Text(
                'Customize your profile to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'reflect your personality and',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'interests',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: defaultPadding * 3),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundColor,
                    hintText: "Choose a nickname",
                    hintStyle: const TextStyle(
                      color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                      fontWeight: FontWeight.w600,
                    ),
                    suffixIcon: showButton ? Container(
                      margin: const EdgeInsets.all(8), 
                      decoration: BoxDecoration(
                        color: accentColor, 
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: backgroundColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AccountSetupScreen.routeName,
                            arguments: usernameController.text,
                          );
                        },
                      ),
                    ): const SizedBox.shrink(),
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
            ],
          ),
        ),
      ), 
    );
  }
}