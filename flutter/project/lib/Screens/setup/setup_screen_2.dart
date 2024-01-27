import 'package:flutter/material.dart';
import 'package:project/backgrounds/background_setup_2.dart';
import 'package:project/models/user_data.dart';
import 'package:project/screens/setup/components/setup_component.dart';
import 'package:project/screens/setup/components/setup_component_2.dart';
import 'package:project/screens/setup/components/setup_component_3.dart';

class NoScrollPhysics extends ScrollPhysics {
  const NoScrollPhysics({ ScrollPhysics? parent }) : super(parent: parent);

  @override
  NoScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return false;
  }
}

class AccountSetupScreen extends StatefulWidget {
  static String routeName = "/account_setup";
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  UserData? _userData;

  @override
  void initState() {
    super.initState();
    _userData = UserData(
      email: 'Mejl',
      password: 'Lozinka',
      userName: 'Korisničko ime',
      firstName: 'Ime',
      lastName: 'Prezime',
      dateOfBirth: 'Datum rođenja',
      phoneNumber: 'Broj telefona',
      description: 'Opis',
    );

    _controller.addListener(() {
      int currentPage = _controller.page!.round();
      if (currentPage != _currentPage) {
        setState(() {
          _currentPage = currentPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNextPage(UserData userData) {
    setState(() {
      _userData = userData;
    });

    if (_controller.hasClients) {
      _controller.animateToPage(
        _controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String progressText = '${_currentPage + 1}/3';
    double progressValue = (_currentPage + 1) / 3;

    return AccountSetupBackground(
      progressText: progressText,
      progressValue: progressValue,
      child: PageView(
        controller: _controller,
        physics: const NoScrollPhysics(),
        children: [
          AccountSetup(onNextPage: _goToNextPage, userData: _userData!),
          AccountSetup2(onNextPage: _goToNextPage, userData: _userData!),
          AccountSetup3(userData: _userData!),
        ],
      ),
    );
  }
}