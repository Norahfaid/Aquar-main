import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/util/app_navigator.dart';
import '../core/widgets/toast.dart';
import '../injection_container/injection_container.dart';
import 'home/presentation/cubit/aquar_details/cubit/aquar_details_cubit.dart';
import 'home/presentation/pages/aquar_details_screen.dart';
import 'settings/presentation/cubit/social_links/cubit/social_links_cubit.dart';

Future<void> initDynamicLinks() async {
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    final Uri deepLink = dynamicLinkData.link;
    handlingDynamicLinks(deepLink: deepLink);
    log('DEEP LINK 111: ${deepLink.path}');
    log('DEEP LINK 222: $deepLink}');
  }).onError((error) {
    showToast(error + "===================================");
  });
  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  // log("dynamic link succccesss=============");
  // if (initialLink != null) {
  //   final Uri deepLink = initialLink.link;
  //   log('DEEP LINK 333: ${deepLink.path}');
  //   log('DEEP LINK 444: $deepLink}');
  //   handlingDynamicLinks(
  //     deepLink: deepLink,
  //   );
  // }
}

// int? id2;
void handlingDynamicLinks({required Uri deepLink, int? id}) {
  log(":rocket: ~ file: dynamic_links_service.dart ~ line 34 ~ void handlingDynamicLinks ~ $deepLink");
  if (deepLink.toString().contains('/advertisements/')) {
    int id = int.parse(deepLink.path.split('/').last);
    // id2 = id;
    sl<AquarDetailsCubit>()
        .fAquarDetails(id: id, fromDetails: false)
        .then((value) {
      final data = sl<AquarDetailsCubit>().annonceData;
      // sl<AquarDetailsCubit>().aquarId != id;
      sl<AppNavigator>().popToFrist();
      sl<AppNavigator>().push(
          screen: AquarDetailsScreen(
        data: data,
        fromUnderReview: false,
        aqratScreen: false,
        fromMap: false,
      ));
    });
  }
  if (deepLink.toString().contains('/services/')) {
    // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
    //   AppRoutes.serviceDetails,
    //   arguments: {
    //     'id': int.parse(deepLink.path.split('/')[4]),
    //     "isEdit": false,
    //   },
    // );
  }
}

Future<void> createDynamicLink(bool short, String link, String message) async {
  debugPrint(' DEEP LINK LINK: $link', wrapWidth: 1024);
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://aquar1.page.link',
    link: Uri.parse(link),
    androidParameters: const AndroidParameters(
      packageName: 'com.moltaqa.aquar',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      appStoreId: '6445955617',
      bundleId: 'com.moltaqa.aquar',
      minimumVersion: '0',
      // fallbackUrl: Uri.parse("https://apps.apple.com/us/app/id6445955617")
    ),
  );
  final Uri uri;
  if (short) {
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    uri = shortDynamicLink.shortUrl;
  } else {
    uri = await dynamicLinks.buildLink(parameters);
  }
  await sl<SocialLinksCubit>().fSocialLinks();
  final data = sl<SocialLinksCubit>().data;
  final aquarId = sl<AquarDetailsCubit>().aquarId;
  log("${aquarId.toString()}======================================================");
  final whatsLink = Uri.parse(
      "whatsapp://send?phone=${data.data.whatsApp} &text=$message $uri");
  await launchUrl(whatsLink);
  // Share.share('$message \n\n$uri');
}

Future<void> createDynamicLinkToShare(
    bool short, String link, String message) async {
  debugPrint(' DEEP LINK LINK: $link', wrapWidth: 1024);
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://aquar1.page.link',
    link: Uri.parse(link),
    androidParameters: const AndroidParameters(
      packageName: 'com.moltaqa.aquar',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      appStoreId: '6445955617',
      bundleId: 'com.moltaqa.aquar',
      minimumVersion: '0',
      // fallbackUrl: Uri.parse("https://apps.apple.com/us/app/id6445955617")
    ),
  );
  final Uri uri;
  if (short) {
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    uri = shortDynamicLink.shortUrl;
  } else {
    uri = await dynamicLinks.buildLink(parameters);
  }
  // await sl<SocialLinksCubit>().fSocialLinks();
  // // final whatsPhone = sl<SocialLinksCubit>().data.data.whatsApp;
  // final data = sl<SocialLinksCubit>().data;
  // log("${data.data.whatsApp!.toString()}======================================================");
  // final Uri phoneUri = Uri.parse("whatsapp://send?phone=${data.data.whatsApp}");
  // await launchUrl(phoneUri);
  Share.share('$message \n\n$uri');
}
 
// void openURL(url) async =>
//     await canLaunchUrl(url) ? await launchUrl(url) : throw 'Could not launch $url';

// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:share_plus/share_plus.dart';

// class DynamicLink {
// //create the link

//   Future<String> createLink({required String refCode}) async {
//     String url = 'https://com.moltaqa.aquar?ref=$refCode';

//     /// todo change uriPrefix
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         androidParameters: const AndroidParameters(

//             /// we maybe make  minimumVersion: 0,
//             packageName: "com.moltaqa.aquar",
//             minimumVersion: 21),
//         iosParameters: const IOSParameters(

//             /// we maybe make  minimumVersion: '0',
//             bundleId: "com.moltaqa.aquar",
//             minimumVersion: '21'),
//         link: Uri.parse(url),
//         uriPrefix: 'https://aquar.page.link');
//     final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
//     final refLink = await link.buildShortLink(parameters);
//     return refLink.shortUrl.toString();
//   }

//   /// init dynamicLink
//   void initDynamicLick() async {
//     final instanceLink =
//         await FirebaseDynamicLinksPlatform.instance.getInitialLink();
//     final Uri refLink = instanceLink!.link;
//     // Share.share("this is the link ${refLink.data}");
//     Share.share("this is the link ${refLink.queryParameters["ref"]}");
//   }
// }

// // void initDynamicLick2() {
// //   FirebaseDynamicLinks.instance.onLink(
// //     onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
// //       final Uri deepLink = dynamicLinkData!.link;
// //     },
// //     onError: (OnLinkErrorException? e)async {

// //     },
// //   );
// // }
