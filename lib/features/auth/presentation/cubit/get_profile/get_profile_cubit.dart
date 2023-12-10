import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../domain/models/login.dart';
import '../../../domain/usecase/get_profile.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit({required this.getProfile}) : super(GetProfileInitial());
  static GetProfileCubit get(BuildContext context) => BlocProvider.of(context);
  //Use case
  final GetProfile getProfile;

  User? _user;
  User get user {
    return _user!;
  }

  set updateUser(User newUser) => _user = newUser;
  //functions
  Future<void> fGetProfile() async {
    emit(GetProfileLoadingState());
    final failOrUser = await getProfile(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetProfileErrorState(message: fail.message));
      }
    }, (getProfileResponse) {
      _user = getProfileResponse.data;
      emit(GetProfileLoadedState(profileData: _user!));
    });
  }
}
