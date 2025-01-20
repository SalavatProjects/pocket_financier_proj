import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_financier_proj/ui_kit/app_colors.dart';
import 'package:pocket_financier_proj/ui_kit/app_styles.dart';
import 'package:pocket_financier_proj/utils/constants.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  bool _isBuying = true;

  String _currentCurrency = 'USD';
  List<String> _comparingCurrencies = [];

  void _switchIsBuying() {
    setState(() {
      _isBuying = !_isBuying;
    });
  }

  List<FlSpot> _generateData(bool isUp) {
    List<FlSpot> spots = [];
    Random random = Random();

    double currentValue = 5.0;
    for (int i = 0; i < 10; i++) {
      double change = random.nextDouble() * 2 - 1;
      currentValue += change;

      currentValue = currentValue.clamp(0, 10);

      spots.add(FlSpot(i.toDouble(), currentValue));
    }

    double finalValue = isUp ? random.nextDouble() * 3 + 7 : random.nextDouble() * 3; // 7-10 для роста, 0-3 для падения
    for (int i = 7; i < 10; i++) {
      spots[i] = FlSpot(i.toDouble(), _lerp(spots[i].y, finalValue, (i - 6) / 3));
    }
    return spots;
  }

  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  Future<double> _fetchData(String currentCurrency, String compareCurrency) async {
    final dio = Dio();
    final response = await dio.get('https://open.er-api.com/v6/latest/$currentCurrency');
    // print(jsonDecode(response.toString())['rates']);
    return jsonDecode(response.toString())['rates'][compareCurrency];
  }

  void _updateComparingCurrencies() {
    _comparingCurrencies.clear();
    setState(() {
      for (var elem in AppConstants.tlcCodes) {
        if (elem != _currentCurrency) {
          _comparingCurrencies.add(elem);
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _updateComparingCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Rates', style: AppStyles.quicksandW600Black(24.sp),),
          SizedBox(height: 16.w,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: AppColors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _BuyingSellingSwitcher(onPressed: () => _switchIsBuying(), isBuying: _isBuying,)),
                SizedBox(height: 24.w,),
                PullDownButton(
                  routeTheme: PullDownMenuRouteTheme(
                    width: 118.w,
                  ),
                  itemBuilder: (context) => List.generate(
                      AppConstants.tlcCodes.length,
                      (int index) => PullDownMenuItem(
                          onTap: () {
                            setState(() {
                              _currentCurrency = AppConstants.tlcCodes[index];
                              _updateComparingCurrencies();
                            });
                          },
                          title: AppConstants.tlcCodes[index],
                          iconWidget: SvgPicture.asset(
                              AppConstants.currencyContent[AppConstants.tlcCodes[index]]!.$2,
                          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
                          itemTheme: PullDownMenuItemTheme(
                              textStyle: AppStyles.quicksandW500Black(20.sp)
                          ),
                      )),
                  buttonBuilder: (context, showMenu) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: showMenu,
                      child: Container(
                        width: 118.w,
                        height: 54.w,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.r),
                          color: AppColors.lightBlue
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(AppConstants.currencyContent[_currentCurrency]!.$2,
                              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
                            Text(_currentCurrency, style: AppStyles.quicksandW500Black(20.sp),),
                            SvgPicture.asset('assets/icons/arrow_down.svg')
                          ],
                        ),
                      ),
                        );
                  }
                ),
                SizedBox(
                  height: 390.h,
                  child: ListView.builder(
                      itemCount: _comparingCurrencies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(
                            future: _fetchData(_currentCurrency, _comparingCurrencies[index]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                bool isUp = Random().nextBool();
                                List<FlSpot> spots = _generateData(isUp);
                                double percent = 0.1 + Random().nextDouble() * (0.95 - 0.1);
                                return _CurrencyDataWidget(
                                    iconPath: AppConstants.currencyContent[_comparingCurrencies[index]]!.$2,
                                    currentCurrencyIconPath: AppConstants.currencyContent[_currentCurrency]!.$2,
                                    tlsCode: _comparingCurrencies[index],
                                    name: AppConstants.currencyContent[_comparingCurrencies[index]]!.$1,
                                    value: snapshot.data!,
                                    percent: percent,
                                    spots: spots,
                                    isUp: isUp,
                                    isBuying: _isBuying,
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                      width: 48.w,
                                      height: 72.w,
                                      child: SpinKitWave(
                                        color: AppColors.lightBlue,
                                        size: 24.w,
                                      )),
                                );
                              }
                            });
                      }),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BuyingSellingSwitcher extends StatelessWidget {
  bool isBuying;
  void Function() onPressed;

  _BuyingSellingSwitcher({
    super.key,
    this.isBuying = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: 232.w,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27.r),
          color: AppColors.lightBlue
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isBuying ?
                Container(
                  width: 108.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21.r),
                    gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
                  ),
                  child: Center(
                    child: Text('Buying', style: AppStyles.quicksandW500White(16.sp),),
                  ),
                ) :
                SizedBox(
                  width: 108.w,
                  height: 42.w,
                  child: Center(
                    child: Text('Buying', style: AppStyles.quicksandW500Black(16.sp),),
                  ),
                ),
            isBuying ?
            SizedBox(
              width: 108.w,
              height: 42.w,
              child: Center(
                child: Text('Selling', style: AppStyles.quicksandW500Black(16.sp),),
              ),
            ) :
            Container(
              width: 108.w,
              height: 42.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21.r),
                  gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
              ),
              child: Center(
                child: Text('Selling', style: AppStyles.quicksandW500White(16.sp),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyDataWidget extends StatelessWidget {
  String iconPath;
  String currentCurrencyIconPath;
  String tlsCode;
  String name;
  bool isUp;
  bool isBuying;
  double value;
  double percent;
  List<FlSpot> spots;

  _CurrencyDataWidget({
    super.key,
    required this.iconPath,
    required this.currentCurrencyIconPath,
    required this.tlsCode,
    required this.name,
    this.isUp = true,
    this.isBuying = true,
    required this.value,
    required this.percent,
    required this.spots,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 48.w,
        child: Row(
          children: [
            Container(
              width: 48.w,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.blueLight, AppColors.blueDark])
              ),
              child: Center(
                child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              ),
            ),
            SizedBox(
              width: 52.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tlsCode, style: AppStyles.quicksandW600Black(20.sp),),
                  Text(name, style: AppStyles.quicksandW500Black(16.sp).copyWith(color: AppColors.darkGrey),),
                ],
              ),
            ),
            SizedBox(width: 8.w,),
            SizedBox(
                width: 90.w,
                height: 30.w,
                child: LineChart(
                LineChartData(
                lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: spots,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                      color: isUp ? AppColors.green : AppColors.red,
                      dotData: FlDotData(
                        show: false
                      ),
                      isStrokeJoinRound: true
                    ),
                    ],
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    lineTouchData: LineTouchData(enabled: false),
                    ),
                  ),
                ),
            SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        currentCurrencyIconPath,
                        colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                        height: 16.w,
                      ),
                      SizedBox(width: 2.w,),
                      Text(isBuying ?
                      (value * 1.03).toStringAsPrecision(6).substring(0, 6)
                          :
                      (value * 0.97).toStringAsPrecision(6).substring(0, 6),
                        style: AppStyles.quicksandW600Black(20.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.w,
                    width: 70.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isUp ?
                            SvgPicture.asset('assets/icons/green_triangle_up.svg')
                            :
                            SvgPicture.asset('assets/icons/red_triangle_down.svg'),
                        SizedBox(width: 4.w,),
                        Text('${percent.toStringAsFixed(2)} %', style: isUp ? AppStyles.quicksandW500Green(14.sp) : AppStyles.quicksandW500Red(14.sp),)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

