import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share&Download'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DownloadButton(),
              SizedBox(
                height: 10,
              ),
              ShareButton()
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 150,
          child: Column(
            children: <Widget>[
              Icon(Icons.file_download),
              Text("Click To Dwonload"),
            ],
          ),
        ),
      ),
      color: Colors.lightBlue[900],
      textColor: Colors.white,
      onPressed: downloadpdf,
    );
  }

  void downloadpdf() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDirectory = await getExternalStorageDirectory();
      // ignore: unused_local_variable
      final id = await FlutterDownloader.enqueue(
          url:
              'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf',
          savedDir: externalDirectory.path,
          fileName: 'IPAB-Document',
          showNotification: true,
          openFileFromNotification: true);
    } else {
      print('Permission Deined');
    }
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 150,
          child: Column(
            children: <Widget>[
              Icon(Icons.share),
              Text("Click To Share"),
            ],
          ),
        ),
      ),
      color: Colors.red[900],
      textColor: Colors.white,
      onPressed: sharepdf,
    );
  }

  Future<void> sharepdf() async {
    String url =
        'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf';
    await FlutterShare.share(
        title: 'IPAB-Document',
        text: 'Shared from IPAB',
        linkUrl: url,
        chooserTitle: 'Chennai-TM-Cause-List-On-10-07-2020.pdf');
  }
}
