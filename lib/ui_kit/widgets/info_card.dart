import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:blur/blur.dart';

class InfoCard extends StatelessWidget {
  String imagePath;
  String name;
  String text;
  void Function() onPressed;

  InfoCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 270.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: AppColors.white
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onPressed,
              child: Container(
                height: 199.w,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.w),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fitWidth)
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Blur(
                        borderRadius: BorderRadius.circular(26.r),
                        blurColor: AppColors.grey,
                        overlay: Center(
                          child: Text(name, style: AppStyles.quicksandW500White(20.sp),),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 14.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26.r),
                          ),
                          child: Text(name, style: AppStyles.quicksandW500White(20.sp).copyWith(color: AppColors.grey),),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Blur(
                        borderRadius: BorderRadius.circular(26.r),
                        blurColor: AppColors.grey,
                        overlay: Center(
                          child: SvgPicture.asset('assets/icons/arrow_right_up.svg'),
                        ),
                        child: Container(
                          width: 52.w,
                          height: 52.w,
                          padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 14.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
              child: Text(
                text,
                style: AppStyles.quicksandW500Black(16.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
