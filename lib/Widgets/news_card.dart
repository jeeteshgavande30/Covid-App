import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const NewsCard({Key? key, required this.news_list}) : super(key: key);
  // ignore: non_constant_identifier_names
  final Map news_list;
  @override
  Widget build(BuildContext context) {
    // Removing error for null image in api
    late Image img;
    if (news_list['urlToImage'] != null) {
      img = Image.network(
        news_list['urlToImage'],
        fit: BoxFit.cover,
        height: 200,
        width: MediaQuery.of(context).size.width,
      );
    } else {
      img = Image.asset(
        'assets/images/news-image.jpg',
        fit: BoxFit.cover,
        height: 200,
        width: MediaQuery.of(context).size.width,
      );
    }
    return GestureDetector(
      onTap: () async {
        String url = news_list['url'];
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch - $url';
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        color: Colors.grey[50],
        elevation: 4.0,
        shadowColor: Colors.black45.withBlue(150).withOpacity(0.75),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: img,
              ),
              Text(
                '${news_list['title']}',
                // maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
