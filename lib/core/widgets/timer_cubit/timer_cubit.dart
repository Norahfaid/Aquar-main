import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timer_states.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  static TimerCubit get(BuildContext context) => BlocProvider.of(context);
  Timer? timer;
  Timer? debounce;
  int start = 59;

  bool timerVisibility = true;

  var oneSec = const Duration(seconds: 1);
  String twoDigits(int number) => number.toString().padLeft(1, '0');
  void startTimer() {
    start = 59;
    timer = Timer.periodic(
      oneSec,
      (Timer newTimer) {
        if (start == 0) {
          newTimer.cancel();
          emit(TimerEnd());
        } else {
          emit(TimerStart());
          start--;
        }
      },
    );
  }

  void cancelTimer() {
    if (timer != null) {
      timer?.cancel();

      emit(TimerEnd());
      emit(CancelTimer());
    }
  }
}
