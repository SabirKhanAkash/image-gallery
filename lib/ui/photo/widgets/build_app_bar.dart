import 'package:flutter/material.dart';
import 'package:image_gallery/utils/config/app_style.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    // toolbarHeight: 70,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(
      title,
      style: TextStyle(fontFamily: AppStyle().primaryFont),
    ),
  );
}
