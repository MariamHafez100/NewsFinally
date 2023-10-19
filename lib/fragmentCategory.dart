import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Details/categoryItemsDetails.dart';
import 'package:news/model/mainCategory.dart';

class CategoryFragment extends StatelessWidget{
  var categories = MainCategory.getCategory();
  Function onCategoryTap;
  CategoryFragment({required this.onCategoryTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.cover,),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text('''Pick Your Category 
 Of Interests''',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                fontStyle: FontStyle.italic )),
          ),
          Expanded(
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2 ,
              mainAxisSpacing:18 ,
              crossAxisSpacing: 12,
            ), itemBuilder: (context , index){
              return InkWell(
                onTap:() => onCategoryTap(categories[index]),
                  child: categoryItemDetails(mainCategory: categories[index], index: index));
            },
            itemCount: categories.length,
            ),
          )

        ],
      ),
    );
  }

}