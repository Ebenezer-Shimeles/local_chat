import 'dart:io';
import 'dart:isolate';
import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

abstract class Service {
  abstract String id;
  abstract final String endPoint;
  void inPipe(dynamic data, {String? urlData = ""});
}

class MessageService implements Service {
  @override
  String id;
  @override
  final String endPoint;
  MessageService({required this.endPoint, required this.id});
  @override
  inPipe(dynamic data, {String? urlData = ""}) {
    if (data is Request) {}
  }
}

class HostProvider {
  /*
      Responsbility: Provides a method for services to use
   */

  late final Isolate _serverIsolate;

  late String _url;
  //Map<String, Service> _serviceEndPoints = {};
  List<Service> _services = [];
  ReceivePort _serverPort = ReceivePort(); //all communications are through this
  /*
     
      Responsiblity: control all HostService
   */

  void mapHttpToService(req) {
    _services.forEach((Service element) {
      if (req.url.toString().split(',')[-1] == element.endPoint) {
        element.inPipe(req);
      }
    });
  }

  Future<void> _createServer() async {
    this._serverIsolate = await Isolate.spawn((ReceivePort port) async {
      Future<Response> _handler(Request req) async {
        //Responsibility: Listens for users' call on the server

        port.sendPort.send(Request);

        return Response.ok("ok");
      }

      var _wrappedHandler =
          Pipeline().addMiddleware(logRequests()).addHandler(_handler);
      var _server = await shelf_io.serve(_wrappedHandler, 'localhost', 8080);
      _server.autoCompress = true;
    }, _serverPort);
    this._serverPort.listen(this.mapHttpToService);
  }

  Future<bool?> stopServer() async {}
  addService(Service service) {
    this._services.add(service);
  }

  bool removeService(String id) {
    for (int i = 0; i < this._services.length; i++) {
      if (this._services[i].id == id) {
        return this._services.removeAt(i) == null;
      }
    }
    return false;
  }

  HostService() {
    _createServer();
  }

  void dispose() {
    this._serverIsolate.kill();
  }
}
