import 'package:geolocator/geolocator.dart';
import 'package:test_location/core/expections.dart';

class LocationService {
  late LocationPermission permission;
  late bool serviceEnabled;
  static LocationService? _instance;

  static LocationService getInstance() {
    _instance ??= LocationService();
    return _instance!;
  }

  Future<void> init() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<Position> determinePosition() async {
    if (!serviceEnabled) {
      throw NoLocationException('Location service disabled');
    }

    if (permission == LocationPermission.denied) {
      throw NoLocationException('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          throw NoLocationException('Location permissions are denied forever'));
    }
    return await Geolocator.getCurrentPosition();
  }
}
