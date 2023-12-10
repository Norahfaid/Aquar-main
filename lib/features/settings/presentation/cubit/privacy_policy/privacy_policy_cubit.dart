import 'package:aquar/features/settings/domain/models/terms.dart';
import 'package:aquar/features/settings/domain/usecase/privacy_policy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  PrivacyPolicyCubit(this.privacyPolicy) : super(GetPrivacyPolicyInitial());

  final PrivacyPolicy privacyPolicy;
  Future<void> fGetPrivacyPolicy() async {
    emit(PrivacyPolicyLoadingState());
    final failOrUser = await privacyPolicy(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(PrivacyPolicyErrorState(message: fail.message));
      }
    }, (privacyPolicy) {
      emit(PrivacyPolicySuccessState(response: privacyPolicy));
    });
  }
}
