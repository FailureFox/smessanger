import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String author;
  final String title;
  final String descriptions;
  final String urlToNews;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsModel({
    required this.author,
    required this.title,
    required this.descriptions,
    required this.urlToNews,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromMap(Map<String, dynamic> news) {
    return NewsModel(
      author: news['author'] ?? news['source']['name'],
      title: news['title'],
      descriptions: news['description']??'',
      urlToNews: news['url'],
      urlToImage: news['urlToImage']??'',
      publishedAt: DateTime.parse(news['publishedAt'] as String),
      content: news['content'] ?? '',
    );
  }
}
