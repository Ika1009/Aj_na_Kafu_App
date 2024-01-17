import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/components/background.dart';

class LaunchScreen extends StatelessWidget {
  static String routeName = "/launch";
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: SvgPicture.asset('assets/icons/logo.svg'),
      ),
    );
  }
}