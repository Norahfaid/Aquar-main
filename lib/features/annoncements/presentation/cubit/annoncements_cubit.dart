import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'annoncements_state.dart';

class AnnoncementsCubit extends Cubit<AnnoncementsState> {
  AnnoncementsCubit() : super(AnnoncementsInitial());
}
