import 'dart:async';

import 'service.dart';

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:device_info/device_info.dart';

import 'dart:io';

enum DeviceType { advertiser, browser }

class ConnectionService extends Service {
  DeviceType deviceType;
  ConnectionService({required this.deviceType});

  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  late NearbyService nearbyService;

  List<Device> devices = [];
  List<Device> connectedDevices = [];

  @override
  inPipe(List args) {
    // We send Our data through here
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
          if (isRunning) {
            if (this.deviceType == DeviceType.browser) {
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
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
      devicesList.forEach((element) {
        print(
            " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");

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
      //currently data is a map
    });
    return true;
  }

  @override
  String id = "HostService";
}
