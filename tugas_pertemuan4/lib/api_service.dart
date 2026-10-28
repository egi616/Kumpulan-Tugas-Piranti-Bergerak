import 'dart:convert';
import 'article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Article>> fetchArticles() async { //async untuk 
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=03c27af7ad3b4368b212dbc47927b281'));
    if(response.statusCode != 200){
      throw Exception('Gagal mengambil berita: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final articles = data['articles'] as List;

    return articles.map((item) => Article.fromJson(item as Map<String, dynamic>)).toList();
  }
}