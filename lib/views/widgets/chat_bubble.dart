import 'package:flutter/material.dart';

import '../../models/dto/MessageModel.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel messageModel;

  ChatBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
      messageModel.sendByMe() ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: messageModel.sendByMe()
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: messageModel.sendByMe()
                          ? Color.fromARGB(102, 51, 255, 255)
                          : Color.fromARGB(240, 240, 255, 255),
                      border: Border.all(
                        color: messageModel.sendByMe()
                            ? Color.fromARGB(185, 161, 255, 255)
                            : Color.fromARGB(240, 240, 255, 255),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(messageModel.message),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: NetworkImage(messageModel.sender_url),
            ),
          ],
        )
            : Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(messageModel.sender_url),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: messageModel.sendByMe()
                          ? Color.fromARGB(102, 51, 255, 255)
                          : Color.fromARGB(240, 240, 255, 255),
                      border: Border.all(
                        color: messageModel.sendByMe()
                            ? Color.fromARGB(185, 161, 255, 255)
                            : Color.fromARGB(240, 240, 255, 255),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(messageModel.message),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
