import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: login ? "Nemaš nalog? " : "Već imaš nalog? ",
            style: const TextStyle(
              color: Color(0xFF757575), // dzektor da doda boju
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text.rich(
            TextSpan(
              text: login ? "Registruj se" : "Prijavi se",
              style: const TextStyle(
                color: accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
