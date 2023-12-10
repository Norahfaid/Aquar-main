import 'dart:ui' as ui;
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/widgets/toast.dart';
import '../../../aquar/presentation/pages/extinions.dart';
import '../../domain/models/filter.dart';
import '../../domain/usecase/filter_usecase.dart';

part 'home_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this.usecase) : super(HomeInitial());

  final FilterUsecase usecase;
  String? buildingTypeSelectedId;
  changeSelectedId({required String newId}) {
    emit(ChangeSelectedId());
    buildingTypeSelectedId = newId;
    emit(HomeInitial());
  }

  // int? selectedId;
  // changeSelected({required RealStates res}) {
  //   selectedId = res.id;
  //   emit(ChangeSelected());
  //   emit(HomeInitial());
  // }

  bool ifMyAd = false;
  mineAds({required int userId, required int adUserId}) {
    if (userId == adUserId) {
      ifMyAd = true;
      emit(MineAd());
      emit(HomeInitial());
    }
    ifMyAd = false;
    emit(NotMineAd());
    emit(HomeInitial());
  }

  Future<Position?> getUserAccessLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled");
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(
          "Location permissions are permanently denied, we cannot get your location");
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  String formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(0)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    } else {
      return price.toStringAsFixed(0);
    }
  }

  Future<BitmapDescriptor> _createMarkerIcon(int minPrice, int maxPrice,
      String imageAssetPath, bool isFromDash) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final double width = !isFromDash ? 140 : 160;
    final double height = !isFromDash ? 140 : 160;
    final double radius = !isFromDash ? 20 : 25;
    final Paint markerPaint = Paint()..color = Colors.white;
    final Paint pricePaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    final price = formatPrice(maxPrice);
    final TextPainter pricePainter = TextPainter(
      maxLines: 2,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: ' $price ',
        style: TextStyle(
          // backgroundColor: mainColor,
          color: Colors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    )..layout();

    final ui.Image image = await loadImageFromAsset(
        imageAssetPath, width.toInt(), (height).toInt());
    Rect imageRect = Rect.fromLTWH(0, 30, width, height - 30);

    canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        imageRect,
        markerPaint);
    canvas.drawCircle(Offset(width / 2, height - 20 / 2), radius, pricePaint);
    pricePainter.paint(
      canvas,
      Offset(width / 2 - pricePainter.width / 2, 10 - pricePainter.height / 2),
    );

    final img = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    final buffer = data!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(buffer);
  }

  Future<ui.Image> loadImageFromAsset(
      String path, int width, int height) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  String? lastLatLng;
  List<AnnounceData> filterData = [];
  AnnounceData? selectedMarker;
  List<Marker> markers = [];
  FilterParams filterParams = FilterParams();
  int currentPage = 1;
  bool isMore = true;
  Future<void> fgetFilterData({
    bool? ifIsMore,
    String? latLang,
    String? bathroomsCount,
    required int map,
    String? status,
    String? mine,
    bool? isNearest,
    String? search,
    bool isSearch = false,
    Function? markerOnTap,
    bool isFirst = false,
    String? apartmentscount,
    String? age,
    String? bedroomscount,
    String? latest,
    String? cheaper,
    String? buildingtype,
    String? interface,
    String? maxdistance,
    String? maxprice,
    String? mindistance,
    String? minprice,
    String? number,
    String? purpose,
    String? shopscount,
    String? streetwidth,
  }) async {
    if (isFirst) {
      isMore = true;
      currentPage = 1;
      filterData = [];
    }
    if (isSearch) {
      currentPage = 1;
    }
    if (latLang != null) {
      lastLatLng = latLang;
    }
    if (map == 1 && latLang == null) {
      latLang = lastLatLng;
    }
    isMore = ifIsMore ?? (isSearch || isMore);
    if (isMore) {
      if (currentPage == 1) {
        filterData = [];
        emit(GetFilterLoadingState());
        filterParams = FilterParams(
          page: currentPage,
          search: search,
          isNearst: isNearest,
          latLang: latLang,
          age: age,
          map: map,
          mine: mine,
          status: status,
          bathroomsCount: bathroomsCount,
          apartmentscount: apartmentscount,
          cheaper: cheaper,
          latest: latest,
          bedroomscount: bedroomscount,
          buildingtype: buildingtype,
          interface: interface,
          maxdistance: maxdistance,
          maxprice: maxprice,
          mindistance: mindistance,
          minprice: minprice,
          number: number,
          purpose: purpose,
          shopscount: shopscount,
          streetwidth: streetwidth,
        );
      } else {
        filterParams.page = currentPage;
        emit(GetFilterPaginationLoadingState());
      }
      if (isNearest ?? false) {
        // final postions = (await getUserAccessLocation());
        // if (postions == null) {
        //   emit(HomeInitial());
        //   return;
        // }
        // latLang = postions.latLngFromPostion().toStringServer();
        filterParams.latLang = latLang;
      }

      final failOrString = await usecase(filterParams);
      failOrString.fold((fail) {
        if (fail is ServerFailure) {
          markers = [];
          emit(GetFilterErrorState(message: fail.message));
        }
      }, (reaponse) async {
        if (reaponse.data.meta != null) {
          if (currentPage < reaponse.data.meta!.lastPage) {
            currentPage += 1;
          } else {
            isMore = false;
          }
        }
        // if (myMarker == null || fromDashboardmarker == null) {
        //   await getBytesFromAsset();
        // }
        filterData = currentPage == 1
            ? reaponse.data.data
            : filterData + reaponse.data.data;
        markers = [];
        for (var element in filterData) {
          markers.add(Marker(
              icon: element.fromDashboard
                  ? await _createMarkerIcon(element.minPrice, element.maxPrice,
                      'assets/images/dash_icon.png', true)
                  : await _createMarkerIcon(element.minPrice, element.maxPrice,
                      'assets/images/home_icon.png', false),
              markerId: MarkerId(UniqueKey().toString()),

              // infoWindow: InfoWindow(
              //   title:
              //       ("${element.minPrice} - ${element.maxPrice} ${e.tr("sar")} "),
              //   onTap: () {
              //     selectedMarker = element;
              //     emit(UnitCurrentPage());
              //     emit(HomeInitial());
              //   },
              // ),
              onTap: () {
                selectedMarker = element;
                emit(UnitCurrentPage());
                emit(HomeInitial());
              },
              position:
                  ("${element.lat},${element.long}").latLngFromStringServer()));
        }
        emit(GetFilterSuccessState(data: filterData, markers: markers));
      });
    }
  }

  void clearSelectedMarker() {
    selectedMarker = null;
    emit(UnitCurrentPage());
    emit(HomeInitial());
  }

  BitmapDescriptor? myMarker;
  BitmapDescriptor? fromDashboardmarker;
  // Future<void> getBytesFromAsset() async {
  //   ByteData data = await rootBundle.load('assets/images/home_icon.png');
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: 100);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   myMarker = BitmapDescriptor.fromBytes(
  //       (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //           .buffer
  //           .asUint8List());
  //   ByteData data2 = await rootBundle.load('assets/images/dash_icon.png');
  //   ui.Codec codec2 = await ui.instantiateImageCodec(data2.buffer.asUint8List(),
  //       targetWidth: 150);
  //   ui.FrameInfo fi2 = await codec2.getNextFrame();
  // }

  unitCurrentPage() {
    currentPage = 1;
    emit(UnitCurrentPage());
    emit(HomeInitial());
  }

  toggleFav(AnnounceData data) {
    final index = filterData.indexWhere((element) => data.id == element.id);
    if (index != -1) {
      filterData[index] = filterData[index].toggleFav();

      emit(UnitCurrentPage());
      emit(HomeInitial());
    }
  }

  void emitGetFilterLoadingState() {
    emit(GetFilterLoadingState());
  }
}
