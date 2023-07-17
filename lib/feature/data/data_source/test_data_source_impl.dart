import 'package:dio/dio.dart';
import 'package:test_location/core/constants.dart';
import 'package:test_location/core/expections.dart';
import 'package:test_location/feature/data/data_source/test_data_source.dart';
import 'package:test_location/feature/data/models/location_response.dart';

class TestDataSourceImpl implements TestDataSource {
  final Dio dio;

  TestDataSourceImpl(this.dio);

  @override
  Future<LocationResponse> getLocation((double, double) location) async {
    try {
      final response = await dio.get(Constants.baseUrl, queryParameters: {
        'format': 'json',
        'lat': location.$1,
        'lon': location.$2,
      });
      if (response.statusCode == 200) {
        return LocationResponse.fromJson(response.data);
      } else {
        throw NetworkException(response.data.toString());
      }
    } catch (e) {
      throw NetworkException('Something went wrong');
    }
  }
}
