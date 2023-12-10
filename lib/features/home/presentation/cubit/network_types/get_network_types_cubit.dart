


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/models/network_types.dart';
import '../../../domain/usecase/network_types.dart';
import 'network_types_state.dart';

class GetNetWorkTypesCubit extends Cubit<GetNetWorkTypesState> {
  GetNetWorkTypesCubit(this.usecase) : super(GetNetWorkTypesInitial());
  final NetWorkTypesUseCase usecase;

  List<NetWorkTypes> _data = [];
  List<NetWorkTypes> get data {
    return _data;
  }

  NetWorkTypes? _selectNetWork;
  NetWorkTypes? get selectNetWork {
    return _selectNetWork;
  }
  NetWorkTypesParams params =NetWorkTypesParams();
  Future<void> fGetNetWorkTypes() async {
    emit(GetNetWorkTypesLoadingState());
    final failOrUser = await usecase(NetWorkTypesParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetNetWorkTypesErrorState(message: fail.message));
      }
    }, (networkTypes) {
      _data = networkTypes.data.data;
      emit(GetNetWorkTypesSuccessState(data: networkTypes.data.data));
    });
  }
  chooseNetWorkType(String value) {
    params.id = value;
    emit(GetNetWorkTypesInitial());
    emit(ChooseRealStateState());
  }

}
