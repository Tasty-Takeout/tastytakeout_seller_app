import 'package:flutter/material.dart';

class ChatItems extends StatelessWidget {
  final String UserName;
  final String UserMessage;
  final String UserImage;
  final String UserTime;

  const ChatItems({
    super.key,
    required this.UserName,
    required this.UserMessage,
    required this.UserImage,
    required this.UserTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(UserImage),
                maxRadius: 30,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(UserName),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        UserMessage,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade700),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                UserTime,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider()
        ],
      ),
    );
  }
}
