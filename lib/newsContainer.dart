import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/aboutNews.dart';
import 'package:news/Home/home.dart';
import 'package:news/api_fold/api.dart';
import 'package:news/model/NewsResponce.dart';
import 'package:news/model/SourceResponce.dart';

class NewsLine extends StatefulWidget{
  Source source ;
  NewsLine({required this.source});

  @override
  State<NewsLine> createState() => _NewsLineState();
}

class _NewsLineState extends State<NewsLine> {
  List<News> news =[];
  final scrollController = ScrollController();
@override
  void initState() {

    // TODO: implement initState
    super.initState();
    scrollController.addListener(endList);

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponce?>(
        future: apiManager.getSourceById(widget.source.id??""),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.black,));
          }
          else if(snapshot.hasError){
            return Column(
              children: [
                Center(child: Icon(Icons.error,color: Colors.red,)),
                Center(child: Text("Oops thomething went wrong!")),
              ],
            );
          }
          if(snapshot.data!.status! != 'ok'){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(Icons.error,color: Colors.red,)),
                Center(child: Text(snapshot.data?.message??"Wrong")),
              ],
            );
          }

          if(news.isEmpty ){
             news =snapshot.data?.articles ?? [];}

           //news = newsList;


          //var response = NewsResponce.fromJson(newsList);
          return ListView.builder(
            controller: scrollController ,

            itemBuilder: (context, index)
            {
              //final news = widget.news[index];
            return GestureDetector(
              onTap: ()async{
                // w2ft henaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
               await Navigator.pushNamed(context, AboutNews.routeName,
                   arguments: argsList(argsToNews: news[index]));
               // 3yzen hena nb3t el newsList index l hnak w nzwd el content henaaaaaaaaaaa
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl:news[index].urlToImage??"" ,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Stack(children: [Image.asset('assets/images/news.jpg'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('No Available Image from ${news[index].source?.name??""}',
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                                )]),
                        ),//Image.network(newsList[index].urlToImage??"",)),
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(news[index].author??"",),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(news[index].title??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(news[index].publishedAt??"",textAlign: TextAlign.right),
                  ),
                ],
              ),
            );
          },
          itemCount: news.length,
          );
        }, );
  }
   int pagesize=1;
 endList()async{
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
       pagesize ++ ;
       print(pagesize);
      var newsResponceList = await apiManager.getSourceById(widget.source.id??"",page:pagesize);
      print('d5lt');
      print(newsResponceList?.articles?.first.title);
       print(news.length);
       print(newsResponceList?.articles?.length);
       news.addAll(newsResponceList?.articles??[]);
      setState(() {
      });
    }
}
}