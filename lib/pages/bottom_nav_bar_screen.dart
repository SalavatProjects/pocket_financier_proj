import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_financier_proj/bloc/money_cubit.dart';
import 'package:pocket_financier_proj/pages/currency_page.dart';
import 'package:pocket_financier_proj/pages/news_page.dart';
import 'package:pocket_financier_proj/pages/savings_page.dart';
import 'package:pocket_financier_proj/pages/settings_page.dart';
import 'package:pocket_financier_proj/pages/study_page.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:blur/blur.dart';
import 'package:pocket_financier_proj/utils/constants.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    CurrencyPage(),
    SavingsPage(),
    StudyPage(),
    NewsPage(),
    SettingsPage(),
  ];


  @override
  void dispose() {
    super.dispose();
  }

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
              child: _pages[_currentPage]
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Blur(
                borderRadius: BorderRadius.circular(33.r),
                overlay: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomNavBarBtn(
                        text: 'Currency',
                        imagePath: 'assets/icons/usd.svg',
                        isSelected: _currentPage == 0,
                        onPressed: () {
                          setState(() {
                            _currentPage = 0;
                          });
                        },
                      ),
                      BottomNavBarBtn(
                        text: 'Moneybox',
                        imagePath: 'assets/icons/moneybox.svg',
                        isSelected: _currentPage == 1,
                        onPressed: () {
                          setState(() {
                            _currentPage = 1;
                          });
                        },
                      ),
                      BottomNavBarBtn(
                        text: 'Study',
                        imagePath: 'assets/icons/study.svg',
                        isSelected: _currentPage == 2,
                        onPressed: () {
                          setState(() {
                            _currentPage = 2;
                          });
                        },
                      ),
                      BottomNavBarBtn(
                        text: 'News',
                        imagePath: 'assets/icons/news.svg',
                        isSelected: _currentPage == 3,
                        onPressed: () {
                          setState(() {
                            _currentPage = 3;
                          });
                        },
                      ),
                      BottomNavBarBtn(
                        text: 'Settings',
                        imagePath: 'assets/icons/settings.svg',
                        isSelected: _currentPage == 4,
                        onPressed: () {
                          setState(() {
                            _currentPage = 4;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 66.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.r),
                    color: AppColors.black.withValues(alpha: 0.2)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarBtn extends StatelessWidget {
  String text;
  String imagePath;
  bool isSelected;
  void Function() onPressed;

  BottomNavBarBtn({
    super.key,
    required this.text,
    required this.imagePath,
    this.isSelected = false,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: AppConstants.duration200,
        height: 54.w,
        decoration: isSelected ? BoxDecoration(
          borderRadius: BorderRadius.circular(27.r),
          gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
        ) : null,
        child: isSelected ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
          child: Row(
            children: [
              SvgPicture.asset(imagePath),
              SizedBox(width: 6,),
              Text(text, style: AppStyles.quicksandW500White(16.sp),)
            ],
          ),
        ) : Center(
          child: SvgPicture.asset(imagePath),),
      ),
    );
  }
}
