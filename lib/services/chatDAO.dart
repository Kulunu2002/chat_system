import 'package:assignment_2/utils/databaseSetup.dart';
import 'package:get/get.dart';
import '../models/chat.dart';

var dbConnection;
var chatList = <Chat>[].obs;

class ChatDAO {
  Future<int> insertChat(Chat chat) async {
    int outputID = -1;
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    await dbConnection.transaction((txn) async {
      outputID = await txn.rawInsert(
          'INSERT INTO Chat( user1id, user2id , messages , sender) VALUES("${chat.user1id}" , "${chat.user2id}" , "${chat.messages}" , "${chat.sender}")');
    });
    print("inserted:$outputID");
    return outputID;
  }

  Future<List<Map>> readChat() async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM Chat');
    chatList.addAll(list.map(
      (chat) => Chat(
          chatid: chat['chatid'],
          user1id: chat['user1id'],
          user2id: chat['user2id'],
          messages: chat['messages'],
          sender: chat['sender']),
    ));
    return list;
  }
}
