import 'package:flutter/material.dart';
import 'package:project/screens/setup/components/setup_component.dart';
import 'package:project/screens/setup/components/setup_component_2.dart';
import 'package:project/screens/setup/components/setup_component_3.dart';

class AccountSetupScreen extends StatelessWidget {
  static String routeName = "/account_setup";
  AccountSetupScreen({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          AccountSetup(),
          AccountSetup2(),
          AccountSetup3(),
        ],
      ),
    );
  }
}