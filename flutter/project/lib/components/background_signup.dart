import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/constants.dart';

import 'already_have_an_account_acheck.dart';
import '../screens/signin/signin_screen.dart';

class SignUpBackground extends StatelessWidget {
  final Widget child;
  const SignUpBackground({
    Key? key,
    required this.child,
    this.topImage1 = "assets/icons/vector1.svg",
    this.topImage2 = "assets/icons/vector.svg",
    this.topImage3 = "assets/icons/vector3.svg",
    this.bottomImage1 = "assets/icons/vector10.svg",
    this.bottomImage2 = "assets/icons/vector2.svg",
    this.bottomImage3 = "assets/icons/vector11.svg",
  }) : super(key: key);

  final String topImage1, topImage2, topImage3, bottomImage1, bottomImage2, bottomImage3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                topImage3,
                width: 337.5,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                topImage2,
                width: 225,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                topImage1,
                width: 112.5,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                bottomImage3,
                width: 337.5,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                bottomImage2,
                width: 225,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                bottomImage1,
                width: 112.5,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: defaultPadding * 2),
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: defaultPadding / 3),
                const Text(
                  'Aj Na Kafu',
                  style: TextStyle(
                    color: Color(0xFF0C3B2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              child: AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignInScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            SafeArea(child: child),
          ],
        ),  
      ),
    );
  }
}