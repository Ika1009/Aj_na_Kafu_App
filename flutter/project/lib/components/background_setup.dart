import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class SetupBackground extends StatelessWidget {
  final Widget child;
  const SetupBackground({
    Key? key,
    required this.child,
    this.topImage = "assets/icons/vector13.svg",
    this.bottomImage = "assets/icons/vector12.svg",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MediaQuery.of(context).size.width > 435 ? const Color(0xFFE9FAEF): backgroundColor, // dzektor da doda boju
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 95,
              child: SvgPicture.asset(
                topImage,
                width: MediaQuery.of(context).size.width < 435 ? MediaQuery.of(context).size.width : 0, // pozadina je samo za mobilne uredjaje
              ),
            ),
            Positioned(
              bottom: 95,
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