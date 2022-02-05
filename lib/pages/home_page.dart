import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_chat/bloc/main_menu_bloc.dart';

import '../widgets/main_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _wids = <Widget>[Icon(Icons.alarm, color: Colors.red,), Icon(Icons.alarm)];
    return  BlocBuilder<MainMenuBlocNavBarBloc, int>(
      builder: (context, int state) {
        return Scaffold(
          appBar: AppBar(),
            body: Center(child: _wids[state],),
            bottomNavigationBar: MainNavBar(0),
          
        );
      }
    );
  }
}
