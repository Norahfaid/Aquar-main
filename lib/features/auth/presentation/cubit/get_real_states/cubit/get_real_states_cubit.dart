import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/real_state_types.dart';
import '../../../../domain/usecase/real_states_usecase.dart';

part 'get_real_states_state.dart';

class GetRealStatesCubit extends Cubit<GetRealStatesState> {
  GetRealStatesCubit(this.usecase) : super(GetRealStatesInitial());
  final GetRealStatesUseCase usecase;

  List<RealStates> _raelStateList = [];
  List<RealStates> get raelStateList {
    return _raelStateList;
  }

  RealStates? _selectRealState;
  RealStates? get selectState {
    return _selectRealState;
  }

  RealStatesParams params = RealStatesParams();
  Future<void> fGetRealStates() async {
    emit(GetRealStatesLoadingState());
    final failOrUser = await usecase(RealStatesParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetRealStatesErrorState(message: fail.message));
      }
    }, (realStates) {
      _raelStateList = realStates.data.data;
      emit(GetRealStatesSuccessState(data: realStates.data.data));
    });
  }

  chooseRealState(String value) {
    emit(GetRealStatesInitial());
    params.id = value;
    emit(GetRealStatesSuccessState(data: _raelStateList));
  }
}
