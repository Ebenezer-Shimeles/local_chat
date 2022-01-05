import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget {
  MainNavBar(this._curIndex, {Key? key}) : super(key: key);

  int _curIndex;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "Game")
      ],
      currentIndex: this._curIndex,
      onTap: (int i) {
        this._curIndex = i;
      },
    );
  }
}
