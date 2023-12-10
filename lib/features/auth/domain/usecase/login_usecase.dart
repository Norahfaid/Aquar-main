import 'register_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/login.dart';
import '../repository/auth_repo.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository repository;
  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await repository.login(params: params);
  }
}

class LoginParams {
  String? phone;
  String? password;
  String? deviceToken;

  LoginParams({
    this.phone,
    this.password,
    this.deviceToken,
  });
  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(phone: map['phone'], password: map['password']);
  }

  factory LoginParams.fromRegisterParams(RegisterParams params) {
    return LoginParams(
      phone: params.phone,
      password: params.password,
    );
  }
}
