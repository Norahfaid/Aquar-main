import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/add_annoncement_response.dart';
import '../repo/filter_repo.dart';

class AddAnnoncementUsecase
    extends UseCase<AddAnnoncementResponse, AddAnnoncementParams> {
  final FilterRepository repository;
  AddAnnoncementUsecase({required this.repository});
  @override
  Future<Either<Failure, AddAnnoncementResponse>> call(
      AddAnnoncementParams params) async {
    return await repository.addAnnoncement(params: params);
  }
}

class AddAnnoncementParams {
  // int? networkTypeId;
  List<int>? networkTypes;
  int? buildingTypeId;
  String? descrption;
  String? phone;
  String? minPrice;
  String? maxPrice;
  String? minDistance;
  String? maxDistance;
  String? appartCount;
  String? bedRoomsCount;
  String? allRooms;
  String? bathRoomsCount;
  String? additionalRoomsCount;
  String? shopsCount;
  String? streetWidth;
  String? age;
  String? interface;
  String? licenseNumber;
  String? advLicenseNumber;
  String? purpose;
  String? address;
  String? cordinates;
  final String? lat;
  final String? long;
  String? videoLink;
  String? driverRoom;
  String? maidRoom;
  String? pool;
  String? carInterface;
  String? externalStaircase;
  String? supplement;
  String? elevator;
  String? kitchen;
  String? roof;
  String? duplex;
  String? separated;
  List<File>? images;
  String? basement;
  String? monsters;
  String? airConditioner;
  int? fromDashboard;

  ///image1 is the icon
  File? icon;
  File? image2;
  File? video;
  File? image3;
   AdvType?  advType ;
  AddAnnoncementParams({
    // this.networkTypeId,
    this.icon,
    this.images,
    this.image2,
    this.image3,
    this.buildingTypeId,
    this.networkTypes,
    this.monsters,
    this.descrption,
    this.cordinates,
    this.phone,
    this.allRooms,
    this.video,
    this.minPrice,
    this.maxPrice,
    this.minDistance,
    this.maxDistance,
    this.appartCount,
    this.bedRoomsCount,
    this.bathRoomsCount,
    this.additionalRoomsCount,
    this.shopsCount,
    this.streetWidth,
    this.age,
    this.interface,
    this.licenseNumber,
    this.advLicenseNumber,
    this.purpose,
    this.address,
    this.lat,
    this.long,
    this.videoLink,
    this.driverRoom,
    this.maidRoom,
    this.pool,
    this.carInterface,
    this.externalStaircase,
    this.supplement,
    this.elevator,
    this.kitchen,
    this.roof,
    this.duplex,
    this.separated,
    this.basement,
    this.airConditioner,
    this.fromDashboard,
     this.advType
  });
}
enum AdvType{markting , nafaz }