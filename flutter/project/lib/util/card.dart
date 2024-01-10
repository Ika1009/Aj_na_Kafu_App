import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.4; 
    double width80Percent = MediaQuery.of(context).size.width * 0.8; 

    return Scaffold(
      body: Column( 
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/room.jpg'),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                top: appBarHeight - 50, 
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 40), 
                  decoration: BoxDecoration(
                    color: Color(0xFF0C3B2E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              width: width80Percent,
                              child: Text(
                                "Miami St beach front, Myrtle Beach at the resort and hotel in front of GC Lab.",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30, 
                left: 20, 
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 16, 
                  color: Colors.white,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
