import 'package:flutter/material.dart';

import '../bloc/router_bloc.dart';
import '../events/router_events.dart';
import '../pages/talk_page.dart';

import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String lastMsg = "Yuwe: Hi";
    return Scaffold(
      body: ListView(
        children: [
          Divider(),
          ListTile(
            onTap: () {
              final routerProvider =
                  Provider.of<RouterBloc>(context, listen: false);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => TalkPage(chatId: "Group")));
            },
            leading: CircleAvatar(
              child: Text("Gr"),
            ),
            title: Text("Main Group Chat"),
            subtitle: Text(lastMsg),
          ),
          Divider()
        ],
      ),
    );
  }
}
