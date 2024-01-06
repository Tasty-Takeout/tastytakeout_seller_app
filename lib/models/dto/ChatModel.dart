import 'MessageModel.dart';

class ChatModel {
  String user_name;
  String user_image;
  List<MessageModel> messages;

  ChatModel({
    required this.user_name,
    required this.user_image,
    required this.messages,
  });

}