import 'package:assignment_2/models/chat.dart';
import 'package:assignment_2/services/chatDAO.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatList = <Chat>[].obs;
  var chatM = Chat().obs;

  void insertChat(
      {String? user1id,
      String? user2id,
      String? messages,
      String? sender}) async {
    Chat chat = Chat(
        user1id: user1id, user2id: user2id, messages: messages, sender: sender);
    ChatDAO chatDAO = ChatDAO();
    int id = await chatDAO.insertChat(chat);
    chat.chatid = id;
    chatList.add(chat);
  }

  void readChat() async {
    ChatDAO chatDAO = ChatDAO();
    List<Map> result = await chatDAO.readChat();
    for (Map chat in result) {
      if (result == null) {
        return null;
      } else {
        Chat chatModel = Chat(
          chatid: chat["chatid"],
          user1id: chat["user1id"], 
          user2id: chat["user2id"], 
          messages: chat["messages"], 
          sender: chat["sender"],
        );
        chatList.add(chatModel); 
      }
    }
  }
}
