import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_chat/constants.dart';

User? loggedInUser = FirebaseAuth.instance.currentUser;

class Home extends StatefulWidget {
  static const String id = "Home_screen";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String massageText = "";
  TextEditingController messageController = TextEditingController();

  void getMessages() async {
    final msgs = await _firestore.collection('messages').get();
    for (var msg in msgs.docs) {
      print(msg.data());
    }
  }

  void signout() {
    _auth.signOut();
    Navigator.pop(context);
  }

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
            "Hello, Will jcfwe woifjw ioweo iowedj oidjweod weudhowe oiwdhedod owei",
        messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [IconButton(onPressed: signout, icon: Icon(Icons.close))],
        // backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          // ListView.builder(
          //   reverse: true,
          //   itemCount: messages.length,
          //   shrinkWrap: true,
          //   padding: const EdgeInsets.only(top: 10, bottom: 70),
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding: const EdgeInsets.only(
          //           left: 14, right: 14, top: 10, bottom: 10),
          //       child: Align(
          //         alignment: (messages[index].messageType == "receiver"
          //             ? Alignment.topLeft
          //             : Alignment.topRight),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20),
          //             color: (messages[index].messageType == "receiver"
          //                 ? Colors.black26
          //                 : Colors.teal),
          //           ),
          //           padding: EdgeInsets.all(16),
          //           child: Text(
          //             messages[index].messageContent,
          //             style: TextStyle(fontSize: 15),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final msgs = snapshot.data!.docs.reversed;
                List<Widget> msgWidget = [];
                for (var msg in msgs) {
                  final msgText = msg['text'];
                  final msgSender = msg['sender'];
                  msgWidget.add(Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (msgSender == loggedInUser!.email
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: msgSender == loggedInUser!.email
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                          color: (msgSender == loggedInUser!.email
                              ? Colors.teal
                              : Colors.black26),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          msgText,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ));
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: msgWidget,
                  ),
                );
              }
              return const CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: kBGInput,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: messageController,
                      onChanged: (value) {
                        massageText = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: kBorderRadius,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: kBorderRadius,
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      messageController.clear();
                      if (massageText!.isNotEmpty) {
                        _firestore.collection('messages').add({
                          'text': massageText,
                          'sender': loggedInUser!.email
                        });
                      }
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
