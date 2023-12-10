import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/usecase/toggle_fav.dart';

part 'toggle_fav_state.dart';

class ToggleFavCubit extends Cubit<ToggleFavState> {
  ToggleFavCubit(this.usecase) : super(ToggleFavInitial());
  final ToggleFavouritiesUsecase usecase;

  // List<FavList> _favList = [];
  // List<FavList> get favList {
  //   return _favList;
  // }

  Future<void> fToggleFavourities({required int id}) async {
    emit(TogglefavouritiesLoadingState());
    final failOrUser = await usecase(ToggleFavParams(id: id));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(TogglefavouritiesErrorState(message: fail.message));
      }
    }, (favourities) {
      // _favList = favourities.data;
      emit(TogglefavouritiesSuccessState());
    });
  }
}
