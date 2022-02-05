import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import '../events/router_events.dart';

class RouterBloc extends Bloc<RouterEvent, String> {
  RouterBloc() : super('/') {
    on<RouteToEvent>((event, emit) {
      emit(event.path);
      Navigator.pushNamed(event.context, event.path);
    });
  }
}
