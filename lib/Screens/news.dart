import 'package:corona_app/Widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  // ignore: non_constant_identifier_names
  var news_list = [];

  @override
  void initState() {
    refreshNews();
    super.initState();
  }

  Future refreshNews() async {
    Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=da03fb7c73f7454382ab244e6381174b&q=covid');
    final response = await http.get(url);
    var data = json.decode(response.body);
    this.news_list = [];

    // Setting state
    setState(
      () {
        for (var i = 0; i < data['totalResults']; i++) {
          this.news_list.add(data['articles'][i]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 Related News',
          style: TextStyle(
            fontFamily: 'MPLUSRounded',
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 10.0,
        shadowColor: Colors.grey[300],
      ),
      body: RefreshIndicator(
        onRefresh: refreshNews,
        color: Colors.blue[900],
        child: ListView.builder(
          itemCount: news_list.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  NewsCard(news_list: news_list[index]),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
