import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_financier_proj/pages/about_us_screen.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isTurned = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 52.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Settings', style: AppStyles.quicksandW600Black(24.sp),),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) => AboutUsScreen())
                    ),
                    child: Container(
                      width: 52.w,
                      height: 52.w,
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: SvgPicture.asset('assets/icons/queiston.svg'),
                    )
                )
              ],
            ),
          ),
          SizedBox(height: 16.w,),
          Text('This section is intended for various settings, but we haven\'t developed them yet.',
          style: AppStyles.quicksandW500LightBlack(16.sp),),
          SizedBox(height: 24.w,),
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _isTurned = !_isTurned;
                    });
                  },
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: _isTurned ? null : Border.all(color: AppColors.lightBlack, width: 1),
                      gradient: _isTurned ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.blueLight, AppColors.blueDark]) : null
                    ),
                    child: _isTurned ? SvgPicture.asset('assets/icons/mark.svg') : SizedBox.shrink(),
                  )
              ),
              SizedBox(width: 16.w,),
              Text('Turn off notifications', style: AppStyles.quicksandW500Black(20.sp),)
            ],
          )
        ],
      ),
    );
  }
}
