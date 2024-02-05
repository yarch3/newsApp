//HTTP request service
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/model/article_model.dart';
import 'package:news/model/source_model.dart';

const String API_KEY = "ffb469893e05455da2d26a856f55ff10";
const requestRes = '''
{
"status": "ok",
"totalResults": 34,
"articles": [
{
"source": {
"id": null,
"name": "WZTV"
},
"author": "WZTV",
"title": "Country star Darius Rucker arrested on drug charges in Williamson County - WZTV",
"description": "Country star Darius Rucker was arrested on multiple drug charges in Williamson County, the sheriff's office says.",
"url": "https://fox17.com/news/local/country-star-darius-rucker-arrested-on-drug-charges-in-williamson-county",
"urlToImage": "https://fox17.com/resources/media/f47ffa6d-ce9a-4b75-97c7-ed6571e4c476-large16x9_DARIUSCARLOSRUCKER.jpg",
"publishedAt": "2024-02-02T03:43:57Z",
"content": "WILLIAMSON COUNTY, Tenn. (WZTV) Country star Darius Rucker was arrested on misdemeanor drug charges in Williamson County, the sheriff's office says.\\r\\n According to the sheriff's office spokesperson, R… [+372 chars]"
}]

}
''';
//    -картинка для null urlImage


class ApiService {
  final endPoint = "http://newsapi.org/v2/top-headlines?country=us&sortBy=publishedAt&apiKey=ffb469893e05455da2d26a856f55ff10";
  final client = http.Client();



    Future<List<Article>> getArticle() async {
      try {
        final uri = Uri.parse(endPoint);
        final response = await client.get(uri);
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = List<dynamic>.from(json['articles']);
        List<Article> articles = body.map((dynamic item) =>
            Article.fromJson(item)).toList();//error
        return articles;
      } catch (e) {
        print("Произошла ошибка при выполнении запроса: $e");
        throw e; // Пробросим ошибку наверх для обработки в FutureBuilder
      }
    }



  Future<List<Article>> getArticleOffline() async {

    Article article = Article(source: Source(id: 'bebe', name: "Pravda"),
        author: "Vasiliy Terkin", title: "Стихотворение",
        description: "оТлсвысовыдлосдвыосо",
        url: "https://news.google.com/rss/articles/CBMiYWh0dHBzOi8vZm9ya2xvZy5jb20vbmV3cy9vdGtyeXR5ai1pbnRlcmVzLXBvLWJpdGtvaW4tZnl1Y2hlcnNhbS1uYS1jbWUtZG9zdGlnLXJla29yZG55aC16bmFjaGVuaWrSAWVodHRwczovL2Zvcmtsb2cuY29tL25ld3Mvb3Rrcnl0eWotaW50ZXJlcy1wby1iaXRrb2luLWZ5dWNoZXJzYW0tbmEtY21lLWRvc3RpZy1yZWtvcmRueWgtem5hY2hlbmlqL2FtcA?oc=5",
        urlToImage: "j",
        publishedAt: "27.01.2024",
        );
     List<Article> listik = [article];
     return listik;
  }
}