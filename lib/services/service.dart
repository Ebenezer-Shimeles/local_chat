abstract class Service {
  abstract String id;
  dynamic inPipe(List args);
  Future<dynamic> regService(List args);
  Future<bool> init(List args);
}
