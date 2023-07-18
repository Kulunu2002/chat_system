import 'package:assignment_2/controller/userController.dart';
import 'package:assignment_2/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chatController.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.user1id, required this.name})
      : super(key: key);

  final String user1id;
  final String name;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController sendMsgController = TextEditingController();
  var userController = Get.find<UserController>();
  var chatController = Get.find<ChatController>();

  String u2id = UserController().userM.value.id.toString();

  @override
  void initState() {
    super.initState();
    readMsg();
  }

  void sendMsg() {
    
    ChatController().insertChat(
        user1id: widget.user1id,
        user2id: userController.userM.value.id.toString(),
        sender: userController.userM.value.id.toString(),
        messages: sendMsgController.text);
  }

  void readMsg() {
    chatController.readChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back(result: -1);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 100),
                    Text("${widget.name}", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 15),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: chatController.chatList.length,
                    itemBuilder: (context, index) {
                      final chat = chatController.chatList[index];
                      final isUser1 =chat.user1id ==
                      userController.userM.value.id.toString();
                      final messageColor = isUser1
                      ? const Color.fromARGB(255, 190, 156, 179)
                      : const Color.fromARGB(255, 79, 219, 241);
                     
                      return ListTile(
                          title: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: messageColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "${chat.messages}",
                          textAlign: TextAlign.center,
                        )),
                      ));
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: TextField(
                        controller: sendMsgController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onSubmitted: (value) {
                          // Handle the send button press or form submission here
                          // You can access the entered value with 'value'.
                          print("Send message: $value");
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMsg();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.purple[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
