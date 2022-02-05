import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../events/connection_service_events.dart';
import '../services/connection_service.dart';

import 'dart:isolate';

class ConnectionServiceBloc
    extends Bloc<ConnectionServiceEvent, ConnectionService> {
  late Isolate isolate;
  ConnectionServiceBloc(deviceType)
      : super(ConnectionService(deviceType: deviceType)) {
    ReceivePort port = ReceivePort();
    state.setOutPort(port.sendPort);
    print("Port set");
    port.listen((message) async {
      this.state.devices = message;

      //this.add(DevicesC hangedEvent());
      //await this.state.int([]);
      print("message: ${message[0].deviceId}");
      this.add(RedrawEvent());
    });
    (() async {
      // await state.init([ ]);

      on<ConnectToEvent>((event, emit) {});
      on<DisconnectCurrentConnectionEvent>((event, emit) {
        state.inPipe([event]);
      });
      on<PipeToConnectionServiceEvent>((event, emit) {});
      on<HostConnectionEvent>((event, emit) async {
        await state.stop();
        final newConnection =
            ConnectionService(deviceType: DeviceType.advertiser);

        await newConnection.init([]);
        emit(newConnection);
      });
      on<SendDataToDeviceEvent>((event, emit) {
        state.inPipe([event]);
        emit(state);
      });
      on<BeListenerEvent>((event, emit) async {
        await state.stop();
        final newConnection = ConnectionService(deviceType: DeviceType.browser);
        await newConnection.init([]);
        emit(newConnection);
      });
      on<RedrawEvent>((event, emit) {
        print("Redrawing");

        emit(state);
      });
      on<ConnectToDeviceEvent>((event, emit) {
        state.inPipe([event]);
        emit(state);
      });
      on<DevicesChangedEvent>((event, emit) async {
        //final newConnection = ConnectionService(deviceType: state.deviceType);
        //await newConnection.init([]);
        //emit(newConnection);
      });
    })();
  }
  init() async {
    await state.init([]);
  }
}
