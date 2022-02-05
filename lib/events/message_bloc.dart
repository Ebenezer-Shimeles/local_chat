import 'base_event.dart';

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

abstract class MsgEvent extends Event {}

class InMsgEvent extends MsgEvent {
  String msg;
  Device from;
  InMsgEvent({required this.msg, required this.from});
}
