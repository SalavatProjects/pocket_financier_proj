import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_financier_proj/pages/info_screen.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:pocket_financier_proj/ui_kit/widgets/widgets.dart';
import 'package:pocket_financier_proj/utils/constants.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Financial News:', style: AppStyles.quicksandW600Black(24.sp),),
          SizedBox(height: 2.h,),
          Text('Key Insights for 2025', style: AppStyles.quicksandW600Black(24.sp).copyWith(color: AppColors.blueDark),),
          SizedBox(height: 8.w,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(AppConstants.newsInfo.length,
                        (index) => InfoCard(
                        imagePath: AppConstants.newsInfo[index].$2,
                        name: AppConstants.newsInfo[index].$1,
                        text: AppConstants.newsInfo[index].$4,
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) =>
                                InfoScreen(index: index, isNews: true,))
                        ))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
