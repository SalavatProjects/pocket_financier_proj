import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppStyles {

  static TextStyle quicksandW700Grey(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.4,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.grey,
    );
  }

  static TextStyle quicksandW600Black(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.1,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
  }

  static TextStyle quicksandW500Black(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.2,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    );
  }

  static TextStyle quicksandW500LightBlack(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.2,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlack,
    );
  }

  static TextStyle quicksandW500White(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.2,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    );
  }

  static TextStyle quicksandW500Green(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.2,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.green,
    );
  }

  static TextStyle quicksandW500Red(double fontSize) {
    return TextStyle(
      fontFamily: 'Quicksand',
      height: 1.2,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.red,
    );
  }

  static TextStyle nunitoW600White(double fontSize) {
    return TextStyle(
      fontFamily: 'Nunito',
      height: 1,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  static TextStyle nunitoW500DarkGrey(double fontSize) {
    return TextStyle(
      fontFamily: 'Nunito',
      height: 1.25,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.darkGrey,
    );
  }
}