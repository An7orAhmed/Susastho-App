import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:susastho/constants.dart';
import 'package:susastho/model/news_model.dart';
import 'package:susastho/widgets/utilities.dart';

class PublishNews extends StatelessWidget {
  PublishNews({Key? key}) : super(key: key);

  final _controller = QuillController.basic();

  Future<void> _publishNews(context) async {
    String post = _controller.document.toDelta().toJson().toString();
    if (_controller.document.isEmpty()) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'There is no content!'));
      return;
    }
    var newPublish = NewsModel(
        publishedBy: auth.currentUser?.email ?? "Admin", publishedDate: DateTime.now().toString(), content: post);
    publishedNews.add(newPublish);
    var doc = await db.collection("Data").doc("News").get();
    if (doc.data() != null) {
      await db.collection("Data").doc("News").update(PublishedNews(news: publishedNews).toMap());
    } else {
      await db.collection("Data").doc("News").set(PublishedNews(news: publishedNews).toMap());
    }
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'published successfully.'));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Publish News"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            QuillToolbar.basic(controller: _controller, toolbarIconAlignment: WrapAlignment.spaceBetween),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () => _publishNews(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text("Publish"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
