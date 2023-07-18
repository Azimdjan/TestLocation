import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_location/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'feature/data/data_source/test_data_source.dart';
import 'feature/data/data_source/test_data_source_impl.dart';
import 'feature/data/repository/test_repository_impl.dart';
import 'feature/domain/repository/test_repository.dart';
import 'feature/domain/usecase/get_location_usecase.dart';
import 'feature/presentation/bloc/test_bloc.dart';
import 'feature/presentation/pages/initial_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocationService.getInstance().init().then(
        (value) => runApp(
          const TestLocationApp(),
        ),
      );
}

class TestLocationApp extends StatelessWidget {
  const TestLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final TestDataSource _testDataSource = TestDataSourceImpl(
          Dio()
            ..interceptors.add(
              LogInterceptor(
                  error: true,
                  request: true,
                  requestBody: true,
                  responseBody: true),
            ),
        );
        final TestRepository testRepository =
            TestRepositoryImpl(_testDataSource);
        final GetLocationUseCase getLocationUseCase =
            GetLocationUseCase(testRepository);
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TestBloc(getLocationUseCase),
              child: const InitialPage(),
            ),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
