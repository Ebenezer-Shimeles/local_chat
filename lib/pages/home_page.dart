import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_chat/bloc/main_menu_bloc.dart';
import '../widgets/main_bottom_nav_bar.dart';
import '../pages/chat_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _wids = <Widget>[
      ChatPage(),
      Center(
        child: Text("Coming soon..."),
      )
    ];
    return BlocBuilder<MainMenuBlocNavBarBloc, int>(
        builder: (context, int state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Class Chat"),
        ),
        body: Center(
          child: _wids[state],
        ),
        bottomNavigationBar: MainNavBar(0),
      );
    });
  }
}
