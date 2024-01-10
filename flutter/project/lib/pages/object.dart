import 'package:flutter/material.dart';
import 'package:project/util/card.dart';

class ObjectPage extends StatelessWidget {
  const ObjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomCard(), 
      ),
    );
  }
}