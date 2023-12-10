import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../domain/models/user_ads_counts.dart';
import '../../../../domain/usecase/user_ads_count.dart';
import 'get_user_ads_count_events.dart';

part 'get_user_ads_count_state.dart';

class GetUserAdsCountCubit extends Cubit<GetUserAdsCountState> implements GetUserAdsCountEvents {
  GetUserAdsCountCubit(this.usecase) : super(GetUserAdsCountInitial());

  final UserAdsCountsUseCase usecase;

  @override
  Future<void> fGetNetWorkTypes() async {
    emit(UserAdsCountsLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(UserAdsCountsErrorState(message: fail.message));
      }
    }, (adsCount) {
      emit(UserAdsCountsSuccessState(adsCount: adsCount));
    });
  }
}
