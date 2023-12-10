// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aquar/features/settings/domain/repo/settings_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';

class SendMessage extends UseCase<Unit, SendMessageParams> {
  final SettingsRepository repository;

  SendMessage({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(SendMessageParams params) async {
    return await repository.sendMessage(params: params);
  }
}

class SendMessageParams {
  final String name;
  final String email;
  final String phone;
  final String message;
  SendMessageParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "message": message,
    };
  }
}
