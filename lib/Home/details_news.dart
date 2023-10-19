import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Details/Tab_Container.dart';
import 'package:news/api_fold/api.dart';
import 'package:news/model/SourceResponce.dart';
import 'package:news/model/mainCategory.dart';

class CategoryDetails extends StatefulWidget {
  //static const String routeName = 'categorydetails';
  MainCategory category;
  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.cover,),),
        child: FutureBuilder<SourceResponce?>(
            future: apiManager.getSources(widget.category.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Colors.green,
                      backgroundColor: Colors.black,
                      strokeWidth: 9),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    )),
                    Center(child: Text("Oops thomething went wrong!")),
                    TextButton(onPressed: (){
                      apiManager.getSources(widget.category.id);
                      setState(() {
                      });
                    }, child: Text("TRY AGAIN"))
                  ],
                );
              }
              if (snapshot.data?.status != 'ok') {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    )),
                    Center(child: Text(snapshot.data?.message ?? "Wrong")),
                  ],
                );
              }
              var sourceList = snapshot.data?.sources ?? [];
              return Tabs(sourceListTap: sourceList);
            }),
      ),
    );
  }

}
//wsllllllllllllllllllt hena bs not okay at all

