import 'package:dio/dio.dart';
import 'package:test_location/core/expections.dart';
import 'package:test_location/feature/data/data_source/test_data_source.dart';
import 'package:test_location/feature/data/data_source/test_data_source_impl.dart';
import 'package:test_location/feature/data/repository/test_repository_impl.dart';
import 'package:test_location/feature/domain/repository/test_repository.dart';
import 'package:test_location/feature/domain/usecase/get_location_usecase.dart';

/// Instead of this function here should be some state management and dependency injection
Future<String> apiConnection((double lat, double lon) location) async {
  final TestDataSource _testDataSource = TestDataSourceImpl(
    Dio()
      ..interceptors.add(
        LogInterceptor(
            error: true, request: true, requestBody: true, responseBody: true),
      ),
  );
  final TestRepository _testRepository = TestRepositoryImpl(_testDataSource);
  final GetLocationUseCase _getLocationUseCase =
      GetLocationUseCase(_testRepository);
  try {
    final result = await _getLocationUseCase(location);
    print("Here1");
    return result.name;
  } catch (e) {
    if (e is NetworkException) {
      print("Here2");
      return e.message;
    } else {
      return 'Unknown error';
    }
  }
}
