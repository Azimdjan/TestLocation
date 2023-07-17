import 'package:test_location/feature/data/models/location_response.dart';

class LocationEntity {
  final String name;

  LocationEntity({
    required this.name,
  });
}

extension LocationEntityX on LocationResponse {
  LocationEntity get toEntity => LocationEntity(
        name: displayName ?? '',
      );
}
