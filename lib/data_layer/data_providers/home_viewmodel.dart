import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_articles_rp/application_layer/services/article_service.dart';

final periodIdProvider = Provider<String>((_) => '1');

final articleProvider = FutureProvider.autoDispose((ref) {
  final quoteService = ArticleService.instance;
  return quoteService.getArticles(period: ref.watch(periodIdProvider));
});
