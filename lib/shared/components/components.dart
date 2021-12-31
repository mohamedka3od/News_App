import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article,context)=>InkWell(
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        SizedBox(
          width: 120.0,
          height: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image :NetworkImage(
                  '${article['urlToImage']}',
              ) ,
              placeholder: const AssetImage('assets/images/news1.png'),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, object, stackTrack){
                return Image.asset(
                  'assets/images/news1.png',
                  fit: BoxFit.cover,
                );
              },

            ),
          ),
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize:MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )

              ],
            ),
          ),
        ),
      ],
    ),
  ),
  onTap: (){
    navigateTo(context,WebVewScreen(article['url']));
  },
);
Widget myDivider( ) => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder (list ,context,{isSearch = false})=>ConditionalBuilder(
  condition:  list.isNotEmpty,
  builder: (context)=>ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context ,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context ,index)=>myDivider(),
      itemCount: 10,

  ),
  fallback:(context)=>isSearch? Container(): const Center(child: CircularProgressIndicator()),
);

void navigateTo(context ,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context)=>widget ,)
);