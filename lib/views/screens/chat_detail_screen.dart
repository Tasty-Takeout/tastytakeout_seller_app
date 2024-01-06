import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dto/MessageModel.dart';
import '../../view_models/ChatDetailScreenViewModel.dart';
import '../widgets/chat_bubble.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  String chatRoomId = '';
  late TextEditingController messageController = TextEditingController();
  late ChatDetailScreenViewModel chatDetailScreenViewModel;

  @override
  void dispose() {
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chatRoomId = Get.arguments;
    chatDetailScreenViewModel = Get.put(ChatDetailScreenViewModel(chatRoomId));
    print('chatDetailScreenViewModel.chatMessage.length: ' +
        chatDetailScreenViewModel.chatMessage.length.toString());
    for (int i = 0; i < chatDetailScreenViewModel.chatMessage.length; i++) {
      print(chatDetailScreenViewModel.chatMessage[i].message);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatDetailScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
                () {
              if (chatDetailScreenViewModel.isLoading.value) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: chatDetailScreenViewModel.scrollController,
                    itemCount: chatDetailScreenViewModel.chatMessage.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        messageModel:
                        chatDetailScreenViewModel.chatMessage[index],
                      );
                    },
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      controller: messageController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      chatDetailScreenViewModel
                          .sendMessage(messageController.text);
                      messageController.text = '';
                      // chatDetailScreenViewModel.scrollToTop(300);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
