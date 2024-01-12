class MessageModel {
  String message;
  String sender;
  String sender_url = '';

  MessageModel({
    required this.message,
    required this.sender,
    required this.sender_url,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String sender = json['sender'];
    String sender_url = '';
    if (sender == 'BUYER') {
      sender_url = json['buyer']['avatar_url'];
    } else if (sender == 'STORE') {
      sender_url = json['store']['image_url'];
    }

    return MessageModel(
      message: json['message'],
      sender: json['sender'],
      sender_url: sender_url,
    );
  }

  factory MessageModel.fromJsonWithoutImage(Map<String,dynamic> json) {
    return MessageModel(
      message: json['message'],
      sender: json['sender'],
      sender_url: '',
    );
  }

  bool sendByMe() {
    return sender == 'STORE' || sender == 'SELLER';
  }
}
