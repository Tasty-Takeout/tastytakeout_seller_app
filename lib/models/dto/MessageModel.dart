class MessageModel {
  String message;
  String sender;

  MessageModel({
    required this.message,
    required this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      sender: json['sender'],
    );
  }

  bool sendByMe() {
    return sender == 'SELLER' || sender == 'STORE';
  }
}
