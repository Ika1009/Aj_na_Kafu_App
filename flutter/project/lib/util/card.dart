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
                  padding: EdgeInsets.only(top: 20), 
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
                      SizedBox(height: 150),
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
              Positioned(
                top: 240, 
                left: 38, 
                child: Text(
                  "Miami St Hotel",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Positioned(
                top: 280, 
                left: 26, 
                child: IconButton(
                  icon: Icon(Icons.star_rounded),
                  iconSize: 20, 
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Positioned(
                top: 280, 
                left: 44, 
                child: IconButton(
                  icon: Icon(Icons.star_rounded),
                  iconSize: 20, 
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Positioned(
                top: 280, 
                left: 62, 
                child: IconButton(
                  icon: Icon(Icons.star_rounded),
                  iconSize: 20, 
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Positioned(
                top: 280, 
                left: 80, 
                child: IconButton(
                  icon: Icon(Icons.star_rounded),
                  iconSize: 20, 
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Positioned(
                top: 280, 
                left: 98, 
                child: IconButton(
                  icon: Icon(Icons.star_rounded),
                  iconSize: 20, 
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Positioned(
                top: 330,
                left: 38,
                child: Image.asset(
                  'assets/images/profile1.png',
                  width: 30, 
                  height: 30,
                ),
              ),
              Positioned(
                top: 330,
                left: 64,
                child: Image.asset(
                  'assets/images/profile2.png',
                  width: 30, 
                  height: 30,
                ),
              ),
              Positioned(
                top: 330,
                left: 90,
                child: Image.asset(
                  'assets/images/profile3.png',
                  width: 30, 
                  height: 30,
                ),
              ),
              Positioned(
                top: 330,
                left: 116,
                child: Image.asset(
                  'assets/images/profile4.png',
                  width: 30, 
                  height: 30,
                ),
              ),
              Positioned(
                top: 285,
                left: 260,
                child: SizedBox(
                  width: 70, 
                  height: 30, 
                  child: TextButton(
                    onPressed: null, 
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFFFBA00)), 
                      foregroundColor: MaterialStateProperty.all(Color(0xFF0C3B2E)), 
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), 
                        ),
                      ),
                    ),
                    child: Text("4 Star"),
                  ),
                ),
              ),
              Positioned(
                top: 340, 
                left: 250, 
                child: Text(
                  "39 reviewes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
