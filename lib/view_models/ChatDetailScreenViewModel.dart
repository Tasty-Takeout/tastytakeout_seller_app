import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/models/dto/ChatModel.dart';
import 'package:tastytakeout_user_app/view_models/ChatScreenViewModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/dto/MessageModel.dart';

class ChatDetailScreenViewModel extends GetxController {
  var chatMessage = RxList<MessageModel>();
  final BASE_URL = 'http://10.0.2.2:8000/chat/';
  final BASE_URL_WS = 'ws://10.0.2.2:8000/ws/chat/';
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg2MDAyNDYwLCJpYXQiOjE3MDQ1NjI0NjAsImp0aSI6ImNmNzVkMmQ0MWY2NDQzZjg4M2M1NmJkNzU2NWI5NDk2IiwidXNlcl9pZCI6MTEsInJvbGUiOiJTRUxMRVIiLCJzdG9yZV9pZCI6Mn0.ewntBGHVz4Grgs5tb3JQqiZMkPwcrwNDHeavAgBLDSo';
  String chatRoom = '';
  late WebSocketChannel channel;
  final ScrollController scrollController = ScrollController();
  var isLoading = true.obs;

  ChatDetailScreenViewModel(String chatRoom) {
    this.chatRoom = chatRoom;
  }

  @override
  void onInit() {
    getChatMessages();
    channel = WebSocketChannel.connect(
      Uri.parse(BASE_URL_WS + chatRoom + '/?token=' + token),
    );
    startListening();
    super.onInit();
  }

  void scrollToBottom(int time) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: time),
      curve: Curves.easeOut,
    );
  }

  void scrollToTop(int time) {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: time),
      curve: Curves.easeOut,
    );
  }

  Future<void> getChatMessages() async {
    print(BASE_URL + chatRoom);
    try {
      isLoading(true);
      final response = await get(
        Uri.parse(BASE_URL + chatRoom),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization' : 'Bearer ' + token
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching chat messages');
      } else {
        List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        chatMessage.value = json.map((e) => MessageModel.fromJson(e)).toList();
        chatMessage.value = chatMessage.value.reversed.toList();
      }
    } catch (e) {
      print('Error in getChatMessages ' + e.toString());
    } finally {
      isLoading(false);
    }
  }

  void startListening() {
    channel.stream.handleError((error) {
      print('Có lỗi xảy ra: $error');
    }).listen((message) {
      Get.find<ChatScreenViewModel>().fetchChatList();
      chatMessage.insert(0,MessageModel.fromJson(jsonDecode(message)));
      print('Tin nhắn mới: $message');
    }, onDone: () {
      print('WebSocket kết nối đã đóng');
    });
  }

  void sendMessage(String text) {
    final message = json.encode({'message': text,'role' : 'STORE'});
    channel.sink.add(message);
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }


}

