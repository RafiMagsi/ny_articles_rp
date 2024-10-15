import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_articles_rp/data_layer/configs/sizes.dart';
import 'package:ny_articles_rp/data_layer/models/article_model.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/articles/article_list_item.dart';

// Article List view
class ArticleListView extends ConsumerWidget {
  final ArticleModel? articles;

  const ArticleListView({super.key, this.articles});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, AppSizes.small_2, 0, AppSizes.small_3),
      itemCount: articles?.results?.length ?? 0,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ArticleItem(
          article: (articles?.results![index])!,
        );
      },
    );
  }
}
