import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/regines_entity.dart';
import '../../../../domain/usecase/regins_usecase.dart';

part 'get_regions_state.dart';

class GetRegionsCubit extends Cubit<GetRegionsState> {
  GetRegionsCubit(this.usecase) : super(GetRegionsInitial());

  final GetReginsUseCase usecase;

  List<Regions> subCategories = [];

  Regions? selectCategory;
  clear() {
    selectCategory = null;
  }

  Future<void> fGetRegions({required int cityId}) async {
    emit(GetRegionsLoading());
    final failOrUser = await usecase(ReginsParams(cityId: cityId));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetRegionsError(message: fail.message));
      }
    }, (response) {
      subCategories = response.data.data;
      if (subCategories.isNotEmpty) {
        selectCategory = subCategories.first;
      }
      emit(GetRegionsSuccess());
    });
  }

  chooseSubCategory({
    required Regions model,
    required BuildContext context,
  }) {
    selectCategory = model;
    emit(GetRegionsInitial());
    emit(GetRegionsSuccess());
  }
}
