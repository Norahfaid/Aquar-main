// import 'package:aquar/features/home/presentation/pages/aquar_details_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'home/domain/models/add_annoncement_response.dart';
// import 'home/presentation/pages/home_screen.dart';

// class RouteServices {
//   // final AnnonceData data;

//   // RouteServices(this.data);
//   static Route<dynamic> generateRoute(RouteSettings routeSettings) {
//     final args = routeSettings.arguments;
//     switch (routeSettings.name) {
//       case '/homepage':
//         return CupertinoPageRoute(builder: (_) {
//           return HomeScreen();
//         });

//       case "/productpage":
//         if (args is Map) {
//           return CupertinoPageRoute(builder: (_) {
//             return AquarDetailsScreen(fromUnderReview: false, data: data);
//           });
//         }
//         return _errorRoute();
//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Page Not Found"),
//         ),
//       );
//     });
//   }
// }
