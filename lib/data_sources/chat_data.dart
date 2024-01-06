import '../models/dto/ChatModel.dart';
import '../models/dto/MessageModel.dart';

class ChatSampleData {
  List<ChatModel> getData() {
    return chatData;
  }

  final List<ChatModel> chatData = [
    ChatModel(
      user_name: "User1",
      user_image: "lib/resources/user_image1.png",
      messages: [
        MessageModel(
          message: "Sample message 1 from them",
          time: "08:29",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 2 from me",
          time: "08:24",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 3 from them",
          time: "08:19",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 4 from me",
          time: "08:14",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 5 from them",
          time: "08:09",
          sendByMe: false,
        ),
      ],
    ),
    ChatModel(
      user_name: "User2",
      user_image: "lib/resources/user_image2.png",
      messages: [
        MessageModel(
          message: "Sample message 1 from them",
          time: "08:29",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 2 from me",
          time: "08:24",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 3 from them",
          time: "08:19",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 4 from me",
          time: "08:14",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 5 from them",
          time: "08:09",
          sendByMe: false,
        ),
      ],
    ),
    ChatModel(
      user_name: "User3",
      user_image: "lib/resources/user_image3.png",
      messages: [
        MessageModel(
          message: "Sample message 1 from them",
          time: "08:29",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 2 from me",
          time: "08:24",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 3 from them",
          time: "08:19",
          sendByMe: false,
        ),
        MessageModel(
          message: "Sample message 4 from me",
          time: "08:14",
          sendByMe: true,
        ),
        MessageModel(
          message: "Sample message 5 from them",
          time: "08:09",
          sendByMe: false,
        ),
      ],
    ),
  ];
}
