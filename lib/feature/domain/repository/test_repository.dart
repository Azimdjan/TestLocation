import '../entities/location_entity.dart';

abstract class TestRepository {
  Future<LocationEntity> getLocation((double, double) location);
}
