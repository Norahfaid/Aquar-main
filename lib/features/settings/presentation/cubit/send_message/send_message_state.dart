part of 'send_message_cubit.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageError extends SendMessageState {
  const SendMessageError({required this.message});
  final String message;
}
