import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

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

// extension LatLngMapsKit on String {
//   g.LatLng latLngKIt() {
//     final List<String> strings = split(",");
//     return g.LatLng(double.parse(strings[0]), double.parse(strings[1]));
//   }
// }

// extension KitLatLng on LatLng {
//   g.LatLng toKitlatLng() {
//     return g.LatLng(latitude, longitude);
//   }
// }
