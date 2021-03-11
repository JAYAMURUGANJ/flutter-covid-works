import 'package:flutter/material.dart';
import 'package:ipab_template/custom_widgets/gallery_widget.dart';

class PhotoGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        elevation: 0.0,
      ),
      body: ImageGallery(),
    );
  }
}
