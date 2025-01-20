import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
                child: Column(
                  children: [
                    Row(
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
                        SizedBox(width: 26.w,),
                        Text('About Us', style: AppStyles.quicksandW600Black(24.sp),),
                        Spacer(),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Container(
                            width: 52.w,
                            height: 52.w,
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/icons/about_us.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pocket Financier', style: AppStyles.quicksandW600Black(24.sp),),
                          SizedBox(height: 16.w,),
                          Text('Pocket Financier is a versatile application under the Pocket Option brand, designed to help users monitor currency exchange rates, track savings, and manage expenses efficiently.',
                          style: AppStyles.quicksandW500Black(16.sp),),
                          SizedBox(height: 16.w,),
                          Text(' With its user-friendly interface, Pocket Financier allows you to stay informed about market fluctuations while providing tools to analyze your financial habits. Whether you\'re looking to optimize your budget or keep an eye on your investments, this app offers the essential features you need to take control of your finances.',
                          style: AppStyles.quicksandW500Black(16.sp),)
                        ],
                      ),
                    ),
                    SizedBox(height: 16.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(34.r),
                                color: AppColors.white
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/terms_of_use.svg'),
                                  SizedBox(width: 8.w,),
                                  Text('Terms of Use', style: AppStyles.nunitoW600White(18.sp).copyWith(color: AppColors.black),)
                                ],
                              ),
                            ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(34.r),
                                color: AppColors.white
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/privacy_policy.svg'),
                                SizedBox(width: 8.w,),
                                Text('Privacy Policy', style: AppStyles.nunitoW600White(18.sp).copyWith(color: AppColors.black),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
