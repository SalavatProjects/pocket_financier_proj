import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_financier_proj/bloc/money_cubit.dart';
import 'package:pocket_financier_proj/pages/bottom_nav_bar_screen.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: 45.w,
                height: 76.w,
                child: Image.asset('assets/images/logo_no_background.png',fit: BoxFit.fill,),
              ),
            ),
            SizedBox(
              height: 360.h,
              child: Stack(
                children: [
                  Image(image: AssetImage('assets/images/charts_onboarding.png'), fit: BoxFit.fill,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text('Welcome to Pocket Financier!', style: AppStyles.quicksandW500Black(40.sp),),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text('Pocket Financier helps you manage your money by tracking currency rates, savings, and expenses in real-time. Stay on top of your finances!',
              style: AppStyles.quicksandW500Black(16.sp),),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => BottomNavBarScreen())
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 54.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.r),
                      color: AppColors.bluePrimary
                    ),
                    child: Center(
                      child: Text('Continue', style: AppStyles.nunitoW600White(18.sp),
                      ),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
