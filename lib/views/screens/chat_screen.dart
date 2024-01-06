import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ChatScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/chat_detail_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_items.dart';

import '../../models/dto/ChatModel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ChatScreenViewModel());
  }
}

class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModel = Get.put(ChatScreenViewModel());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ChatPage',
      ),
      drawer: CustomDrawer(),
      body: Obx(
            () {
          if (viewModel.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            var items = viewModel.chatList;
            var time = viewModel.chatListDate;
            String lastMessage = "";
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (items[index].sender == "STORE") {
                  lastMessage = "You: " + items[index].newest_message;
                } else {
                  lastMessage = items[index].newest_message;
                }
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff73b5c9),
                  ),
                  child: InkWell(
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color(0xff8692a2);
                      }
                      return Color(0xff73b5c9);
                    }),
                    onTap: () {
                      print("Tapped on container $index");
                      print(items[index]);
                      Get.to(ChatDetailScreen(), arguments: items[index].chat_room_id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: ChatItems(
                        UserName: (items.value)[index].store.name,
                        UserMessage: lastMessage,
                        UserImage: (items.value)[index].store.image_url,
                        UserTime: (time.value)[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
