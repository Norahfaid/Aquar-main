import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'aquar_state.dart';

class AquarCubit extends Cubit<AquarState> {
  AquarCubit() : super(AquarInitial());
}
