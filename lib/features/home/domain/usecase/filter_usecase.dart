import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/filter.dart';
import '../repo/filter_repo.dart';

class FilterUsecase extends UseCase<FilterResponse, FilterParams> {
  final FilterRepository repository;
  FilterUsecase({required this.repository});
  @override
  Future<Either<Failure, FilterResponse>> call(FilterParams params) async {
    return await repository.getFilter(params: params);
  }
}

class FilterParams {
  final String? purpose;
  int? page;
  final String? number;
  final String? mine;
  final String? bathroomsCount;
  String? buildingtype;
  final String? status;
  final String? minprice;
  final String? maxprice;
  final String? mindistance;
  final String? maxdistance;
  final String? apartmentscount;
  final String? bedroomscount;
  final String? interface;
  final int? map;
  final String? age;
  final String? streetwidth;
  final String? shopscount;
  final String? search;
  final String? cheaper;
  final String? latest;
  final bool? isNearst;
  String? latLang;
  FilterParams({
    this.cheaper,
    this.latest,
    this.interface,
    this.status,
    this.map,
    this.isNearst,
    this.latLang,
    this.bathroomsCount,
    this.search,
    this.age,
    this.streetwidth,
    this.shopscount,
    this.page,
    this.mine,
    this.purpose,
    this.number,
    this.buildingtype,
    this.minprice,
    this.bedroomscount,
    this.maxprice,
    this.apartmentscount,
    this.mindistance,
    this.maxdistance,
  });

  String toQParams() {
    String q = "?";
    if (page != null && page!.toString().isNotEmpty) {
      q += "page=$page&";
    }
    if (purpose != null && purpose!.toString().isNotEmpty) {
      q += "purpose=$purpose&";
    }
    if (mine != null && mine!.toString().isNotEmpty) {
      q += "mine=$mine&";
    }
    if (status != null && status!.toString().isNotEmpty) {
      q += "status=$status&";
    }
    if (number != null && number!.toString().isNotEmpty) {
      q += "number=$number&";
    }
    if (buildingtype != null && buildingtype!.toString().isNotEmpty) {
      q += "buildingtype=$buildingtype&";
    }
    if (minprice != null && minprice!.toString().isNotEmpty) {
      q += "minprice=$minprice&";
    }
    if (maxprice != null && maxprice!.toString().isNotEmpty) {
      q += "maxprice=$maxprice&";
    }
    if (mindistance != null && mindistance!.toString().isNotEmpty) {
      q += "mindistance=$mindistance&";
    }
    if (maxdistance != null && maxdistance!.toString().isNotEmpty) {
      q += "maxdistance=$maxdistance&";
    }
    if (apartmentscount != null && apartmentscount!.toString().isNotEmpty) {
      q += "apartmentscount=$apartmentscount&";
    }
    if (bedroomscount != null && bedroomscount!.toString().isNotEmpty) {
      q += "bedroomscount=$bedroomscount&";
    }
    if (interface != null && interface!.toString().isNotEmpty) {
      q += "interface=$interface&";
    }
    if (age != null && age!.toString().isNotEmpty) {
      q += "age=$age&";
    }
    if (bathroomsCount != null && bathroomsCount!.toString().isNotEmpty) {
      q += "bathroomsCount=$bathroomsCount&";
    }
    if (streetwidth != null && streetwidth!.toString().isNotEmpty) {
      q += "streetwidth=$streetwidth&";
    }
    if (shopscount != null && shopscount!.toString().isNotEmpty) {
      q += "shopscount=$shopscount&";
    }
    if (latest != null && latest!.toString().isNotEmpty) {
      q += "latest=$latest&";
    }
    if (cheaper != null && cheaper!.toString().isNotEmpty) {
      q += "cheaper=$cheaper&";
    }
    if (search != null && search!.toString().isNotEmpty) {
      q += "search=$search&";
    }
    if (map != null && map!.toString().isNotEmpty) {
      q += "map=$map&";
    }
    if (q == "?") {
      q = "";
    }
    if (q.endsWith("&")) {
      q = q.substring(0, q.length - 1);
    }
    return q;
  }
}
