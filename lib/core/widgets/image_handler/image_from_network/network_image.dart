import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String link ="https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg";

class CachedImage extends StatelessWidget {
  const CachedImage({Key? key,required this.imageUrl,this.width,this.height,this.imageBuilder,this.fit=BoxFit.fill}) : super(key: key);
  final String imageUrl;
  final double?width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext,ImageProvider)? imageBuilder;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        fit: fit,
        imageUrl:imageUrl,height: height?.h,width: width?.w,
        imageBuilder: imageBuilder,
        // placeholder: (context, url) =>
        //     PlaceHolderImage(height: height,width: width, ),
        // errorWidget: (context, url, error) =>
        //     ErrorImage(height: height,width: width, )
    );
  }
}
