import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:local_chat/bloc/connection_service_bloc.dart';
import 'package:local_chat/bloc/message_bloc.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';
import 'bloc/main_menu_bloc.dart';
import 'bloc/router_bloc.dart';
import 'services/connection_service.dart';

List<Provider<Object>> _providers = [];
Future<void> initProviders() async {
  _providers.add(Provider<MainMenuBlocNavBarBloc>(
      create: (__) => MainMenuBlocNavBarBloc()));
  _providers.add(Provider<RouterBloc>(
    create: (ctx) => RouterBloc(),
  ));

  final connectionServiceBloc = ConnectionServiceBloc(DeviceType.browser);

  _providers
      .add(Provider<ConnectionServiceBloc>.value(value: connectionServiceBloc));
  await connectionServiceBloc.init();
  _providers.add(Provider<MsgBloc>(
    create: (ctx) => MsgBloc(),
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initProviders();
  runApp(MultiProvider(
      providers: _providers as List<Provider>,
      child: Builder(
        builder: (context) => MaterialApp(
          routes: {'/': (context) => HomePage()},
          theme: ThemeData.dark(),
        ),
      )));
}
