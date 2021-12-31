
import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/app_cubit/cubit.dart';
import 'package:news_app/shared/app_cubit/states.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';


void main() async{
 await BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      DioHelper.init();
      await CacheHelper.init();
      bool isDark = CacheHelper.getBoolean(key: 'isDark')??false;

      runApp(MyApp(isDark));
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark ,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context )=>NewsCubit()..getBusiness()),
        BlocProvider(create: (context)=>AppCubit(isDark)),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder:(context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.grey,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
            darkTheme: ThemeData(
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.grey,
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme:  AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black45,
                  statusBarIconBrightness: Brightness.light,
                ),

              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,

                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:  const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            home: Directionality(
                textDirection: TextDirection.ltr,
                child: AnimatedSplashScreen(
                  splash: 'assets/images/news1.png',
                  splashIconSize: 300,
                  backgroundColor:isDark? HexColor('333739'):Colors.white,
                  duration: 1500,
                  splashTransition: SplashTransition.slideTransition,

                  nextScreen: const NewsLayout(),

                )),
          );
        } ,

      ),
    );
  }
}
