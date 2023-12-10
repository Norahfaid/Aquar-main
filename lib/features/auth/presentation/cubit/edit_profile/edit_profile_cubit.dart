import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../domain/models/login.dart';
import '../../../domain/usecase/edit_profile.dart';
import '../login_cubit/cubit/login_cubit_cubit.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required this.editProfile,
  }) : super(EditProfileInitial());
  static EditProfileCubit get(BuildContext context) => BlocProvider.of(context);
  //Use case
  final EditProfile editProfile;

  User? _user;
  User get user {
    return _user!;
  }

  File? _avatar;
  File? get avatar => _avatar;
  set setAvatar(File img) {
    _avatar = img;
    emit(UploadImage());
    emit(EditProfileInitial());
  }

  EditProfileParams editProfileParams = EditProfileParams();

  Future<void> fEditProfile({
    // required UserProfile profile,
    String? phone,
    String? name,
    String? oldPass,
    String? newPass,
    String? newPassConfirm,
    File? avtar,
  }) async {
    {
      emit(EditProfileLoodingState());
      final failOrUser = await editProfile(
          // editProfileParams
          EditProfileParams(
              avatar: avtar,
              name: name,
              oldPass: oldPass,
              pass: newPass,
              phone: phone,
              passConfirm: newPassConfirm));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(EditProfileErrorState(message: fail.message));
        }
      }, (userProile) {
        sl<LoginCubit>().updateUser = userProile.data;
        _user = userProile.data;
        emit(EditProfileSuccessState(userProfile: userProile.data));
      });
    }
  }

  final picker = ImagePicker();

  Future getImage(BuildContext context, ImageSource imageSource) async {
    final pickerFile = await picker.pickImage(source: imageSource);
    if (pickerFile != null) {
      editProfileParams.avatar = File(pickerFile.path);
      log("${editProfileParams.avatar}llllllgfgfgfg");
      emit(ImagesChangeStates(avatar: editProfileParams.avatar!));
    } else {
      editProfileParams.avatar = null;
      emit(ImageNotChangeState());
    }
  }
}
