import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ny_articles_rp/data_layer/configs/api_end_points.dart';
import 'package:ny_articles_rp/data_layer/models/article_model.dart';

class ArticleService {
  ArticleService._();
  static final instance = ArticleService._();

  Future<ArticleModel> getArticles({required String period}) async {
    final response = await Dio().get(
      getArticleUrl(section: APIEndPoints.allSection, period: period),
    );
    debugPrint(response.data.toString());
    return ArticleModel.fromJson(response.data);
  }

  // Generate Article API Url
  getArticleUrl({required String section, required String period}) {
    return '${APIEndPoints.baseUrl}${APIEndPoints.most_viewed}$section/$period.json?api-key=${APIEndPoints.key}';
  }
}
