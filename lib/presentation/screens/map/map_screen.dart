import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import '../../../utils/service.dart';

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
          setState(() {
            _mapWindow = mapWindow;
          });
        },
      ),
    );
  }
}
