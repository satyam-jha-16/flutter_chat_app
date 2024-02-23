import "package:flutter/material.dart";

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: isCurrentUser ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(message,
      style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
