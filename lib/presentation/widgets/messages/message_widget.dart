
import 'package:flutter/material.dart';
import 'package:recyclomator/domain/entities/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message, required this.userId});

  final Message message;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == userId;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
