import 'package:aquar/features/auth/domain/usecase/get_user_types.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/user_types.dart';

part 'get_user_type_state.dart';

class GetUserTypeCubit extends Cubit<GetUserTypeState> {
  GetUserTypeCubit(this.usecase) : super(GetUserTypeInitial());

  final GetUserTypeUseCase usecase;
  List<UserType> _data = [];
  List<UserType> get userTypeList {
    return _data;
  }

  UserType? selecedUserType;
  UserType? get selectCity {
    return selecedUserType;
  }

  GetUserTypeParams params = GetUserTypeParams();
  Future<void> fGetUserType({required BuildContext context}) async {
    emit(GetUserTypeLoadingState());
    final failOrUser = await usecase(GetUserTypeParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetUserTypeErrorState(message: fail.message));
      }
    }, (userType) {
      _data = userType.data.data;
      emit(GetUserTypeSuccessState());
    });
  }

  String? userLicence;
  chooseUserType(UserType value) {
    params.userType = value;
    emit(GetUserTypeInitial());
    emit(ChooseStateState());
  }
}
