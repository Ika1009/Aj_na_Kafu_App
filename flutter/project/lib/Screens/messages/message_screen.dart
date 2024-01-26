import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class MessagesScreen extends StatefulWidget {
  static String routeName = "/messages";
  final String receiverFirstName;
  final String receiverLastName;
  final String receiverID;
  final String receiverFullName;
  
  const MessagesScreen({
    Key? key,
    required this.receiverFirstName,
    required this.receiverLastName,
    required this.receiverID,
  })  : receiverFullName = '$receiverFirstName $receiverLastName',
        super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Text(
          widget.receiverFirstName,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile2.png"), // ovde treba slika od korisnika
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receiverFullName,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.receiverID, // ovde treba kad je online bio
                style: const TextStyle(fontSize: 12), 
              ),
            ],
          ),
        ],
      ),
    );
  }
}