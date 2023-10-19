import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/NewsResponce.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/SourceResponce.dart';

class AboutNews extends StatelessWidget{

  static const String routeName = 'aboutNews';
  @override
  Widget build(BuildContext context) {
    var argus = ModalRoute.of(context)?.settings.arguments as argsList;

    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight:Radius.circular(25) )),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.cover,),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
               // margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.antiAlias,

                  child: Image.network(argus.argsToNews.urlToImage??"")),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(argus.argsToNews.source?.name??"",),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(argus.argsToNews.title??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(argus.argsToNews.publishedAt??"",textAlign: TextAlign.right),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(argus.argsToNews.content??""),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: ()async{
                  //launchUrl((argus.argsToNews.url.toString()??""));
                  //launchURLBrowser(argus.argsToNews.url.toString());
                  //final url = argus.argsToNews.url;
                  launchUrlStart(url: argus.argsToNews.url.toString());

                },
                child: Text("View Full Article ➤",textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize:15),),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),
       // mode: LaunchMode.externalApplication
    )) {
      throw 'Could not launch $url';
    }
  }
  // de noooo
  void launchURLBrowser(String link) async {
   // await LaunchApp.openApp(
     // androidPackageName: link,
     // openStore: true
    //);
    await LaunchApp.isAppInstalled(
        androidPackageName: 'net.pulsesecure.pulsesecure'
    );
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);

    }
    else {
      throw 'Could not launch $url';
    }
  }


}
class argsList{
  News argsToNews;

  argsList({required this.argsToNews});
}
