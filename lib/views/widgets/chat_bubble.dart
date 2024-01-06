import 'package:flutter/material.dart';

import '../../models/dto/MessageModel.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel messageModel;

  ChatBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messageModel.sendByMe() ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: messageModel.sendByMe() ? Colors.white : Colors.grey.shade200,
        ),
        padding: EdgeInsets.all(16),
        child: Text(messageModel.message),
      ),
    );
  }
}
