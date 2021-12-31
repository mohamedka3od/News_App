
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomItems = const[
    Tab(
         icon: Icon(Icons.business),
         text: 'Business'
    ),
    Tab(
        icon: Icon(Icons.sports),
        text: 'Sports'
    ),
    Tab(
        icon: Icon(Icons.science),
        text: 'Science'
    ),
  ];
  List<Widget> screens =const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar (index){
    currentIndex = index;
    if(index ==1 && sports.isEmpty ){
      getSports();
    }
    else if(index == 2 && science.isEmpty ){
      getScience();
    }
    emit(NewsBottomNavState());
  }


  List business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'68c9789c60ee4116a0a96fd722a3065b',
      },
    ).then((value){

      business =value.data['articles'];
       print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List science=[];
  void getScience(){
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'68c9789c60ee4116a0a96fd722a3065b',
      },
    ).then((value){
      //  print(value.data['articles'][0]['title']);
      science =value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'68c9789c60ee4116a0a96fd722a3065b',
      },
    ).then((value){
      //  print(value.data['articles'][0]['title']);
      sports =value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'qInTitle':value,
          'apiKey':'68c9789c60ee4116a0a96fd722a3065b',
          'sortBy':'relevancy',
        }
        ).then((value) {
          search = value.data['articles'];
          emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });


  }




}