import 'dart:async';
import 'package:flutter/material.dart';
import 'package:texnomart/data/source/remote/response/markets/markets_response.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import '../../../utils/service.dart';
import "package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart"
as image_provider;
import 'package:flutter/src/painting/text_style.dart' as material_text_style;

class MapScreen extends StatefulWidget {
  final MarketsElement market;

  const MapScreen({super.key, required this.market});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapWindow _mapWindow;

  @override
  void initState() {
    super.initState();
    mapkit.onStart();
    LocationService().checkPermission();
  }

  @override
  void dispose() {
    mapkit.onStop();
    super.dispose();
  }

  void moveCamera(double lat, double lng) {
    _mapWindow.map.move(CameraPosition(
      Point(latitude: lat, longitude: lng),
      zoom: 18.0,
      azimuth: 0.0,
      tilt: 0.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8ad0e),
        elevation: 0,
        title: const Text("Do'konlar"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: YandexMap(
                onMapCreated: (mapWindow) {
                  _mapWindow = mapWindow;
                  moveCamera(
                      double.parse(widget.market.lat ?? "0"),
                      double.parse(widget.market.long ?? "0"));
                  final imageProvider =
                  image_provider.ImageProvider.fromImageProvider(
                      const AssetImage("assets/img.png"));
                  final placemark = mapWindow.map.mapObjects.addPlacemark()
                    ..geometry = Point(
                        latitude: double.parse(widget.market.lat ?? "0"),
                        longitude: double.parse(widget.market.long ?? "0"))
                    ..setIcon(imageProvider);
                  // _mapWindow.map.move(CameraPosition(
                  //     Point(
                  //         latitude: double.parse(widget.market.lat ?? "0"),
                  //         longitude: double.parse(widget.market.long ?? "0")),
                  //     zoom: 17.0,
                  //     azimuth: 150.0,
                  //     tilt: 30.0));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.shop),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "",
                          style: material_text_style.TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
