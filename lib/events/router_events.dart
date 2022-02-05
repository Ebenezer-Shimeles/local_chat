import 'base_event.dart';

import 'package:flutter/material.dart';

abstract class RouterEvent extends Event {}

class RouteToEvent extends RouterEvent {
  String path;
  BuildContext context;
  RouteToEvent({required this.path, required this.context});
}
