import 'package:flutter/material.dart';

import '../widgets/in_chat.dart';

class TalkPage extends StatelessWidget {
  String chatId;
  TalkPage({required this.chatId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$chatId"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          flex: 9,
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              InChatWidget(
                  me: true,
                  name: "Ebenezer",
                  icon: CircleAvatar(
                    child: Text("E"),
                  ),
                  msg: "Hello Bro")
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Input your message here",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
