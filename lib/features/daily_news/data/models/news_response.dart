import 'package:news_app/features/daily_news/data/models/article.dart';

class NewsResponse {
  final List<ArticleModel> articles;

  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      articles: (json['articles'] as List)
          .map((i) => ArticleModel.fromJson(i))
          .toList(),
    );
  }
}