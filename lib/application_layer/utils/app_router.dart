import 'package:go_router/go_router.dart';
import 'package:ny_articles_rp/data_layer/models/article_model.dart';
import 'package:ny_articles_rp/presentation_layer/home/home_view.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/articles/article_detail.dart';

abstract class Routes {
  static const String articleDetail = 'article_detail';
  static const String homeView = 'home';
}

// GoRouter configuration
final app_router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.homeView, // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: Routes.articleDetail,
      path: '/${Routes.articleDetail}',
      builder: (context, state) {
        final id = state.extra as Article;
        return ArticleDetail(article: id);
      },
    ),
  ],
);
