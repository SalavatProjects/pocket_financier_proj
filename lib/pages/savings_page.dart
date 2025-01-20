import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_financier_proj/bloc/money_cubit.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:intl/intl.dart';

import '../bloc/moneys_cubit.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  double _totalSavings = 0;

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _amountTextController = TextEditingController();
  final TextEditingController _desciptionTextController = TextEditingController();
  bool _isDataFilled = false;

  void _checkIsDataFilled() {
    setState(() {
      if (_amountTextController.text != '' && _desciptionTextController.text != '') {
        _isDataFilled = true;
      } else {
        _isDataFilled = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _amountTextController.dispose();
    _desciptionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
              height: 112.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 173.w,
                    padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 26.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: AppColors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My savings', style: AppStyles.quicksandW700Grey(20.sp),),
                        BlocSelector<MoneysCubit, MoneysState, List<MoneyState>>(
                          selector: (state) => state.moneys,
                          builder: (context, moneys) {
                            _totalSavings = 0;
                            for (var state in moneys) {
                              if (state.isIncome!) {
                                _totalSavings += state.value;
                              } else {
                                _totalSavings -= state.value;
                              }
                              if (_totalSavings < 0) {
                                _totalSavings = 0;
                              } else if (_totalSavings > 999999) {
                                _totalSavings = 999999;
                              }
                            }
                            return Text('\$ ${_totalSavings.toStringAsFixed(2)}', style: AppStyles.quicksandW600Black(24.sp),);
                          },
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => BlocProvider(
                            create: (context) => MoneyCubit(money: MoneyState(
                                date: _selectedDate,
                                isIncome: true,
                            )),
                            child: StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                              insetPadding: EdgeInsets.all(16.w),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 390.h,
                                  padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.r),
                                    color: AppColors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Specify the income', style: AppStyles.quicksandW600Black(24.sp),),
                                      SizedBox(height: 24.w,),
                                      Text('Enter date', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                      SizedBox(height: 8.w,),
                                      GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime(2074));
                                          if (pickedDate != null && pickedDate != _selectedDate) {
                                            setState(() {
                                              _selectedDate = pickedDate;
                                            });
                                            if (!context.mounted) return;
                                            context.read<MoneyCubit>().updateDate(_selectedDate);
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 54.w,
                                          padding: EdgeInsets.all(16.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.lightGrey, width: 1),
                                            borderRadius: BorderRadius.circular(27.r),
                                            color: AppColors.white
                                          ),
                                          child: Text(DateFormat('dd.MM.yyyy').format(_selectedDate),style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),),
                                        ),
                                      ),
                                      SizedBox(height: 16.w,),
                                      Text('Enter Amount', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                      SizedBox(height: 8.w,),
                                      Container(
                                        width: 110.w,
                                        height: 54.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.lightGrey, width: 1),
                                            borderRadius: BorderRadius.circular(27.r),
                                            color: AppColors.white
                                        ),
                                        padding: EdgeInsets.fromLTRB(16.w, 6.w, 16.w, 0),
                                        child: TextFormField(
                                          maxLength: 6,
                                          controller: _amountTextController,
                                          style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                          ],
                                          onChanged: (value) {
                                            context.read<MoneyCubit>().updateValue(double.parse(value));
                                            _checkIsDataFilled();
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            hintText: '\$0.00',
                                            hintStyle: AppStyles.nunitoW500DarkGrey(16.sp)
                                          ),
                                          buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 16.w,),
                                      Text('Enter Brief Description', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                      SizedBox(height: 8.w,),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 54.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.lightGrey, width: 1),
                                            borderRadius: BorderRadius.circular(27.r),
                                            color: AppColors.white
                                        ),
                                        padding: EdgeInsets.fromLTRB(16.w, 6.w, 16.w, 0),
                                        child: TextFormField(
                                          controller: _desciptionTextController,
                                          maxLength: 50,
                                          style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),
                                          onChanged: (value) {
                                            context.read<MoneyCubit>().updateDescription(value);
                                            _checkIsDataFilled();
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                              hintText: 'Add Description...',
                                              hintStyle: AppStyles.nunitoW500DarkGrey(16.sp)
                                          ),
                                          buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 24.w,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              _amountTextController.clear();
                                              _desciptionTextController.clear();
                                              _selectedDate = DateTime.now();
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: 142.w,
                                              height: 46.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.lightBlack, width: 1),
                                                  borderRadius: BorderRadius.circular(24.r),
                                                  color: AppColors.white
                                              ),
                                              child: Center(
                                                child: Text('Cancel', style: AppStyles.quicksandW500Black(16.sp,),),),
                                            ),
                                          ),
                                          BlocBuilder<MoneyCubit, MoneyState>(
                                          builder: (context, state) {
                                            return CupertinoButton(
                                              padding: EdgeInsets.zero,
                                            onPressed: _isDataFilled ? () {
                                              context.read<MoneysCubit>().addMoney(state);
                                              _amountTextController.clear();
                                              _desciptionTextController.clear();
                                              _selectedDate = DateTime.now();
                                              Navigator.of(context).pop();
                                            } : null,
                                            child: Opacity(
                                              opacity: _isDataFilled ? 1 : 0.5,
                                              child: Container(
                                                width: 142.w,
                                                height: 46.w,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(24.r),
                                                    gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
                                                ),
                                                child: Center(
                                                  child: Text('Save', style: AppStyles.quicksandW500White(16.sp,),),),
                                              ),
                                            ),
                                          );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              );
                            }
                            ),
                          )
                          ).then((value) {
                            _selectedDate = DateTime.now();
                          }),
                          child: Container(
                            width: 152.w,
                            height: 46.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
                            ),
                            child: Center(
                              child: Text('Income', style: AppStyles.quicksandW500White(16.sp,),),),
                          ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => BlocProvider(
                              create: (context) => MoneyCubit(money: MoneyState(
                                date: _selectedDate,
                                isIncome: false,
                              )),
                              child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.all(16.w),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 390.h,
                                          padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(32.r),
                                            color: AppColors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Specify the expense', style: AppStyles.quicksandW600Black(24.sp),),
                                              SizedBox(height: 24.w,),
                                              Text('Enter date', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                              SizedBox(height: 8.w,),
                                              GestureDetector(
                                                onTap: () async {
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(2015),
                                                      lastDate: DateTime(2074));
                                                  if (pickedDate != null && pickedDate != _selectedDate) {
                                                    setState(() {
                                                      _selectedDate = pickedDate;
                                                    });
                                                    if (!context.mounted) return;
                                                    context.read<MoneyCubit>().updateDate(_selectedDate);
                                                  }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 54.w,
                                                  padding: EdgeInsets.all(16.w),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.lightGrey, width: 1),
                                                      borderRadius: BorderRadius.circular(27.r),
                                                      color: AppColors.white
                                                  ),
                                                  child: Text(DateFormat('dd.MM.yyyy').format(_selectedDate),style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),),
                                                ),
                                              ),
                                              SizedBox(height: 16.w,),
                                              Text('Enter Amount', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                              SizedBox(height: 8.w,),
                                              Container(
                                                width: 110.w,
                                                height: 54.w,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: AppColors.lightGrey, width: 1),
                                                    borderRadius: BorderRadius.circular(27.r),
                                                    color: AppColors.white
                                                ),
                                                padding: EdgeInsets.fromLTRB(16.w, 6.w, 16.w, 0),
                                                child: TextFormField(
                                                  maxLength: 6,
                                                  controller: _amountTextController,
                                                  style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),
                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                  ],
                                                  onChanged: (value) {
                                                    // print(context.read<MoneyCubit>().state.date);
                                                    context.read<MoneyCubit>().updateValue(double.parse(value));
                                                    _checkIsDataFilled();
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: '\$0.00',
                                                      hintStyle: AppStyles.nunitoW500DarkGrey(16.sp)
                                                  ),
                                                  buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 16.w,),
                                              Text('Enter Brief Description', style: AppStyles.nunitoW600White(17.sp).copyWith(color: AppColors.black),),
                                              SizedBox(height: 8.w,),
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 54.w,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: AppColors.lightGrey, width: 1),
                                                    borderRadius: BorderRadius.circular(27.r),
                                                    color: AppColors.white
                                                ),
                                                padding: EdgeInsets.fromLTRB(16.w, 6.w, 16.w, 0),
                                                child: TextFormField(
                                                  controller: _desciptionTextController,
                                                  maxLength: 50,
                                                  style: AppStyles.nunitoW500DarkGrey(16.sp).copyWith(color: AppColors.black),
                                                  onChanged: (value) {
                                                    context.read<MoneyCubit>().updateDescription(value);
                                                    _checkIsDataFilled();
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.zero,
                                                      hintText: 'Add Description...',
                                                      hintStyle: AppStyles.nunitoW500DarkGrey(16.sp)
                                                  ),
                                                  buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 24.w,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      _amountTextController.clear();
                                                      _desciptionTextController.clear();
                                                      _selectedDate = DateTime.now();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Container(
                                                      width: 142.w,
                                                      height: 46.w,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: AppColors.lightBlack, width: 1),
                                                          borderRadius: BorderRadius.circular(24.r),
                                                          color: AppColors.white
                                                      ),
                                                      child: Center(
                                                        child: Text('Cancel', style: AppStyles.quicksandW500Black(16.sp,),),),
                                                    ),
                                                  ),
                                                  BlocBuilder<MoneyCubit, MoneyState>(
                                                    builder: (context, state) {
                                                      return CupertinoButton(
                                                        padding: EdgeInsets.zero,
                                                        onPressed: _isDataFilled ? () async {
                                                          await context.read<MoneysCubit>().addMoney(state);
                                                          _amountTextController.clear();
                                                          _desciptionTextController.clear();

                                                          _selectedDate = DateTime.now();
                                                          if(!context.mounted) return;
                                                          Navigator.of(context).pop();
                                                        } : null,
                                                        child: Opacity(
                                                          opacity: _isDataFilled ? 1 : 0.5,
                                                          child: Container(
                                                            width: 142.w,
                                                            height: 46.w,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(24.r),
                                                                gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
                                                            ),
                                                            child: Center(
                                                              child: Text('Save', style: AppStyles.quicksandW500White(16.sp,),),),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            )
                        ).then((value) {
                          _selectedDate = DateTime.now();
                        }),
                        child: Container(
                          width: 152.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: AppColors.white
                          ),
                          child: Center(
                            child: Text('Expenses', style: AppStyles.quicksandW500Black(16.sp,),),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
          ),
          SizedBox(height: 16.w,),
          BlocSelector<MoneysCubit, MoneysState, List<MoneyState>>(
          selector: (state) => state.moneys,
          builder: (context, moneys) {
            if (moneys.isNotEmpty) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(38.r),
                        color: AppColors.white
                    ),
                    child: Column(
                      children: List.generate(
                          moneys.length, (int index) =>
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.w),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 48.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 48.w,
                                        padding: EdgeInsets.all(14.w),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset('assets/icons/usd.svg', colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
                                        ),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(moneys[index].description, style: AppStyles.quicksandW600Black(20.sp),),
                                          Text(DateFormat('dd.MM.yyyy').format(moneys[index].date!), style: AppStyles.quicksandW500Black(16.sp).copyWith(color: AppColors.darkGrey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(moneys[index].isIncome! ?
                                  '+\$${moneys[index].value.toStringAsFixed(2)}'
                                      :
                                  '-\$${moneys[index].value.toStringAsFixed(2)}',
                                    style: AppStyles.quicksandW600Black(20.sp),
                                  )
                                ],
                                                    ),
                            ),
                          )),
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.r),
                      color: AppColors.white
                  ),
                  child: Text(
                    'No data yet',
                    style: AppStyles.quicksandW600Black(24.sp),
                    textAlign: TextAlign.center,),
                ),
              );
            }
            
          },
        )
        ],
      ),
    );
  }
}
