import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/news_model.dart';
import 'package:susastho/screen/patient/article.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  Future<void> fatchNews() async {
    var docs = await db.collection("Data").doc("News").get();
    var data = PublishedNews.fromMap(docs.data()!);
    publishedNews.clear();
    for (var news in data.news) {
      publishedNews.add(news);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder(
            future: fatchNews(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: publishedNews.length,
                    itemBuilder: ((context, index) {
                      if (publishedNews.isEmpty) {
                        return const Center(child: Text("No news published!"));
                      } else {
                        return Card(
                          child: ListTile(
                            title: Text(publishedNews[index].headline),
                            subtitle: Text(publishedNews[index].publishedDate),
                            trailing: IconButton(
                                onPressed: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Article(news: publishedNews[index]))),
                                icon: const Icon(Icons.chevron_right)),
                          ),
                        );
                      }
                    }));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
      ),
    );
  }
}
