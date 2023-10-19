import 'package:flutter/material.dart';
import 'package:news/Home/aboutNews.dart';
import 'package:news/Home/home.dart';
import 'package:news/Home/details_news.dart';
import 'package:news/Home/searchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        //SearchPage.routeName : (context) => SearchPage(list: [],),

        //CategoryDetails.routeName : (context) => CategoryDetails(category: null,),
        AboutNews.routeName : (context) => AboutNews(),


      },
      debugShowCheckedModeBanner: false,
    );
  }
}

