import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/home.dart';
import 'package:medica_zone_app/modules/login/cubit/login_cubit.dart';
import 'package:medica_zone_app/modules/regester/cubit/register_cubit.dart';
import 'package:medica_zone_app/modules/splash/splash_screen.dart';
import 'package:medica_zone_app/shared/components/constants.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/cubit/app_states.dart';
import 'package:medica_zone_app/shared/network/local/cache_helper.dart';
import 'package:medica_zone_app/shared/network/remote/dio_helper.dart';
import 'package:medica_zone_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey =
  // 'pk_test_51L7NLXHjmyadU3ZuKjuHJHDfj37tZTTwfG14BCmuC3EcJErcp7eVbo33omnjpF3onclMvnUBUz7xXP81UCTydXKo00fT53Bykd';
  // await Stripe.instance.applySettings();
  DioHelper.int();
  await CacheHelper.int();
  Widget widget;
  bool? isDark = CacheHelper.getBooleanData(key: "isDark");
  bool? onBoarding = CacheHelper.getData(key: onBoardingKeyValue);
  token = CacheHelper.getData(key: tokenKeyValue);
  // print("Your token is: ${token} \n\n");
  if (onBoarding != null)
    widget = Home();
  else
    widget = SplashScreen();

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startScreen: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startScreen;

  MyApp({this.isDark, this.startScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
            AppCubit()..changeMode(fromShared: isDark)),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getDealsData()
              ..getHomeData()
              ..getSliderImages()
              ..getCategoriesData()
              ..getUserData()..getFavData()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: startScreen,
          );
        },
      ),
    );
  }
}
