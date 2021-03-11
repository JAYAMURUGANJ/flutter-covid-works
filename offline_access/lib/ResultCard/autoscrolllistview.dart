import 'package:flutter/material.dart';
import 'package:offline_access/ResultCard/widgettocarousel.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class RelatedLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                }),
          ],
        ),
        body: Center(child: CircualCard()));
  }
}

List<String> images = [
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg",
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg",
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg",
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg",
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg",
  "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg"
];

// ignore: must_be_immutable
class CircualCard extends StatelessWidget {
  AutoScrollController controller = AutoScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(5.0),
        itemCount: images.length,
        itemBuilder: (context, i) {
          return AutoScrollTag(
            key: ValueKey(i),
            controller: controller,
            index: i,
            child: Container(
              height: 60.0,
              width: 60.0,
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  new BoxShadow(
                      color: Color.fromARGB(100, 0, 0, 0),
                      blurRadius: 5.0,
                      offset: Offset(5.0, 5.0))
                ],
                border: Border.all(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(images[i]),
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }
}
