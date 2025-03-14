import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tdd_with_dio/core/helper/image_constant.dart';
import '../../../core/helper/helper.dart';
import '../../../core/styles/app_colors.dart';

class ReloadWidget extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final String image;
  final Color? iconColor;

  ReloadWidget.empty({
    super.key,
    required this.content,
    this.onPressed,
    this.iconColor,
  }) : image =
           Helper.isDarkTheme()
               ? ImageConstant.noDataDarkSvg
               : ImageConstant.noDataLightSvg;

  const ReloadWidget.error({
    super.key,
    required this.content,
    required this.onPressed,
    this.iconColor,
  }) : image = "assets/svg_images/error.svg";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.5,
            child: SvgPicture.asset(image, width: 100.h, height: 100.h),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.lightGray,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (onPressed != null)
            Icon(Icons.refresh, color: iconColor ?? AppColors.black),
        ],
      ),
    );
  }
}
