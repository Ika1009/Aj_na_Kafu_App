import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: const SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: "Type message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Icon(Icons.arrow_forward, color: primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
