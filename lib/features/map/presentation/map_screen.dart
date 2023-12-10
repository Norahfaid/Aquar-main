import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../core/constant/colors/colors.dart';
import '../../../core/util/app_navigator.dart';
import '../../../core/widgets/toast.dart';
import '../../../injection_container/injection_container.dart';
import '../../home/presentation/cubit/add_annoncement/addannoncement_cubit.dart';
import 'cubit/pick_map/pick_map_cubit.dart';

const googleServicesAPIKey = "AIzaSyDuTp7RMNtSz-5z7h5utbygmA90E9enkUI";

class PickLocationMapScreen extends StatefulWidget {
  const PickLocationMapScreen(
      {super.key, this.perviousLatLng, required this.controller});
  final LatLng? perviousLatLng;
  final TextEditingController controller;
  @override
  State<PickLocationMapScreen> createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  @override
  void initState() {
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  final Mode _mode = Mode.overlay;
  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Text(response.status)));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        logo: Container(
          color: transparent,
          height: 0,
        ),
        apiKey: googleServicesAPIKey,
        onError: onError,
        mode: _mode,
        language: context.locale.languageCode,
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: tr('search'),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "eg"),
          Component(Component.country, "sa")
        ]);
    if (p != null) {
      displayPrediction(p, homeScaffoldKey.currentState);
    }
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    final bloc = context.read<PickMapCubit>();
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: googleServicesAPIKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    await bloc.pickLocation(LatLng(lat, lng));
    sl<PickMapCubit>()
        .mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickMapCubit, PickMapState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = PickMapCubit.get(context);
        return Scaffold(
          key: homeScaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(tr("add_address")),
            backgroundColor: mainColor,
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                    ),
                    onPressed: _handlePressButton,
                    child: const Icon(
                      Icons.search,
                      size: 30,
                      color: mainColor,
                    )),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              bloc.addressCoordinates = null;
              //  bloc.disposeMapController();
              Navigator.pop(context);
              return true;
            },
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              markers: bloc.markers.toSet(),
              initialCameraPosition: bloc.cameraPosition,
              onMapCreated: (GoogleMapController mapController) async {
                if (!_controller.isCompleted) {
                  _controller.complete(mapController);
                  googleMapController = mapController;
                }

                if (mounted) {
                  final current = await context
                      .read<PickMapCubit>()
                      .getUserAccessLocation();
                  // ignore: use_build_context_synchronously
                  context.read<PickMapCubit>().initMapController(
                      widget.perviousLatLng == null
                          ? LatLng(current.latitude, current.longitude)
                          : widget.perviousLatLng!,
                      mapController,
                      context);
                }
              },
              onTap: (latLng) {
                bloc.pickLocation(latLng);
              },
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                heroTag: "1",
                backgroundColor: mainColor,
                onPressed: () => bloc.getCurrentLocation(context),
                child: const Icon(
                  Icons.location_searching_sharp,
                  size: 30,
                ),
              ),
              // const Spacer(),
              bloc.isLoading
                  ? const SizedBox(child: CircularProgressIndicator())
                  : BlocBuilder<PickMapCubit, PickMapState>(
                      builder: (context, state) {
                        if (state is PickMapToggleLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return FloatingActionButton.extended(
                          heroTag: "2",
                          backgroundColor: bloc.addressCoordinates == null
                              ? greyColor
                              : mainColor,
                          onPressed: () async {
                            // onPressed: () async {
                            if (context.read<PickMapCubit>().markers.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  showToast(tr("please_choose_your_address")));
                              return;
                            }
                            final position = context
                                .read<PickMapCubit>()
                                .markers
                                .first
                                .position;
                            final latlng =
                                LatLng(position.latitude, position.longitude);
                            final addCubit =
                                context.read<AddAnnouncementCubit>();
                            await context
                                .read<PickMapCubit>()
                                .fGetStartAddressTitleFromLatLong(
                                    latlng, widget.controller);

                            addCubit.addAnnoncementParams.cordinates =
                                bloc.addressCoordinates;
                            addCubit.latLng = latlng;
                            Future.delayed(const Duration(milliseconds: 300));
                            sl<AppNavigator>().pop();
                            // },
                            // if (bloc.addressCoordinates == null) {
                            //   showToast(tr('please_select_address'));
                            // } else if (widget.perviousLatLng != null) {
                            //   context
                            //       .read<AddannoncementCubit>()
                            //       .addAnnoncementParams
                            //       .cordinates = bloc.addressCoordinates;
                            //   sl<AppNavigator>().pop();
                            // }
                            // else { log('message');
                            //   // bloc.toggleLoading();
                            //   context
                            //       .read<AddannoncementCubit>()
                            //       .addAnnoncementParams
                            //       .cordinates = bloc.addressCoordinates;
                            // log('message=========${bloc.addressCoordinates.toString()}');
                            // sl<AppNavigator>().pop();
                            // context
                            //     .read<AddAddressCubit>()
                            //     .fAddaddress()
                            //     .catchError((e, s) => bloc.toggleLoading())
                            //     .whenComplete(() {
                            //   bloc.toggleLoading();
                            //   bloc.addressCoordinates = null;
                            // });
                            // }
                          },
                          label: Text(
                            tr('add_address'),
                            style: TextStyle(
                                color: bloc.addressCoordinates == null
                                    ? blackColor
                                    : white),
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
