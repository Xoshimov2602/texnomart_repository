import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';

import 'lat_lng_data.dart';


abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final AppLatLong defLocation =
      const AppLatLong(lat: 55.751244, long: 37.618423); // Moscow Default

  @override
  Future<AppLatLong> getCurrentLocation() async {
    bool hasPermission = await checkPermission();
    if (!hasPermission) {
      hasPermission = await requestPermission();
      if (!hasPermission) {
        return defLocation;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      return AppLatLong(lat: position.latitude, long: position.longitude);
    } catch (e) {
      return defLocation;
    }
  }

  @override
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Point toYandexPoint(AppLatLong location) {
    return Point(latitude: location.lat, longitude: location.long);
  }

}
