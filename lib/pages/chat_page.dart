import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:local_chat/services/connection_service.dart';

import '../bloc/connection_service_bloc.dart';
import '../bloc/router_bloc.dart';
import '../events/router_events.dart';
import '../events/connection_service_events.dart';
import '../pages/talk_page.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String lastMsg = "Yuwe: Hi";
    return BlocBuilder<ConnectionServiceBloc, ConnectionService>(
        builder: (context, state) {
      final connectionBloc =
          Provider.of<ConnectionServiceBloc>(context, listen: false);
      List<Widget> _connections = [];
      print("deviceType: ${state.deviceType}");
      if (state.deviceType == DeviceType.advertiser) {
        _connections.add(ListTile(
          title: Text("You are the host"),
          trailing: ElevatedButton(
            child: Text("Stop hosting"),
            style:
                ElevatedButton.styleFrom(elevation: 10.00, primary: Colors.red),
            onPressed: () {
              connectionBloc.add(BeListenerEvent());
            },
          ),
        ));
        state.connectedDevices.forEach((device) {
          _connections.add(ListTile(
            title: Text(device.deviceName),
            subtitle: (Text(device.deviceId)),
            trailing: ElevatedButton(
              child: Text("Disconnect"),
              onPressed: () {},
            ),
          ));
        });
      } else {
        state.devices.forEach((device) {
          _connections.add(ListTile(
            title: Text(device.deviceName),
            subtitle: (Text(device.deviceId)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: device.state == SessionState.notConnected
                      ? Colors.blue
                      : Colors.red),
              child: Text(device.state == SessionState.notConnected
                  ? "Connect"
                  : "Disconnect"),
              onPressed: () {
                device.state == SessionState.notConnected
                    ? connectionBloc.add(ConnectToDeviceEvent(dev: device))
                    : connectionBloc
                        .add(DisconnectCurrentConnectionEvent(dev: device));
              },
            ),
          ));
        });
      }
      print("LEngth: ${_connections.length}");
      if (_connections.length == 0 && state.deviceType != DeviceType.advertiser)
        _connections.add(ListTile(
          title: Text("No connections found!"),
          trailing: ElevatedButton(
            child: Text("Host"),
            style: ElevatedButton.styleFrom(
                primary: Colors.green, elevation: 10.00),
            onPressed: () {
              connectionBloc.add(new HostConnectionEvent());
            },
          ),
        ));
      return Scaffold(
        body: ListView(
          children: _connections +
              [
                Divider(),
                ListTile(
                  onTap: () {
                    final routerProvider =
                        Provider.of<RouterBloc>(context, listen: false);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => TalkPage(chatId: "Group")));
                  },
                  leading: CircleAvatar(
                    child: Text("Gr"),
                  ),
                  title: Text("Main Group Chat"),
                  subtitle: Text(lastMsg),
                ),
                Divider()
              ],
        ),
      );
    });
  }
}
