import 'package:flutter/material.dart';
import 'package:ny_articles_rp/data_layer/configs/sizes.dart';

// Row appbar with multiple widgets in the APPBAR
class RowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RowAppBar({Key? key, this.tabHeight, this.title}) : super(key: key);
  final Size? tabHeight;
  final String? title;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: tabHeight ?? preferredSize,
      child: AppBar(
        title: Text(title ?? 'Flutter App', style: const TextStyle(fontSize: AppSizes.small_4)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
