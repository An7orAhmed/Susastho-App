import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:susastho/constants.dart';
import 'package:susastho/model/news_model.dart';
import 'package:susastho/widgets/utilities.dart';

class PublishNews extends StatelessWidget {
  PublishNews({Key? key}) : super(key: key);

  final _controller = QuillController.basic();
  final heading = TextEditingController();

  Future<void> _publishNews(context) async {
    String post = jsonEncode(_controller.document.toDelta().toJson());
    if (_controller.document.isEmpty() || heading.text.isEmpty) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'There is no content!'));
      return;
    }
    var newPublish = NewsModel(
        headline: heading.text,
        publishedBy: auth.currentUser?.email ?? "Admin",
        publishedDate: DateTime.now().toString().split('.')[0],
        content: post);
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
        actions: [IconButton(onPressed: () => _publishNews(context), icon: const Icon(Icons.upload))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            QuillToolbar.basic(controller: _controller, toolbarIconAlignment: WrapAlignment.spaceBetween),
            const SizedBox(height: 10),
            TextField(
              controller: heading,
              decoration: const InputDecoration(
                  hintText: "Enter news headline", labelText: "News headline", border: OutlineInputBorder()),
            ),
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
          ],
        ),
      ),
    );
  }
}
