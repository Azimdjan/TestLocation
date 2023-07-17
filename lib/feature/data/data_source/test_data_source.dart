import '../models/location_response.dart';

abstract class TestDataSource {
  Future<LocationResponse> getLocation((double lat, double long) location);
}
