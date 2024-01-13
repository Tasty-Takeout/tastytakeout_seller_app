import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String title;
  final String value;

  CustomTextBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: TextEditingController(text: value),
            decoration: InputDecoration(
              labelText: title,
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
