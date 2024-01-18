import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/background_setup.dart';
import '../../constants.dart';

class SetupScreen extends StatelessWidget {
  static String routeName = "/setup";
  const SetupScreen({super.key});

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
              ),
            ],
          ),
        ),
      ), 
    );
  }
}