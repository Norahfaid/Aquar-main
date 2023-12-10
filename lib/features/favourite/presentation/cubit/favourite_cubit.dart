import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../home/domain/models/filter.dart';
import '../../domain/usecase/get_fav.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.usecase) : super(FavouriteInitial());

  //usecase
  final GetFavouritiesUsecase usecase;

  List<AnnounceData> _favList = [];
  List<AnnounceData> get favList {
    return _favList;
  }

  Future<void> fGetFavourities() async {
    emit(GetfavouritiesLoadingState());
    _favList = [];
    final failOrUser = await usecase(GetFavParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetfavouritiesErrorState(message: fail.message));
      }
    }, (favourities) {
      _favList = favourities.data;
      emit(GetfavouritiesSuccessState());
    });
  }
}
