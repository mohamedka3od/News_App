import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/app_cubit/cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);

        return DefaultTabController(
          length: cubit.bottomItems.length,
          child: Builder(builder: (context){
            final TabController tabController = DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                cubit.changeBottomNavBar(tabController.index);
              }
            });
            return Scaffold(
              body: NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                floatHeaderSlivers: true,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(

                      pinned: true, //to prevent TabBar from going off the screen
                      floating: true, //to prevent TabBar from going off the screen
                      title: const Text(
                          'News App'
                      ),
                      elevation: 10.0,
                      actions: [
                        IconButton(
                          icon:const Icon(Icons.search),
                          onPressed: (){
                            navigateTo(context , SearchScreen());
                          },
                        ),
                        IconButton(
                          icon:const Icon(Icons.brightness_4_outlined),
                          onPressed: (){
                            AppCubit.get(context).changeAppMode();
                          },
                        ),
                      ],
                      bottom:  TabBar(
                        tabs: cubit.bottomItems,
                      ),
                    ),
                  ];

                },
                body:TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: cubit.screens,

                ),

              ),
            );
          },),




        );

      },

    );
  }
}
