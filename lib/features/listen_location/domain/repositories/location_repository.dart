abstract class LocationRepository {
  Future<void> startLocation();
  Future<void> stopLocation();
  Stream<Map<String, double>> listenChangesGPS();
}
