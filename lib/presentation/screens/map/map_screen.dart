import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import '../../../utils/service.dart';
import "package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart" as image_provider;

class MapScreen extends StatefulWidget {
  final String lat;
  final String lng;

  const MapScreen({super.key, required this.lat, required this.lng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapWindow? _mapWindow;

  @override
  void initState() {
    super.initState();
    mapkit.onStart();
    _initPermission();
  }

  @override
  void dispose() {
    mapkit.onStop();
    super.dispose();
  }

  Future<void> _initPermission() async {
    final locationService = LocationService();
    if (!await locationService.checkPermission()) {
      await locationService.requestPermission();
    }
  }

  void _addMarker (){
    final double latitude = double.parse(widget.lat);
    final double longitude = double.parse(widget.lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8ad0e),
        elevation: 0,
        title: const Text("Do'konlar"),
      ),
      body: YandexMap(
        onMapCreated: (mapWindow) {
          _mapWindow = mapWindow;
          final imageProvider = image_provider.ImageProvider.fromImageProvider(const AssetImage("assets/img.png"));
          final placemark = mapWindow.map.mapObjects.addPlacemark()
            ..geometry = Point(latitude: double.parse(widget.lat), longitude: double.parse(widget.lng))
            ..setIcon(imageProvider);
          _mapWindow?.map.move(
              CameraPosition(
                  Point(latitude: double.parse(widget.lat), longitude: double.parse(widget.lng
                  )),
                  zoom: 17.0,
                  azimuth: 150.0,
                  tilt: 30.0
              )
          );
        },
      ),
    );
  }
}
