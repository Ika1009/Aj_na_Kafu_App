import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width80Percent = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 15), // Adjust top and left padding as needed
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 16, // Smaller icon size
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ),
        ),
        flexibleSpace: Image.asset(
          'assets/images/room.jpg', // Replace with your image path
          fit: BoxFit.cover,
        ),
        toolbarHeight: 250, // Adjust as needed
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0C3B2E),  // Assuming a white background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Container(
              width: double.infinity, // Full width of the screen
              child: Column(
                children: [
                  Container(
                    width: width80Percent,
                    child: Text(
                      "Miami St beach front, Myrtle Beach at the resort and hotel in front of GC Lab.",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}