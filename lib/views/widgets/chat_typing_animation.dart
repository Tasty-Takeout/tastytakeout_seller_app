import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../models/dto/MessageModel.dart';

class ChatTypingAnimation extends StatelessWidget {
  ChatTypingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(240, 240, 255, 255),
            border: Border.all(
              color: Color.fromARGB(240, 240, 255, 255),
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Typing message...',
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                speed: Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
          ),
        ),
      ),
    );
  }
}
