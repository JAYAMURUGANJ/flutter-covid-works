import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsone/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String postUrl;

  ArticleDetailScreen({this.postUrl});
  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        actions: <Widget>[
          Container(padding: EdgeInsets.all(10.0), child: Icon(Icons.share))
        ],
        elevation: 0.0,
        centerTitle: true, title: Text('NewsOne',style: TextStyle(fontSize:25.0),)
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
              initialUrl: widget.postUrl,
              onWebViewCreated: (WebViewController webViewController){
                _completer.complete(webViewController);
              },
          ),
        ),
      ),
    );
  }
}