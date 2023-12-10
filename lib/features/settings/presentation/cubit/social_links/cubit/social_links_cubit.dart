import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../domain/models/social_links.dart';
import '../../../../domain/usecase/social_links.dart';

part 'social_links_state.dart';

class SocialLinksCubit extends Cubit<SocialLinksState> {
  SocialLinksCubit(this.usecase) : super(SocialLinksInitial());
  final SocialLinksUsecase usecase;

  SocialLinksResponse? _data;
  SocialLinksResponse get data {
    return _data!;
  }

  Future<void> fSocialLinks() async {
    emit(SocialLinksLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(SocialLinksErrorState(message: fail.message));
      }
    }, (socialLinks) {
      _data = socialLinks;
      emit(SocialLinksSuccessState(response: socialLinks));
    });
  }
}
