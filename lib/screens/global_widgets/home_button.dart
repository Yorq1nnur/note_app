import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GlobalButtonHome extends StatelessWidget {
  const GlobalButtonHome(this.voidCallback, this.iconPath, {super.key});

  final VoidCallback voidCallback;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: voidCallback,
      child: Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: AppColors.c3B3B3B,
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Center(
          child: SvgPicture.asset(iconPath, height: 24.h, width: 24.w,),
        ),
      ),
    );
  }
}
