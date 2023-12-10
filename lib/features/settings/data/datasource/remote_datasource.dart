import 'package:aquar/features/settings/domain/usecase/send_image.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/models/about_us.dart';
import '../../domain/models/social_links.dart';
import '../../domain/models/terms.dart';
import '../../domain/models/terms_annonce.dart';

const String termsApi = '/terms-conditions';
const String aboutUsApi = '/about';
const String socialLinksApi = '/show-settings';
const String termsAnnonceApi = '/adv-terms';
const String privacyPolicyApi = '/privacy-policy';

const sendessageApi = "/contact-us";

abstract class SettingsRemoteDatasource {
  Future<TermsResponse> terms({required NoParams params});
  Future<TermsResponse> privacyPolicy({required NoParams params});
  Future<SocialLinksResponse> socialLinks();
  Future<TermsAnnonceResponse> termsAnnonce({required NoParams params});
  Future<AboutUsResponse> aboutUs({required NoParams params});
  Future<void> sendMessage({required SendMessageParams params});
}

class SettingsRemoteDatasourceImpl extends SettingsRemoteDatasource {
  final ApiBaseHelper helper;
  SettingsRemoteDatasourceImpl({required this.helper});

  @override
  Future<TermsResponse> terms({required NoParams params}) async {
    try {
      final response = await helper.get(url: termsApi);
      if (response['success'] == true) {
        final terms = TermsResponse.fromJson(response);
        return terms;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<TermsResponse> privacyPolicy({required NoParams params}) async {
    try {
      final response = await helper.get(url: privacyPolicyApi);
      if (response['success'] == true) {
        final terms = TermsResponse.fromJson(response);
        return terms;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<AboutUsResponse> aboutUs({required NoParams params}) async {
    try {
      final response = await helper.get(url: aboutUsApi);
      if (response['success'] == true) {
        final aboutUs = AboutUsResponse.fromJson(response);
        return aboutUs;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<TermsAnnonceResponse> termsAnnonce({required NoParams params}) async {
    try {
      final response = await helper.get(url: termsAnnonceApi);
      if (response['success'] == true) {
        final termsAnnonce = TermsAnnonceResponse.fromJson(response);
        return termsAnnonce;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SocialLinksResponse> socialLinks() async {
    try {
      final response = await helper.get(url: socialLinksApi);
      if (response['success'] == true) {
        final socialLinks = SocialLinksResponse.fromJson(response);
        return socialLinks;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> sendMessage({required SendMessageParams params}) async {
    try {
      await helper.post(url: sendessageApi, body: params.toMap());
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
