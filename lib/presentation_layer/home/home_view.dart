import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ny_articles_rp/data_layer/configs/strings.dart';
import 'package:ny_articles_rp/data_layer/data_providers/home_viewmodel.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/articles/article_list_view.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/templates/error.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/templates/loading.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/templates/page_template.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using Page Template to reduce the code
    final articles = ref.watch(articleProvider);
    return PageTemplate(
      pageTitle: AppStrings.appName,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(articleProvider),
        child: articles.when(
            skipLoadingOnRefresh: false,
            data: (data) {
              return ArticleListView(articles: data);
            },
            error: (_, __) => const ErrorScreen(),
            loading: () => const Loading()),
      ),
    );
  }
}
