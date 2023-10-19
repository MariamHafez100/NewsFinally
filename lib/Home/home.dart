import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/details_news.dart';
import 'package:news/Home/searchPage.dart';
import 'package:news/api_fold/api.dart';
import 'package:news/fragmentCategory.dart';
import 'package:news/model/NewsResponce.dart';
import 'package:news/model/mainCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/SourceResponce.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Source> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shadowColor: Colors.green,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "MENU 📰",
            ),
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.category),
                      SizedBox(
                        width: 8,
                      ),
                      Text("CATEGORY",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "SETTINGS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('NEWS'),
        actions: [

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                child: Icon(Icons.search_rounded, size: 35)),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
      ),
      body: selectedCategory == null
          ? CategoryFragment(onCategoryTap: onCategoryTap)
          : CategoryDetails(category: selectedCategory!),
    );
  }

  MainCategory? selectedCategory;

  onCategoryTap(MainCategory newcategory) {
    selectedCategory = newcategory;
    setState(() {});
  }
}


class CustomSearchDelegate extends SearchDelegate {
  static const String apiKey =
  //d90473657a5447a189d88f8696a0b54f

      '193c64fab7f24774bf819c38baf3a34a'; // Replace with your News API key

  Future<List<Source>> searchList() async {
    final response = await http
        .get(Uri.parse('https://newsapi.org/v2/sources?apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Source> sources = [];
      for (var item in data['sources']) {
        sources.add(Source.fromJson(item));
      }
      return sources;
    } else {
      throw Exception('Failed to fetch sources');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Source> source = [];
    return FutureBuilder<List<Source>>(
      future: searchList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final sources = snapshot.data!;
        final filteredSources = sources
            .where((source) =>
                source.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: filteredSources.length,
          itemBuilder: (context, index) {
            final source = filteredSources[index];
            return ListTile(
              title: Text(source.name ?? ""),
              subtitle: Text(source.description ?? ""),
              onTap: () {
                // Do something with the selected source
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: searchList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final sources = snapshot.data!;
        final filteredSources = sources
            .where((source) =>
                source.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: filteredSources.length,
          itemBuilder: (context, index) {
            final source = filteredSources[index];
            return ListTile(
              title: Text(source.name ?? ""),
              subtitle: Text(source.description ?? ""),
              onTap: () {
                // Do something with the selected source
              },
            );
          },
        );
      },
    );
  }
}

class MyCustomSearchDelegate extends SearchDelegate {
   // Replace with your News API key
  late Source source;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<NewsResponce?>(
      future: apiManager.getSourceSearch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        var newsList =snapshot.data?.articles?? []
        //final sources = snapshot.data!;
        //source = snapshot.data!;
        //final filteredSources = source
            .where((newsList) =>
                newsList.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();


        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final source = newsList[index];
            return ListTile(
              title: Text(source.name ?? "noo"),
              subtitle: Text(source.description ?? "noo"),
              onTap: () {
                // Do something with the selected source
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<NewsResponce?>(
      future: apiManager.getSourceSearch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        //final sources = snapshot.data!;
        //source = snapshot.data! ;
        //final filteredSources = source
        var newsList =snapshot.data?.articles ?? []
            .where((newsList) =>
                newsList.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final source = newsList[index];
            return ListTile(
              title: Text(source.name ?? ""),
              subtitle: Text(source.description ?? ""),
              onTap: () {
                // Do something with the selected source
              },
            );
          },
        );
      },
    );
  }
}
