
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(this.isDark) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark;
  void changeAppMode(){
    isDark =! isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
     emit(AppChangeModeState());
    });

  }
}