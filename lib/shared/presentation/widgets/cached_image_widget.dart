import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdd_with_dio/core/helper/image_constant.dart';


class CachedImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageUrl;
  final double? radius;
  final GlobalKey _backgroundImageKey = GlobalKey();

  CachedImageWidget({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Container(
        decoration:
            radius == null
                ? null
                : BoxDecoration(
                  // image: DecorationImage(image: NetworkImage(appAdvert.imageUrl)),
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
                ),
        height: height,
        width: width,
        child:
            imageUrl != null && imageUrl != ""
                ? CachedNetworkImage(
                  key: _backgroundImageKey,
                  imageUrl: imageUrl ?? "",
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Image.asset(
                        ImageConstant.noImage,
                        fit: BoxFit.contain,
                      ),
                )
                : Image.asset(
                  ImageConstant.noImage,
                  height: height,
                  width: width,
                  fit: BoxFit.contain,
                ),
      ),
    );
  }
}
