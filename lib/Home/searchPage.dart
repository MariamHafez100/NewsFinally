import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/SourceResponce.dart';

class SearchPage extends StatefulWidget{
  static const String routeName = 'search';

  final List <Source> list;
SearchPage({required this.list});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Source> searchList = [];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: TextField(style: TextStyle(color: Colors.black),
       decoration: InputDecoration(
         hintText: 'search :)',

       ),
         onChanged: (val) {
           if (val.isEmpty) {
             print('empty ');
             searchList = [];
           }else{
           setState(() {
             searchList = widget.list.where((element) => element.name!.contains(val)).toList();
           });}
         },
       ),
     ),
     body: ListView.builder(
       itemCount: searchList.length,
       itemBuilder: (context, index) {

         return ListTile(
           title: Text(searchList[index].name??"it wooork"),
           // Add any other relevant information from the Source class
         );
       },
     ),

   );
  }
}