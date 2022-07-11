import 'dart:convert';
import 'package:flutter/foundation.dart';

class NewsModel {
  String publishedBy;
  String publishedDate;
  String content;
  NewsModel({
    required this.publishedBy,
    required this.publishedDate,
    required this.content,
  });

  NewsModel copyWith({
    String? publishedBy,
    String? publishedDate,
    String? content,
  }) {
    return NewsModel(
      publishedBy: publishedBy ?? this.publishedBy,
      publishedDate: publishedDate ?? this.publishedDate,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publishedBy': publishedBy,
      'publishedDate': publishedDate,
      'content': content,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      publishedBy: map['publishedBy'] as String,
      publishedDate: map['publishedDate'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NewsModel(publishedBy: $publishedBy, publishedDate: $publishedDate, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.publishedBy == publishedBy &&
        other.publishedDate == publishedDate &&
        other.content == content;
  }

  @override
  int get hashCode => publishedBy.hashCode ^ publishedDate.hashCode ^ content.hashCode;
}

class PublishedNews {
  List<NewsModel> news;
  PublishedNews({
    required this.news,
  });

  PublishedNews copyWith({
    List<NewsModel>? news,
  }) {
    return PublishedNews(
      news: news ?? this.news,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'news': news.map((x) => x.toMap()).toList(),
    };
  }

  factory PublishedNews.fromMap(Map<String, dynamic> map) {
    return PublishedNews(
      news: List<NewsModel>.from(
        (map['news'] as List<dynamic>).map<NewsModel>(
          (x) => NewsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PublishedNews.fromJson(String source) => PublishedNews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PublishedNews(news: $news)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublishedNews && listEquals(other.news, news);
  }

  @override
  int get hashCode => news.hashCode;
}
