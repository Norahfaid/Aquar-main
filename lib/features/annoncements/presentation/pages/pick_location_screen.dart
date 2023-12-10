// import 'dart:async';
// import 'dart:developer';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/widgets/toast.dart';
// import '../../../map/presentation/cubit/pick_map/pick_map_cubit.dart';
//
// class TestAddressPickLocationMapScreen extends StatefulWidget {
//   const TestAddressPickLocationMapScreen({super.key, required this.controller, this.perviousLatLng,});
//   final TextEditingController controller;
//   final LatLng? perviousLatLng;
//   @override
//   State<TestAddressPickLocationMapScreen> createState() =>
//       _TestAddressPickLocationMapScreenState();
// }
//
// class _TestAddressPickLocationMapScreenState
//     extends State<TestAddressPickLocationMapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//   late GoogleMapController googleMapController;
//   @override
//   void dispose() {
//     googleMapController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.watch<PickMapCubit>();
//     return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: GoogleMap(
//                 minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
//                 mapType: MapType.normal,
//                 zoomControlsEnabled: false,
//                 zoomGesturesEnabled: true,
//                 myLocationButtonEnabled: false,
//                 markers: bloc.markers.toSet(),
//                 initialCameraPosition: bloc.cameraPosition,
//                 onMapCreated: (GoogleMapController mapController) async {
//                   if (!_controller.isCompleted) {
//                     _controller.complete(mapController);
//                     googleMapController = mapController;
//                   }
//                   if (mounted) {
//                     final current = await context
//                         .read<PickMapCubit>()
//                         .getUserAccessLocation(context);
//                     // ignore: use_build_context_synchronously
//                     context.read<PickMapCubit>().initMapController(
//                         widget.perviousLatLng == null
//                             ? LatLng(current.latitude, current.longitude)
//                             : widget.perviousLatLng!,
//                         mapController,
//                         context);
//                   }
//                 },
//                 onTap: (latLng) {
//                   bloc.pickLocation(latLng);
//                 },
//               ),
//             )
//           ],
//         ),
//
//         floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             FloatingActionButton(
//               heroTag: "1",
//               backgroundColor: mainColor,
//               onPressed: () => bloc.getCurrentLocation(context),
//               child: const Icon(
//                 Icons.location_searching_sharp,
//                 size: 30,
//               ),
//             ),
//             // const Spacer(),
//             bloc.isLoading
//                 ? const SizedBox(child: CircularProgressIndicator())
//                 : FloatingActionButton.extended(
//               heroTag: "2",
//               backgroundColor:
//               bloc.addressCoordinates == null ? Colors.red : mainColor,
//               onPressed: () {
//                 log('message');
//                 if (bloc.addressCoordinates == null) {
//                   showToast(tr('please_select_address'));
//                 }
//                 // else if (widget.perviousLatLng != null) {
//                 //   context
//                 //       .read<EditAddressCubit>()
//                 //       .editAddressParams
//                 //       .coordinates = bloc.addressCoordinates;
//                 //   AppNavigator.pop(context: context);
//                 // } else {
//
//                   bloc.toggleLoading();
//                   context
//                       .read<AddAddressCubit>()
//                       .addAddressParams
//                       .coordinates = bloc.addressCoordinates;
//                   context
//                       .read<AddAddressCubit>()
//                       .fAddaddress()
//                       .catchError((e, s) => bloc.toggleLoading())
//                       .whenComplete(() {
//                     bloc.toggleLoading();
//                     bloc.addressCoordinates = null;
//                   });
//                 },
//               // },
//               label: Text(
//                 tr('add_address'),
//                 style: TextStyle(
//                     color: bloc.addressCoordinates == null
//                         ? blackColor
//                         : white),
//               ),
//             ),
//           ],),
//
//           // BlocBuilder<PickMapCubit,PickMapState>(
//           //     builder: (context, state) {
//           //       if (state is PickMapToggleLoadingState) {
//           //         return const CircularProgressIndicator();
//           //       }
//           //       return FloatingActionButton.extended(
//           //         heroTag: "2",
//           //         extendedPadding: const EdgeInsets.symmetric(horizontal: 64),
//           //         label: Text(tr("choose")),
//           //         backgroundColor: mainColor,
//           //         onPressed: () async {
//           //           if (context.read<PickMapCubit>().markers.isEmpty) {
//           //             ScaffoldMessenger.of(context).showSnackBar(
//           //                 showToast("please_choose_your_address"));
//           //             return;
//           //           }
//           //           final position =
//           //               context.read<PickMapCubit>().markers.first.position;
//           //           final latlng =
//           //           LatLng(position.latitude, position.longitude);
//           //           await context
//           //               .read<PickMapCubit>()
//           //               .fGetStartAddressTitleFromLatLong(
//           //               latlng, widget.controller);
//           //           Future.delayed(const Duration(milliseconds: 300));
//           //           AppNavigator.pop(
//           //             context: context,
//           //           );
//           //         },
//           //       );
//           //     },
//           //   ),
//
//         );
//   }
// }
