import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:susastho/model/news_model.dart';

class Article extends StatelessWidget {
  NewsModel news;
  late QuillController controller;
  Article({Key? key, required this.news}) : super(key: key) {
    var myJSON = jsonDecode(news.content);
    controller =
        QuillController(document: Document.fromJson(myJSON), selection: const TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(news.headline),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: QuillEditor(
          controller: controller,
          readOnly: true,
          showCursor: false,
          autoFocus: true,
          expands: false,
          focusNode: FocusNode(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          scrollable: true,
          scrollController: ScrollController(),
        ),
      ),
    );
  }
}
