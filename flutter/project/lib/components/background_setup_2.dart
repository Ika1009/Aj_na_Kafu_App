import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/constants.dart';

class AccountSetupBackground extends StatelessWidget {
  final Widget child;
  const AccountSetupBackground({
    Key? key,
    required this.child,
    this.topImage = "assets/icons/vector15.svg",
    this.bottomImage = "assets/icons/vector14.svg",
  }) : super(key: key);

  final String topImage, bottomImage;

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
              child: SvgPicture.asset(
                topImage,
                width: MediaQuery.of(context).size.width < 435 ? MediaQuery.of(context).size.width : 0, // pozadina je samo za mobilne uredjaje
              ),
            ),
            Positioned(
              top: 45,
              left: 40,
              right: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 1/3,
                  backgroundColor: MediaQuery.of(context).size.width < 435 ? backgroundColor : Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF90B697)),
                  minHeight: 8.0,
                ),
              ),
            ),
            const Positioned(
              top: 37,
              right: 50,
              child: Text(
                '1/3',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                bottomImage,
                width: MediaQuery.of(context).size.width < 435 ? MediaQuery.of(context).size.width : 0, // pozadina je samo za mobilne uredjaje
              ),
            ),
            SafeArea(child: child),
          ],
        ),  
      ),
    );
  }
}