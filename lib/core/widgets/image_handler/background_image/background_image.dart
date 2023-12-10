import 'package:flutter/material.dart';

import '../image_from_assets/placeholder_images_from_assets.dart';


class BackgroundImage extends StatelessWidget {
  final Widget child;
  final String  backgroundImage;
  const BackgroundImage({Key? key, required this.child,required this.backgroundImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.center,
      children: [
        PlaceHolderImage(image: backgroundImage,
          height: 230,
        ),
        child,
      ],
    );
  }
}
