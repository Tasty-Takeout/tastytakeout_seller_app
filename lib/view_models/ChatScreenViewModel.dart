import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/globals.dart';
import '../data_sources/hardcode.dart' as data;
import '../helper/date_helper.dart';
import '../models/dto/ChatModel.dart';

class ChatScreenViewModel extends GetxController {
  var isLoading = true.obs;
  var chatList = RxList<ChatModel>();
  var chatListDate = RxList<String>();
  final BASE_URL = 'http://${serverIp}/chat';
  String token = data.accessKey;


  @override
  void onInit() {
    fetchChatList();
    super.onInit();
  }

  void formatChatListDate() {
    for (int i = 0; i < chatList.value.length; i++) {
      chatList.value[i].created_at =
          DateTime.parse(chatList.value[i].newest_message_time);
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
      final response = await get(Uri.parse(BASE_URL), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Charset': 'UTF-8',
        'Authorization':
            'Bearer ${token}'
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
