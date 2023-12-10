import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';

class PropertyInfoWidget extends StatelessWidget {
  final String title;
  final String data;
  final bool isLocation;
  final String? lat;
  final String? lng;
  const PropertyInfoWidget(
      {super.key,
      required this.title,
      required this.data,
      this.isLocation = false,
      this.lat,
      this.lng});

  @override
  Widget build(BuildContext context) {
    if ((data == "0" || data.isEmpty) && !isLocation) {
      return const SizedBox();
    }
    return SizedBox(
      height: 30,
      // color: mainColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
            width: screenWidth / 2.8,
            child: Text(
              title,
              style: TextStyles.textViewRegular15
                  .copyWith(color: const Color(0xff6e6c6c)),
            )),
        SizedBox(
          width: screenWidth / 2.8,
          child: isLocation
              ? InkWell(
                  onTap: () async {
                    Uri googleUrl =
                        Uri.parse("comgooglemaps://?center=$lat,$lng");
                    Uri appleUrl = Uri.parse(
                        'https://www.google.com/maps/search/?api=1&query=$lat,$lng');
                    if (await canLaunchUrl(Uri.parse("comgooglemaps://"))) {
                      log('launching com googleUrl');
                      await launchUrl(googleUrl,
                          mode: LaunchMode.externalApplication);
                    } else if (await canLaunchUrl(appleUrl)) {
                      log('launching apple url');
                      await launchUrl(appleUrl,
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch url';
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: mainColor,
                        size: 13,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(tr("view_location"),
                          style: TextStyles.textViewBold15
                              .copyWith(color: mainColor)),
                    ],
                  ),
                )
              : Text(data,
                  style: TextStyles.textViewRegular15
                      .copyWith(color: const Color(0xff000000))),
        ),
      ]),
    );
  }
}
