import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:pocket_financier_proj/utils/constants.dart';

class InfoScreen extends StatelessWidget {
  int index;
  bool isNews;

  InfoScreen({
    super.key,
    required this.index,
    required this.isNews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                width: 240.w,
                child: Image.asset('assets/images/charts_up.png', fit: BoxFit.fitWidth,)),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
                width: 260.w,
                child: Image.asset('assets/images/charts_down.png', fit: BoxFit.fitWidth,)),
          ),
          SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 52.w,
                          height: 52.w,
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset('assets/icons/arrow_left.svg'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: AppColors.white
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(isNews ? AppConstants.newsInfo[index].$2 : AppConstants.studyInfo[index].$2),
                                      SizedBox(height: 16.w,),
                                      Text(isNews ? AppConstants.newsInfo[index].$3 : AppConstants.studyInfo[index].$3,
                                      style: AppStyles.quicksandW600Black(20.sp),),
                                      SizedBox(height: 32.w,),
                                      Text(isNews ? AppConstants.newsInfo[index].$4 : AppConstants.studyInfo[index].$4,
                                      style: AppStyles.quicksandW500Black(16.sp),),
                                      SizedBox(height: 12.w,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),


    );
  }
}
