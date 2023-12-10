import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../domain/models/about_us.dart';
import '../../../../domain/usecase/about_us.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit(this.usecase) : super(AboutUsInitial());

  final AboutUsUsecase usecase;
  Future<void> fGetAboutUs() async {
    emit(AboutUsLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(AboutUsErrorState(message: fail.message));
      }
    }, (aboutUs) {
      // user2 = getProfileResponse.data;
      emit(AboutUsSuccessState(response: aboutUs));
    });
  }
}
