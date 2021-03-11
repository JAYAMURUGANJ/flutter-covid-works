import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


class MyHomePage extends StatefulWidget {
  final String pdf;

  MyHomePage({Key key, @required this.pdf}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromURL(widget.pdf);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer'),),
      body: _loading ? Center(child: CircularProgressIndicator(),) :
      PDFViewer(document: _doc,),
    );
  }
}

