import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/components/background.dart';
import 'package:project/constants.dart';
import 'package:project/screens/setup/setup_screen.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetY;

  const CustomFabLocation(this.location, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset originalOffset = location.getOffset(scaffoldGeometry);
    return Offset(originalOffset.dx, originalOffset.dy - offsetY);
  }
}

class LaunchScreen extends StatelessWidget {
  static String routeName = "/launch";
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/logo.svg'),
              const Text(
                'Aj Na Kafu',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.80,
                ),
              ),
              const Text(
                'Kod Vas ili kod nas?',
                style: TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SetupScreen.routeName);
        },
        backgroundColor: accentColor, 
        child: const Icon(Icons.arrow_downward), 
      ),
      floatingActionButtonLocation: const CustomFabLocation(
        FloatingActionButtonLocation.centerFloat, 
        80,
      ),
    );
  }
}
