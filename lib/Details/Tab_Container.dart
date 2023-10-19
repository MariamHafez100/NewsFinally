import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Details/tabItem.dart';
import 'package:news/model/SourceResponce.dart';
import 'package:news/newsContainer.dart';

class Tabs extends StatefulWidget{
  List<Source> sourceListTap;
  Tabs({required this.sourceListTap});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceListTap.length,
      child: Column(
        children: [
          //SizedBox.square(dimension: 20,),
          Container(
            margin: EdgeInsets.only(top: 10,left: 5),
            child: TabBar(
                unselectedLabelColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green, Colors.black]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
              onTap: (index){
                selectedIndex = index;
                setState(() {
                });
              },
              isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: widget.sourceListTap.map((sources) =>
                    TabShape(
                        sources: sources,
                        isSelected: selectedIndex ==widget.sourceListTap.indexOf(sources) )).toList()
            ),

          ),
          Expanded(child: NewsLine(source: widget.sourceListTap[selectedIndex]))
        ],
      ),
    );
  }
}