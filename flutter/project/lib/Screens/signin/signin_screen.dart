import 'package:flutter/material.dart';
import 'package:project/responsive.dart';

import '../../components/background_signin.dart';
import 'components/signin_form.dart';
import 'components/signin_screen_top_image.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/signin";
  const SignInScreen  ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignInBackground(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignInScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignInScreen extends StatelessWidget {
  const MobileSignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
