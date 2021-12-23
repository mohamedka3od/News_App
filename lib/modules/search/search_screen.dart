import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/app_cubit/cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  bool isSearch = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        List list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            actions: [  IconButton(
              icon:const Icon(Icons.brightness_4_outlined),
              onPressed: (){
                AppCubit.get(context).changeAppMode();
              },
            ),],

          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,

                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),

                  ),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Search must not be empty";
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                    if(value.isEmpty){
                      isSearch = true;
                    }
                    else{
                      isSearch = false;
                    }
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: isSearch),),

            ],
          ),
        );
      },
    );
  }
}
