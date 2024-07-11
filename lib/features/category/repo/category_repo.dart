import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_news/model/news_model.dart';

class CategoryRepo {
  static Future<List<Article>> fetchCategory(String category) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=f586bd240072446595af5a04c8244cfd');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        final List<Article> articles = articlesJson.map((json) => Article.fromJson(json)).toList();
        return articles;
      } else {
        throw Exception('Failed to load category news');
      }
    } catch (e) {
      throw Exception('Failed to load category news: $e');
    }
  }
}
