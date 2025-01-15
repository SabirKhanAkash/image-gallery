import 'package:flutter/material.dart';
import 'package:image_gallery/ui/photo/widgets/build_app_bar.dart';
import 'package:image_gallery/ui/photo/widgets/build_body.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key, required this.title});

  final String title;

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      body: buildBody(), // This trailing comma makes auto-formatting nicer
      // for build methods.
    );
  }
}
