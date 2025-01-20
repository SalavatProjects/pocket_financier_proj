import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_financier_proj/bloc/moneys_cubit.dart';
import 'package:pocket_financier_proj/pages/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_financier_proj/storages/isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppIsarDatabase.init();
  runApp(
      BlocProvider(
    create: (context) => MoneysCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<MoneysCubit>().getMoneys();
    return ScreenUtilInit(
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}

