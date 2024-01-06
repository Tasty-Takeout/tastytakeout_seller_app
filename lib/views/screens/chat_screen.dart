import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/chat_data.dart';

import '../../models/dto/ChatModel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class ChatController extends GetxController {
  final title = 'Chat'.obs;
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}

class ChatPage extends StatelessWidget {
  final List<ChatModel> items = ChatSampleData().getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ChatPage',
      ),
      drawer: CustomDrawer(),
      body: SizedBox(),
    );
  }
}
