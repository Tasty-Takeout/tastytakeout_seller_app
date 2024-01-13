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
  final ChatScreenViewModel viewModel = Get.put(ChatScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenViewModel>(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Nhắn tin',
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
                  padding: EdgeInsets.all(10),
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
                        overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Color(0xff8692a2);
                          }
                          return Color(0xff73b5c9);
                        }),
                        onTap: () {
                          print("Tapped on container $index");
                          print(items[index]);
                          Get.to(ChatDetailScreen(), arguments: {
                            'chat_room_id': items[index].chat_room_id,
                            'buyer_id': items[index].buyer.id,
                            'buyer_name': items[index].buyer.name,
                            'buyer_image_url': items[index].buyer.image_url,
                            'store_image_url': items[index].store.image_url,
                          })?.then((value) {
                            viewModel.fetchChatList();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: ChatItems(
                            UserName: (items.value)[index].buyer.name,
                            UserMessage: lastMessage,
                            UserImage: (items.value)[index].buyer.image_url,
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
      },
    );
  }
}
