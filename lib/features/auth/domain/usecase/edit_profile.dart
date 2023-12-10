import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/get_profile.dart';
import '../repository/auth_repo.dart';

class EditProfile extends UseCase<GetProfileResponse, EditProfileParams> {
  final AuthRepository repository;
  EditProfile({required this.repository});
  @override
  Future<Either<Failure, GetProfileResponse>> call(
      EditProfileParams params) async {
    return await repository.editProfile(editProfileParams: params);
  }
}

class EditProfileParams {
  String? name;
  String? phone;
  String? pass;
  String? passConfirm;
  String? oldPass;
  File? avatar;
  EditProfileParams({
    this.name,
    this.oldPass,
    this.pass,
    this.passConfirm,
    this.phone,
    this.avatar,
  });
}
