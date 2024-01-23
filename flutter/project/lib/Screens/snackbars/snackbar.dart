import 'package:flutter/material.dart';
import 'package:project/components/snackbars.dart';

class FinalView extends StatefulWidget {
  static String routeName = "/snackbars";
  const FinalView({Key? key}) : super(key: key);

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        centerTitle: true,
        title: const Text("Custom Snackbar"),
      ),
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Failure
            MaterialButton(
              color: const Color(0xffc72c41),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBars.failureSnackBar);
              },
              child: const Text(
                "Open SnackBar - 🔴 Failure ",
                style: TextStyle(color: Colors.white),
              ),
            ),

            /// Help
            MaterialButton(
              color: const Color(0xff3282B8),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBars.helpSnackBar);
              },
              child: const Text(
                "Open SnackBar - ❔ Help ",
                style: TextStyle(color: Colors.white),
              ),
            ),

            /// Success
            MaterialButton(
              color: const Color(0xff2D6A4F),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBars.successSnackBar);
              },
              child: const Text(
                "Open SnackBar - ✅ Success ",
                style: TextStyle(color: Colors.white),
              ),
            ),

            /// Warning
            MaterialButton(
              color: const Color(0xffFCA652),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBars.warningSnackBar);
              },
              child: const Text(
                "Open SnackBar - ⚠ Warning",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}