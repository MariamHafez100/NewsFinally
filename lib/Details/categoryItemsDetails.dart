import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/mainCategory.dart';

class categoryItemDetails extends StatelessWidget{
  MainCategory mainCategory;
  int index;

  categoryItemDetails({required this.mainCategory, required this.index });
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: double.infinity,
      decoration: BoxDecoration(
        color: mainCategory.background!,
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(25) ,
            topRight:Radius.circular(25),
            bottomRight:  index % 2==0? Radius.circular(0):Radius.circular(25),
            bottomLeft:  index % 2 ==0? Radius.circular(25):Radius.circular(0),
          )
      ),
      child: Column(
        children: [
          Image.asset(mainCategory.imageLink,height: MediaQuery.of(context).size.height*0.13,),
          //SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(mainCategory.title,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
          ),


        ],
      ),
    );
  }

}
