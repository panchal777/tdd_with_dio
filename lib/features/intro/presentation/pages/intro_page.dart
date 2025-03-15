import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdd_with_dio/core/helper/image_constant.dart';
import 'package:tdd_with_dio/core/router/route_name.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/styles/app_colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.articlesPage,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Image.asset(
              ImageConstant.logo,
              color: Helper.isDarkTheme() ? AppColors.white : null,
              // width: 300.w,
              //  height: 300.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
