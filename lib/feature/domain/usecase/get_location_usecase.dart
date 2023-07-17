import 'package:test_location/feature/domain/entities/location_entity.dart';
import 'package:test_location/feature/domain/repository/test_repository.dart';

class GetLocationUseCase {
  final TestRepository _locationRepository;

  GetLocationUseCase(this._locationRepository);

  Future<LocationEntity> call((double lat, double long) location) async {
    return await _locationRepository.getLocation(location);
  }
}
