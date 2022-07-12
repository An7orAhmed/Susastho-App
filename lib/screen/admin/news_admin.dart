import 'package:flutter/material.dart';
import 'package:susastho/constants.dart';
import 'package:susastho/model/news_model.dart';
import 'package:susastho/widgets/utilities.dart';

class NewsAdmin extends StatefulWidget {
  const NewsAdmin({Key? key}) : super(key: key);

  @override
  State<NewsAdmin> createState() => _NewsAdminState();
}

class _NewsAdminState extends State<NewsAdmin> {
  Future<void> fatchNews() async {
    var docs = await db.collection("Data").doc("News").get();
    var data = PublishedNews.fromMap(docs.data()!);
    publishedNews.clear();
    for (var news in data.news) {
      publishedNews.add(news);
    }
  }

  Future<void> deleteNews(int id) async {
    publishedNews.removeAt(id);
    await db.collection("Data").doc("News").update(PublishedNews(news: publishedNews).toMap());
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'Removed successfully.'));
    setState(() {});
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
                if (publishedNews.isEmpty) {
                  return const Center(child: Text("No news published!"));
                } else {
                  return ListView.builder(
                    itemCount: publishedNews.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(publishedNews[index].headline),
                          subtitle: Text(publishedNews[index].publishedDate),
                          trailing: IconButton(
                            onPressed: () => deleteNews(index),
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                          ),
                        ),
                      );
                    }),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
      ),
    );
  }
}
