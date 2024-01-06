import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../helper/date_helper.dart';
import '../models/dto/ChatModel.dart';

class ChatScreenViewModel extends GetxController {
  var isLoading = true.obs;
  var chatList = RxList<ChatModel>();
  var chatListDate = RxList<String>();
  final BASE_URL = 'http://10.0.2.2:8000/chat';

  @override
  void onInit() {
    fetchChatList();
    super.onInit();
  }

  void formatChatListDate() {
    for (int i = 0; i < chatList.value.length; i++) {
      chatList.value[i].created_at = DateTime.parse(chatList.value[i].newest_message_time);
      Date date = DateHelper.getDate(chatList.value[i].created_at!);
      if (date == Date.TODAY) {
        chatListDate.value.add('Today');
      } else if (date == Date.YESTERDAY) {
        chatListDate.value.add('Yesterday');
      } else {
        String date = chatList.value[i].created_at!.day.toString() +
            '/' +
            chatList.value[i].created_at!.month.toString();
        chatListDate.value.add(date);
      }
    }
  }

  Future<void> fetchChatList() async {
    try {
      isLoading(true);
      final response = await get(
        Uri.parse(BASE_URL),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg2MDAyNDYwLCJpYXQiOjE3MDQ1NjI0NjAsImp0aSI6ImNmNzVkMmQ0MWY2NDQzZjg4M2M1NmJkNzU2NWI5NDk2IiwidXNlcl9pZCI6MTEsInJvbGUiOiJTRUxMRVIiLCJzdG9yZV9pZCI6Mn0.ewntBGHVz4Grgs5tb3JQqiZMkPwcrwNDHeavAgBLDSo'
        });
      if (response.statusCode != 200) {
        throw Exception('Error fetching chat list');
      } else {
        List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        chatList.value = json.map((e) => ChatModel.fromJson(e)).toList();
        formatChatListDate();
      }
    } catch (e) {
      print('Error in fetchChatList ' + e.toString());
      print(chatList.value);
    } finally {
      isLoading(false);
    }
  }
}