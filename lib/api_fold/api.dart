import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api_fold/api_constants.dart';
import 'package:news/model/NewsResponce.dart';
import 'package:news/model/SourceResponce.dart';

class apiManager {
  static Future<SourceResponce?> getSources(String CategoryId,{var  Mysearch})async{
    Uri url = Uri.https(ApiConstants.serverName, ApiConstants.apiName,
        {'apiKey': '193c64fab7f24774bf819c38baf3a34a',
          'category' : CategoryId,
          'q' : Mysearch
        });
    try{
      var response = await http.get(url);
      var bodString = response.body;
      var json = jsonDecode(bodString);
      return SourceResponce.fromJson(json);
    }catch(e){
      throw e;
    }

  }

  static Future<NewsResponce?> getSourceById(String sourceId,{ int page = 1, int pageSize = 20})async{
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=d90473657a5447a189d88f8696a0b54f
    Uri url = Uri.https(ApiConstants.serverName,ApiConstants.newApiName,{
      'apiKey' : '193c64fab7f24774bf819c38baf3a34a',
      'sources' : sourceId,
      'pageSize' : pageSize.toString(),
      'page' : page.toString(),
    });
    try{
      var responce = await http.get(url);
      var bodyString = responce.body;
      var json = jsonDecode(bodyString);
      return NewsResponce.fromJson(json);
    }catch(e){
      throw e;
    }
  }
  static Future<NewsResponce?> getSourceSearch()async{
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=d90473657a5447a189d88f8696a0b54f
    Uri url = Uri.https(ApiConstants.serverName,ApiConstants.newApiName,{
      'apiKey' : 'd90473657a5447a189d88f8696a0b54f',
      //'sources' : sourceId
    });
    try{
      var responce = await http.get(url);
      var bodyString = responce.body;
      var json = jsonDecode(bodyString);
      return NewsResponce.fromJson(json);
    }catch(e){
      throw e;
    }
  }

}
