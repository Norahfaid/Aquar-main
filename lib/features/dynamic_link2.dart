// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:aquar/features/home/domain/models/add_annoncement_response.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// // import 'package:tellmeastorymom/commonWidgets/storypage.dart';
// // import 'package:tellmeastorymom/providers/annonceData.dart';
// import 'package:flutter/material.dart';

// // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

// class FirebaseDynamicLinkService{

//   static Future<String> createDynamicLink(bool  short, AnnonceData annonceData) async{
//     String linkMessage;

//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'u9DC',
//       link: Uri.parse('Link you want to parse'),
//       androidParameters: const AndroidParameters(
//         packageName: 'your package name',
//         minimumVersion: 125,
//       ),
//     );

//     Uri url;
//     if (short) {
//       final ShortDynamicLink shortLink = await parameters.buildShortLink();
//       url = shortLink.shortUrl;
//     } else {
//       url = await parameters.buildUrl();
//     }

//     linkMessage = url.toString();
//     return linkMessage;
//   }

//   static Future<void> initDynamicLink(BuildContext context)async {
//     FirebaseDynamicLinks.instance.onLink(
//       onSuccess: (PendingDynamicLinkData dynamicLink) async{
//         final Uri deepLink = dynamicLink.link;

//         var isStory = deepLink.pathSegments.contains('annonceData');
//         // TODO :Modify Accordingly
//         if(isStory){
//           String id = deepLink.queryParameters['id']!;
//           // TODO :Modify Accordinglya

//           if(deepLink!=null){

//             // TODO : Navigate to your pages accordingly here

//             // try{
//             //   await firebaseFirestore.collection('Stories').doc(id).get()
//             //       .then((snapshot) {
//             //         annonceData annonceData = annonceData.fromSnapshot(snapshot);
//             //
//             //         return Navigator.push(context, MaterialPageRoute(builder: (context) =>
//             //           StoryPage(story: annonceData,)
//             //         ));
//             //   });
//             // }catch(e){
//             //   print(e);
//             // }
//           }else{
//             return null;
//           }
//         }
//       }, onError: (OnLinkErrorException e) async{
//         print('link error');
//       }
//     );


//     final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
//     try{
//       final Uri deepLink = data.link;
//       var isStory = deepLink.pathSegments.contains('annonceData');
//       if(isStory){ // TODO :Modify Accordingly
//         String id = deepLink.queryParameters['id']; // TODO :Modify Accordingly

//         // TODO : Navigate to your pages accordingly here

//         // try{
//         //   await firebaseFirestore.collection('Stories').doc(id).get()
//         //       .then((snapshot) {
//         //     annonceData annonceData = annonceData.fromSnapshot(snapshot);
//         //
//         //     return Navigator.push(context, MaterialPageRoute(builder: (context) =>
//         //         StoryPage(story: annonceData,)
//         //     ));
//         //   });
//         // }catch(e){
//         //   print(e);
//         // }
//       }
//     }catch(e){
//       print('No deepLink found');
//     }
//   }
// }