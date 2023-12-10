part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsSuccessState extends NotificationsState {
  final List<NotificationList> data;

  const GetNotificationsSuccessState({required this.data});
}

class GetNotificationsErrorState extends NotificationsState {
  final String message;

  const GetNotificationsErrorState({required this.message});
}

class GetNotificationsLoadingState extends NotificationsState {}
