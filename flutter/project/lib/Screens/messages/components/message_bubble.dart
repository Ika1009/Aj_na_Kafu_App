import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final Color color;
  const MessageBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
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