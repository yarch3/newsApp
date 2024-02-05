import 'package:flutter/material.dart';
import 'package:news/services/api_service.dart';
import 'package:news/model/article_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Газета 'Жизнь'"),
        backgroundColor: Colors.pink[100],
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //checking for a API response
            if(snapshot.hasData)
            {
              List<Article>? articles = snapshot.data as List<Article>;
              for(int i = 0; i < articles!.length; i++){
                if((articles![i].description == '' || articles![i].description == "[Removed]")){
                  articles.remove(articles![i]);
                }

              }
              return ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (context, index) =>
                    NewsTile(
                        description: articles![index].description,
                        author: articles![index].author,
                        imageUrl: articles![index].urlToImage,
                        pageURL: articles![index].url

                    ),
              );
            }

          return Center(
            child: CircularProgressIndicator(),
          );


        },
      )
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, description, author, pageURL;
  NewsTile({
  required this.imageUrl,
  required this.description,
  required this.author,
  required this.pageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),

      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
              width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),

          ),
        child: Column(


          children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                  child: Image.network(imageUrl)
              ),
            SizedBox(height: 5),
            Align(

              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 20),
                  child: Text((author != '' ? author : 'Unknown author'),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                decoration: BoxDecoration(
                 color: Colors.pink,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),

                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 350,
                child: Text(description)
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent
                ),
                 onPressed: () { _launchURL(pageURL); },
                  child: Text("Click for more", style: TextStyle(color: Colors.white),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// _launchURL(String notParsedUrl) async {
//   final Uri url = Uri.parse(notParsedUrl);
//   if (!await launchUrl(url)) {
//     throw Exception('Could not launch $notParsedUrl');
//   }

  Future<bool> _launchURL(notParsedUrl) async {
    final Uri url = Uri.parse(notParsedUrl);
    try {
      await launchUrl(url);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
    }

  //   }
//   else {
//     throw Exception('Could not launch $notParsedUrl');
//   }
