part of 'privacy_policy_cubit.dart';

abstract class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();

  @override
  List<Object> get props => [];
}

class GetPrivacyPolicyInitial extends PrivacyPolicyState {}

class PrivacyPolicyLoadingState extends PrivacyPolicyState {}

class PrivacyPolicyErrorState extends PrivacyPolicyState {
  final String message;
  const PrivacyPolicyErrorState({required this.message});
}

class PrivacyPolicySuccessState extends PrivacyPolicyState {
  final TermsResponse response;
  const PrivacyPolicySuccessState({required this.response});
}
