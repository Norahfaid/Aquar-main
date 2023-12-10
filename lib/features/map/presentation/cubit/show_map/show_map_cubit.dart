import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'show_map_state.dart';

class ShowMapCubit extends Cubit<ShowMapState> {
  ShowMapCubit() : super(ShowMapInitial());
  static ShowMapCubit get(BuildContext context) => BlocProvider.of(context);

  final Completer<GoogleMapController> controller = Completer();
}
