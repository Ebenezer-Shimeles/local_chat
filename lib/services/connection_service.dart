import 'dart:async';
import 'dart:isolate';

import 'package:equatable/equatable.dart';

import 'service.dart';
import '../bloc/connection_service_bloc.dart';
import '../events/connection_service_events.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:device_info/device_info.dart';
import 'package:provider/provider.dart';

import 'dart:io';

enum DeviceType { advertiser, browser }

class ConnectionService extends Service with EquatableMixin {
  DeviceType deviceType;
  ConnectionService({required this.deviceType});

  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  late NearbyService nearbyService;

  List<Device> devices = [];
  List<Device> connectedDevices = [];
  SendPort? _outPort;
  setOutPort(SendPort port) {
    _outPort = port;
    print("Port set!");
  }

  @override // TODO: implement props
  List<Object?> get props => [devices];
  @override
  inPipe(List args) {
    // We send Our data through here
    if (args[0] is ConnectToDeviceEvent) {
      final Device dev = args[0].dev;
      print("Connecting.... to ${dev.deviceName}");
      if (_outPort == null) print("Null #2");

      if (dev.state == SessionState.notConnected) {
        this
            .nearbyService
            .invitePeer(deviceID: dev.deviceId, deviceName: dev.deviceName);
        _outPort!.send([dev]);
      } else
        print("Weird Error #1");
    }
    if (args[0] is DisconnectCurrentConnectionEvent) {
      print("Disconnecting :( ... ..");
      final dev = args[0].dev;
      if (dev.state == SessionState.connected) {
        this.nearbyService.disconnectPeer(deviceID: dev.deviceId);
        _outPort!.send([dev]);
      } else
        print("Weird Error #2");
    }
    if (args[0] is SendDataToDeviceEvent) {
      print("Sending ");
      this.nearbyService.sendMessage(args[0].dev, args[0].data);
    }
  }

  @override
  Future regService(List args) async {}

  @override
  Future<bool> init(List args) async {
    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          print("-" * 17);
          if (isRunning) {
            if (this.deviceType == DeviceType.browser) {
              print("Browsing");
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
              print("Hosting");
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
      if (_outPort != null)
        _outPort!.send(devicesList);
      else
        print("Currently null");
      print("new something");
      devicesList.forEach((element) {
        print(
            " new deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");
        print("-" * 50);

        if (Platform.isAndroid) {
          if (element.state == SessionState.connected) {
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }
      });

      devices.clear();
      devices.addAll(devicesList);
      connectedDevices.clear();
      connectedDevices.addAll(
          devicesList.where((d) => d.state == SessionState.connected).toList());
    });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
      //print("New data $data");
    });
    return true;
  }

  stop() async {
    subscription.cancel();
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
  }

  @override
  String id = "HostService";
}
