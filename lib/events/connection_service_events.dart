import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import 'base_event.dart';

abstract class ConnectionServiceEvent {}

class DisconnectCurrentConnectionEvent extends ConnectionServiceEvent {
  Device dev;
  DisconnectCurrentConnectionEvent({required this.dev});
}

class ConnectToEvent extends ConnectionServiceEvent {}

class PipeToConnectionServiceEvent extends ConnectionServiceEvent {
  List data;
  PipeToConnectionServiceEvent(this.data);
}

class HostConnectionEvent extends ConnectionServiceEvent {}

class BeListenerEvent extends ConnectionServiceEvent {}

class ConnectToDeviceEvent extends ConnectionServiceEvent {
  Device dev;
  ConnectToDeviceEvent({required this.dev});
}

class DevicesChangedEvent extends ConnectionServiceEvent {}

class RedrawEvent extends ConnectionServiceEvent {}

class SendDataToDeviceEvent extends ConnectionServiceEvent {
  Device dev;
  String data;
  SendDataToDeviceEvent({required this.dev, required this.data});
}
