import 'MessageModel.dart';

class ChatModel {
  int id;
  String chat_room_id;
  String newest_message;
  String newest_message_time;
  String sender;
  Store store;
  Buyer buyer;
  DateTime? created_at;

  ChatModel({
    required this.id,
    required this.chat_room_id,
    required this.newest_message,
    required this.newest_message_time,
    required this.sender,
    required this.store,
    required this.buyer,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      chat_room_id: json['chat_room_id'],
      newest_message: json['message'],
      newest_message_time: json['created_at'],
      sender: json['sender'],
      buyer: Buyer.fromJson(json['buyer']),
      store: Store.fromJson(json['store']),
    );
  }

}

class Store {
  int id = 0;
  String name = '';
  String image_url = '';

  Store({
    required this.id,
    required this.name,
    required this.image_url,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      image_url: json['image_url'],
    );
  }
}

class Buyer {
  int id = 0;
  String name = '';
  String username = '';
  String image_url = '';

  Buyer({
    required this.id,
    required this.username,
    required this.image_url,
    required this.name,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      id: json['id'],
      name: json['name'],
      image_url: json['avatar_url'],
      username: json['username'],
    );
  }
}