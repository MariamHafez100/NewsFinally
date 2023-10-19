
import 'package:flutter/material.dart';

class MainCategory{
  String id;
  String title;
  String imageLink;
  Color background;

  MainCategory({required this.id,required this.title,required this.imageLink,required this.background});
//business entertainment general health science sports technology
  static List<MainCategory> getCategory(){
    return [
      MainCategory(id: 'sports', title: 'Sports', imageLink: 'assets/images/ball.png', background: Colors.red),
      MainCategory(id: 'general', title: 'General', imageLink:'assets/images/ball.png', background: Colors.red),
      MainCategory(id: 'health', title: 'Health', imageLink: 'assets/images/heal.png', background: Colors.pink),
      MainCategory(id: 'business', title: 'Business', imageLink:'assets/images/buss.png', background: Colors.brown),
      MainCategory(id: 'entertainment', title: 'Entertainment', imageLink:'assets/images/ball.png', background: Colors.lightBlue),
      MainCategory(id: 'science', title: 'Science', imageLink: 'assets/images/sci.png', background: Colors.yellow),
      MainCategory(id: 'technology', title: 'Technology', imageLink: 'assets/images/ball.png', background: Colors.black12),
      //MainCategory(id: '', title: '', imageLink: '', background: Colors.transparent),


    ];
  }
}
class MyMainCategory{
  String id;


  MyMainCategory({required this.id});
//business entertainment general health science sports technology
  static List<MyMainCategory> getCategory(){
    return [
      MyMainCategory(id: 'sports',),
      MyMainCategory(id: 'general',),
      MyMainCategory(id: 'technology',),
      MyMainCategory(id: 'health', ),
      MyMainCategory(id: 'entertainment', ),
      MyMainCategory(id: 'science',),
      MyMainCategory(id: 'business',),


    ];
  }
}