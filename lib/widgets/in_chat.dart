import 'package:flutter/material.dart';

class InChatWidget extends StatelessWidget {
  String name;
  Widget icon;
  String msg;
  bool me;
  InChatWidget(
      {required this.name,
      required this.icon,
      required this.msg,
      Key? key,
      this.me = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: icon,
                flex: 2,
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(color: Colors.orange),
                ),
                flex: 8,
              )
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("="), flex: 2),
              Expanded(child: Text(msg), flex: 8),
            ],
          )
        ],
      ),
    );
  }
}
