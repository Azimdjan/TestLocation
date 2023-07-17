import 'package:test_location/feature/data/data_source/test_data_source.dart';
import 'package:test_location/feature/domain/entities/location_entity.dart';

import '../../domain/repository/test_repository.dart';

class TestRepositoryImpl implements TestRepository {
  final TestDataSource dataSource;

  TestRepositoryImpl(this.dataSource);

  @override
  Future<LocationEntity> getLocation((double, double) location) async {
    final response = await dataSource.getLocation(location);
    return response.toEntity;
  }
}
