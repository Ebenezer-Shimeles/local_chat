import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_chat/bloc/main_menu_bloc.dart';

import '../widgets/main_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tabs = TabBar(tabs: [
      Tab(
        child: Icon(Icons.image),
      ),
      Tab(
        child: Icon(Icons.alarm),
      )
    ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [Icon(Icons.image), Icon(Icons.alarm)],
        ),
        bottomNavigationBar: MainNavBar(0),
      ),
    );
  }
}
