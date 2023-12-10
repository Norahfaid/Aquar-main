import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../domain/models/cities_entity.dart';
import '../../../../domain/usecase/cities_usecase.dart';
import '../../get_regions/cubit/get_regions_cubit.dart';

part 'get_cities_state.dart';

class GetCitiesCubit extends Cubit<GetCitiesState> {
  GetCitiesCubit(this.usecase) : super(GetCitiesInitial());

  final GetCitiesUseCase usecase;
  List<CitiesList> _data = [];
  List<CitiesList> get citiesList {
    return _data;
  }

  CitiesList? _selectCity;
  CitiesList? get selectCity {
    return _selectCity;
  }

  clear() {
    _selectCity = null;
  }

  Future<void> fGetCities() async {
    emit(GetCitiesLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetCitiesErrorState(message: fail.message));
      }
    }, (cities) {
      _data = cities.data.data;

      emit(GetCitiesSuccessState());
    });
  }

  chooseCity(CitiesList model, BuildContext context) {
    _selectCity = model;
    // id = _selectCity!.id;
    emit(GetCitiesInitial());
    emit(GetCitiesSuccessState());
    context.read<GetRegionsCubit>().fGetRegions(cityId: model.id);
  }
}
