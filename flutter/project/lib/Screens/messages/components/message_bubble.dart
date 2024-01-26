import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: primaryColor
      ),
      child: Text(
        message, 
        style: const TextStyle(
          fontSize: 16,
          color: backgroundColor,
        ),
      ),
    );
  }
}