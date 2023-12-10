import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/widgets/toast.dart';

part 'pick_map_state.dart';

class PickMapCubit extends Cubit<PickMapState> {
  PickMapCubit() : super(PickMapInitial());

  static PickMapCubit get(BuildContext context) => BlocProvider.of(context);
//  bool firstTime=true ;
  updateController(GoogleMapController newController) {
    mapController = newController;
  }

  late GoogleMapController mapController;
  initMapController(LatLng latlong, GoogleMapController newMapController,
      BuildContext context) {
    mapController = newMapController;

    pickLocation(latlong);
  }

  Future<void> gettCurrentLocation(context) async {
    emit(PickMapClearLastMarkerState());
    if (markers.isNotEmpty) {
      markers.clear();
    }

    final location = await getUserAccessLocation();
    final lat = location.latitude;
    final long = location.longitude;
    _cameraPosition = CameraPosition(target: LatLng(lat, long), zoom: 16);
    emit(PickMapToggleLoadingState());
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    await Future.delayed(const Duration(milliseconds: 200));
    emit(PickMapGetCurrentLocationState());
  }

  String? _address;
  String? get addressLatLng => _address;
  set setAddressLatLng(String val) {
    _address = val;
    emit(UpdateAddressState());
    emit(PickMapInitial());
  }

  Future<void> fGetStartAddressTitleFromLatLong(
      LatLng latLng, TextEditingController controller) async {
    try {
      emit(PickMapToggleLoadingState());
      _address == latLng.toString();
      List<geocoding.Placemark> placemarks = [];
      placemarks.addAll(await geocoding.placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'en,'));
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        controller.text = '${place.street}';
      } else {
        controller.text = '${latLng.latitude}';
      }
    } catch (e) {
      log(e.toString());
      log(e.toString());
      controller.text =
          '${latLng.latitude.toStringAsFixed(4)},${latLng.longitude.toStringAsFixed(4)}';
    }
  }

  Future<Position> getUserAccessLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(
          "Location permissions are permanently denied, we cannot get your location");
    }
    return await Geolocator.getCurrentPosition();
  }

  final List<Marker> markers = <Marker>[];

  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(21.3891, 39.8579),
    zoom: 14,
  );
  CameraPosition get cameraPosition {
    return _cameraPosition;
  }

  String? addressCoordinates;
  getCurrentLocation(context) async {
    if (markers.isNotEmpty) {
      markers.clear();
    }
    emit(ClearLastMarkerState());
    final location = await getUserAccessLocation();
    final lat = location.latitude;
    final long = location.longitude;
    pickLocation(LatLng(lat, long));
  }

  pickLocation(LatLng latLng) async {
    if (markers.isNotEmpty) {
      markers.clear();
    }
    emit(ClearLastMarkerState());
    markers.add(Marker(
      markerId: const MarkerId("current_location"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: const InfoWindow(
        title: 'Current Location',
      ),
    ));
    _cameraPosition = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 14,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    addressCoordinates = "${latLng.latitude},${latLng.longitude}";
    emit(PickLocationState());
  }

  bool isLoading = false;
  toggleLoading() {
    isLoading = !isLoading;
    emit(ToggleLoadinState());
  }
}
