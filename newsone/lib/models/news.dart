import 'package:newsone/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News{
  List<Article> newsList = [];

  Future<void> getNews() async{
    String url = 
    'http://newsapi.org/v2/top-headlines?country=us&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=25afaecc9c384f6f8e76281420220295';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);


    if(jsonData['status']=='ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!=null && element['description']!=null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            published: DateTime.parse(element['publishedAt']),
            imageUrl: element['urlToImage'],
            articleUrl: element['url'],
            content: element['content'],
            description: element['description'],
          );
          newsList.add(article);
        }
      });
    }
    
  }
}


class CategoryNews{
  List<Article> newsList = [];

  Future<void> getCategoryNews(String category) async{
    String url = 'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=25afaecc9c384f6f8e76281420220295';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);


    if(jsonData['status']=='ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!=null && element['description']!=null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            published: DateTime.parse(element['publishedAt']),
            imageUrl: element['urlToImage'],
            articleUrl: element['url'],
            content: element['content'],
            description: element['description'],
          );
          newsList.add(article);
        }
      });
    }
    
  }
}