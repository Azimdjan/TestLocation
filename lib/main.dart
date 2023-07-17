import 'package:flutter/material.dart';
import 'package:test_location/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => const InitialPage(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
