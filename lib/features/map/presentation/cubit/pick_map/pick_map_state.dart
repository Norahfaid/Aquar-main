part of 'pick_map_cubit.dart';

abstract class PickMapState extends Equatable {
  const PickMapState();

  @override
  List<Object> get props => [];
}

class PickMapInitial extends PickMapState {}

class ClearLastMarkerState extends PickMapState {}

class GetCurrentLocationState extends PickMapState {}

class PickLocationState extends PickMapState {}
class UpdateAddressState extends PickMapState {}

class ToggleLoadinState extends PickMapState {}

class PickMapGetCurrentLocationState extends PickMapState {}

class PickMapToggleLoadingState extends PickMapState {}

class PickMapClearLastMarkerState extends PickMapState {}
