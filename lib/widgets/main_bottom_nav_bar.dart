import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../bloc/main_menu_bloc.dart';
import '../events/main_menu_events.dart'

;
class MainNavBar extends StatelessWidget {
  MainNavBar(this._curIndex, {Key? key}) : super(key: key);

  int _curIndex;
  @override
  Widget build(BuildContext context) {
    final bottomNavigationarBloc = Provider.of<MainMenuBlocNavBarBloc>(context, listen: false);
    // TODO: implement build
    return BottomNavigationBar(
      currentIndex: bottomNavigationarBloc.state,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "Game")
      ],
     // currentIndex: this._curIndex,
      onTap: (int i) {
              bottomNavigationarBloc.add(BottomNavChangedEvent(i)); 
              print("GOing to $i");
      },
    );
  }
}
