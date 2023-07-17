import 'package:flutter/material.dart';
import 'package:test_location/feature/presentation/logic.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../services/location_service.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  var _isLoading = false;
  String? addressName;
  Point? myLocation;
  late YandexMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(
              onMapCreated: (controller) async {
                this.controller = controller;
                setState(() {
                  _isLoading = true;
                });
                final position =
                await LocationService.getInstance().determinePosition();
                final address = await apiConnection(
                    (position.latitude, position.longitude));
                setState(() {
                  myLocation = Point(
                    latitude: position.latitude,
                    longitude: position.longitude,
                  );
                  addressName = address;
                  _isLoading = false;
                });
                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      ),
                    ),
                  ),
                );
              },
              mapObjects: [
                if (myLocation != null)
                  PlacemarkMapObject(
                    point: myLocation!,
                    opacity: 1,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          'assets/png/marker.png',
                        ),
                        scale: 0.4,
                      ),
                    ),
                    mapId: const MapObjectId('placemark'),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (addressName != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    addressName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    controller.moveCamera(
                      CameraUpdate.zoomIn(),
                      animation: const MapAnimation(
                        duration: 0.5,
                        type: MapAnimationType.smooth,
                      ),
                    );
                  },
                  iconSize: 40,
                  icon: const Icon(Icons.add_circle_rounded),
                ),
                IconButton(
                  onPressed: () {
                    controller.moveCamera(
                      CameraUpdate.zoomOut(),
                      animation: const MapAnimation(
                        duration: 0.5,
                        type: MapAnimationType.smooth,
                      ),
                    );
                  },
                  iconSize: 40,
                  icon: const Icon(Icons.remove_circle_rounded),
                ),
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                  onPressed: () {
                    controller.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: Point(
                            latitude: myLocation?.latitude ?? 0,
                            longitude: myLocation?.longitude ?? 0,
                          ),
                        ),
                      ),
                      animation: const MapAnimation(
                        duration: 0.5,
                        type: MapAnimationType.smooth,
                      ),
                    );
                  },
                  iconSize: 40,
                  icon: const Icon(
                    Icons.location_on_sharp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
