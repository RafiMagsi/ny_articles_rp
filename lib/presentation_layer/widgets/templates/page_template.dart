import 'package:flutter/material.dart';
import 'package:ny_articles_rp/data_layer/configs/sizes.dart';
import 'package:ny_articles_rp/presentation_layer/widgets/row_app_bar.dart';

// Generic page template
class PageTemplate extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final String? pageTitle;
  final bool? rootPage;

  const PageTemplate({Key? key, this.body, this.header, this.footer, this.pageTitle = "", this.rootPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RowAppBar(title: pageTitle),
      body: Stack(
        children: [
          Column(
            children: [header ?? Container(), Expanded(child: body!)],
          ),
          Positioned(
            bottom: AppSizes.large_3,
            left: 0,
            right: 0,
            child: footer ?? Container(),
          )
        ],
      ),
    );
  }
}
