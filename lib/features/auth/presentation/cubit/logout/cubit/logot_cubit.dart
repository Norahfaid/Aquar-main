import 'package:aquar/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import 'logot_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.logout) : super(LogoutInitial());

  static LogoutCubit get(BuildContext context) => BlocProvider.of(context);
  //Use case
  final LogoutUseCase logout;

  //params
  LogoutParams logoutParams = LogoutParams();

  Future<void> fLogout() async {
    logoutParams.fcmToken = 'fcm_token';
    emit(LogoutLoadingState());
    final failOrUser = await logout(logoutParams);
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(LogoutErrorState(message: fail.message));
      }
    }, (logoutResponse) {
      logoutParams = LogoutParams();
      emit(LogoutSuccessState(logoutResponse: logoutResponse));
      // sl<AppNavigator>().pushReplacement(screen: const MyApp());
    });
  }
}
