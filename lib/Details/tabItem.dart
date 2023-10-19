import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../model/SourceResponce.dart';

class TabShape extends StatelessWidget{
  bool isSelected;
  Source sources;
  TabShape({required this.sources,required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),

      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: isSelected? Colors.transparent : Colors.green, width: 5 )
          //borderRadius: BorderRadius.circular(50),
         // border: Border.all(width: 5,color: Colors.green),
        //color: isSelected? Colors.green : Colors.transparent,
          ),
      child: Text(sources.name??"",
        style: TextStyle(fontSize: 18,
            color: isSelected? Colors.white : Colors.green,
            fontWeight: FontWeight.bold),),
    );
  }

}