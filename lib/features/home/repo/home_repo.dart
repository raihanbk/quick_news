import 'dart:convert';

import '../../../model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsHomeRepo {
  static Future<List<Article>?> fetchNews() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=f586bd240072446595af5a04c8244cfd');

    List<Article> news = [];

    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);

      // Access the 'articles' field from the JSON object
      List result = json['articles'];

      if (response.statusCode == 200) {
        for (int i = 0; i < result.length; i++) {
          Article article = Article.fromJson(result[i]);
          news.add(article);
        }
        return news;
      }
    } catch (e) {
      return [];
    }
  }
}
