import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/filter.dart';
import '../../../../domain/usecase/aquar_details.dart';

part 'aquar_details_state.dart';

class AquarDetailsCubit extends Cubit<AquarDetailsState> {
  AquarDetailsCubit(this.usecase) : super(AquarDetailsInitial());

  final AquarDetailsUseCase usecase;
  AnnounceData? _data;
  AnnounceData get annonceData {
    return _data!;
  }

  int? _aquarId;
  int get aquarId {
    return _aquarId!;
  }

  // int? aquarId;
  Future<void> fAquarDetails(
      {required int id, required bool fromDetails}) async {
    emit(AquarDetailsLoadingState());
    _aquarId = id;
    final failOrUser =
        await usecase(AquarDetailsParams(id: id, fromDetails: fromDetails));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(AquarDetailsErrorState(message: fail.message));
      }
    }, (aquarDetails) {
      _data = aquarDetails.data;
      emit(AquarDetailsSuccessState());
    });
  }
}
