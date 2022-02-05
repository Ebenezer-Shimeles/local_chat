import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';
import 'bloc/main_menu_bloc.dart';

List<Provider<Object>> _providers = [];
void initProviders() {
  _providers.add(Provider<MainMenuBlocNavBarBloc>(create: (__) => MainMenuBlocNavBarBloc()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initProviders();
  runApp(MultiProvider(
      providers: _providers as List<Provider>,
      child: Builder(
        builder: (context) => MaterialApp(
          routes: {'/': (context) => HomePage()},
        ),
      )));
}
