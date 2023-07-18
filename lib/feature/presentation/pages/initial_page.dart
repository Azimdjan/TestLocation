import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_location/feature/presentation/logic.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../services/location_service.dart';
import '../bloc/test_bloc.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late YandexMapController controller;
  List<MapObject> _mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocListener<TestBloc, TestState>(
              listenWhen: (previous, current) =>
                  previous.myLocation != current.myLocation,
              listener: (context, state) {
                if (state.myLocation != null) {
                  _mapObjects.add(
                    PlacemarkMapObject(
                      point: Point(
                        latitude: state.myLocation!.$1,
                        longitude: state.myLocation!.$1,
                      ),
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
                  );
                  controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: Point(
                          latitude: state.myLocation!.$1,
                          longitude: state.myLocation!.$2,
                        ),
                        zoom: 15,
                      ),
                    ),
                    animation: const MapAnimation(
                      duration: 0.5,
                      type: MapAnimationType.smooth,
                    ),
                  );
                }
              },
              child: YandexMap(
                onMapCreated: (controller) async {
                  this.controller = controller;
                  context.read<TestBloc>().add(const TestInitializeEvent());
                },
                onCameraPositionChanged: (position, reason, finished) async {
                  if (finished) {
                    context.read<TestBloc>().add(
                          TestPositionChangedEvent(
                            (
                              position.target.latitude,
                              position.target.longitude,
                            ),
                          ),
                        );
                  }
                },
                mapObjects: _mapObjects,
              ),
            ),
          ),
          const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.location_on_sharp,
                size: 36,
              ),
            ),
          ),
          BlocBuilder<TestBloc, TestState>(
            builder: (context, state) {
              return Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      state.addressName ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              );
            },
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
                BlocBuilder<TestBloc, TestState>(
                  buildWhen: (previous, current) =>
                      previous.myLocation != current.myLocation,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: Point(
                                latitude: state.myLocation?.$1 ?? 0,
                                longitude: state.myLocation?.$2 ?? 0,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
