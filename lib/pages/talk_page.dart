import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_chat/bloc/message_bloc.dart';

import '../widgets/in_chat.dart';

class TalkPage extends StatelessWidget {
  String chatId;
  TalkPage({required this.chatId});
  List<Widget> _chatChildren = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$chatId"),
      ),
      body: BlocBuilder<MsgBloc, String>(builder: (context, state) {
        _chatChildren.add(Text(state));
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 9,
                child: ListView(
                  physics: ScrollPhysics(),
                  children: _chatChildren,
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
            ]);
      }),
    );
  }
}
