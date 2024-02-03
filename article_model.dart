//article model

import 'source_model.dart';

class Article{
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;


  Article(
    { required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt
    });

  factory Article.fromJson(Map<String, dynamic> json) {

    return Article(
      source: Source.fromJson(json['source']),
      author: (json['author'] != null) ? json['author'] as String : '',
      title: json['title'] as String,
      description: (json['description'] != null) ? json['description'] as String : '',
      url: json['url'] as String,
      urlToImage: (json['urlToImage'] != null) ? json['urlToImage'] as String : 'https://faac-group.ru/images/no-image.webp',
      publishedAt: json['publishedAt'] as String,
    );
  }
}
