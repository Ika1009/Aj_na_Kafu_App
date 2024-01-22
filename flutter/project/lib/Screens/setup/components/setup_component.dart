import 'package:flutter/material.dart';
import 'package:project/models/user_data.dart';

import '../../../constants.dart';

class AccountSetup extends StatefulWidget {
  final Function(UserData) onNextPage;
  final UserData userData;
  const AccountSetup({Key? key, required this.onNextPage, required this.userData}) : super(key: key);

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  String selectedDay = '21';
  String selectedMonth = 'January';
  String selectedYear = '2024';

  final List<String> days = List<String>.generate(31, (i) => '${i + 1}');
  final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final List<String> years = List<String>.generate(101, (i) => '${i + 1924}');

  @override
  Widget build(BuildContext context) {
    final UserData data = ModalRoute.of(context)!.settings.arguments as UserData;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${data.userName}!',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
            ),
          ),
          const Text(
            'Great, just few more steps...',
            style: TextStyle(
              color: Color(0xFF757575), // dzektor da doda boju
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          TextFormField(
            controller: firstNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
              hintText: "First Name",
              hintStyle: const TextStyle(
                color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
                borderSide: BorderSide.none, 
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: lastNameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD6E6DA), // dzektor da doda boju i da se zameni
                hintText: "Last Name",
                hintStyle: const TextStyle(
                  color: Color(0xFF757575), // dzektor da doda boju i da se zameni
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), 
                  borderSide: BorderSide.none, 
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFD6E6DA), 
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DropdownButton<String>(
                  value: selectedDay,
                  items: days.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDay = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(color: Colors.white),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: months.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(color: Colors.white),
                ),
                DropdownButton<String>(
                  value: selectedYear,
                  items: years.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding * 4),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              minimumSize: MaterialStateProperty.all(const Size(double.infinity, 62)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), 
                  side: const BorderSide(color: accentColor, width: 2.0), 
                ),
              ),
            ),
            onPressed: ()  {
              widget.userData.firstName = firstNameController.text;
              widget.userData.lastName = lastNameController.text;
              widget.userData.dateOfBirth = "$selectedDay-$selectedMonth-$selectedYear";
              widget.onNextPage(widget.userData);
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}