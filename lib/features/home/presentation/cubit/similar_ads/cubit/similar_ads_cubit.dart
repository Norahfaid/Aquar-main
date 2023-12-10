import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/filter.dart';
import '../../../../domain/usecase/filter_usecase.dart';

part 'similar_ads_state.dart';

class SimilarAdsCubit extends Cubit<SimilarAdsState> {
  SimilarAdsCubit(this.usecase) : super(SimilarAdsInitial());

  final FilterUsecase usecase;
  FilterParams filterParams = FilterParams();
  List<AnnounceData> filterData = [];
  int currentPage = 1;
  bool isMore = true;
  Future<void> fGetSimilarAds({
    bool? ifIsMore,
    int? map,
    String? status,
    required int id,
    required String buildingTypeId,
    bool isFirst = false,
  }) async {
    if (isFirst) {
      isMore = true;
      currentPage = 1;
      filterData = [];
    }
    isMore = ifIsMore ?? (isMore);
    if (isMore) {
      if (currentPage == 1) {
        filterData = [];
        emit(GetSimilarAdsLoadingState());
        filterParams = FilterParams(
          page: currentPage,
          buildingtype: buildingTypeId,
          status: status,
          map: map,
        );
      } else {
        filterParams.page = currentPage;
        emit(GetSimilarAdsPaginationLoadingState());
      }

      final failOrString = await usecase(filterParams);
      failOrString.fold((fail) {
        if (fail is ServerFailure) {
          emit(GetSimilarAdsErrorState(message: fail.message));
        }
      }, (reaponse) async {
        if (reaponse.data.meta != null) {
          if (currentPage < reaponse.data.meta!.lastPage) {
            currentPage += 1;
          } else {
            isMore = false;
          }
        }

        filterData = currentPage == 1
            ? reaponse.data.data
            : filterData + reaponse.data.data;

        filterData.removeWhere((element) => element.id == id);
        log("${filterData.length}llllllllllllllllllllll");
        emit(GetSimilarAdsSuccessState(
          data: filterData,
        ));
      });
    }
  }
}
