import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngServer on LatLng {
  String toStringServer() {
    return "$latitude,$longitude";
  }
}

extension LatLngFromPostions on Position {
  LatLng latLngFromPostion() {
    return LatLng(latitude, longitude);
  }
}

extension LatLngFromStringServer on String {
  LatLng latLngFromStringServer() {
    final List<String> strings = split(",");
    return LatLng(double.parse(strings[0]), double.parse(strings[1]));
  }
}
