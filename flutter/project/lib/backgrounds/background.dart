import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
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
            SafeArea(child: child),
          ],
        ),  
      ),
    );
  }
}