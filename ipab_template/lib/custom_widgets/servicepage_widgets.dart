import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ipab_template/classes/document_class.dart';
import 'package:ipab_template/pdfviewer/pdfViewer.dart';
import 'package:ipab_template/services/ipab_services.dart';
import 'package:ipab_template/values/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_share/flutter_share.dart';

class SearchTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/lime-sign-up.png',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Search Result',
      style: ksubtitlefontstyle,
    );
  }
}

class IpabResultCard extends StatefulWidget {
  final String urlBenchName;
  final String urlServiceName;
  final String urlCategoryName;
  final Color resultFontColor;
  IpabResultCard(
      {this.urlBenchName,
      this.urlServiceName,
      this.urlCategoryName,
      this.resultFontColor});
  @override
  _IpabResultCardState createState() => _IpabResultCardState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _IpabResultCardState extends State<IpabResultCard> {
  final _debouncer = Debouncer(milliseconds: 150);
  List<Document> documents = List();
  List<Document> filteredUsers = List();
  Icon customIcon = Icon(Icons.search);
  @override
  void initState() {
    super.initState();
    IpabServices.getUsers(
            widget.urlBenchName, widget.urlServiceName, widget.urlCategoryName)
        .then((usersFromServer) {
      setState(() {
        documents = usersFromServer;
        filteredUsers = documents;
      });
    });
  }

  Widget space = CustomeText();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: space),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        check ? Icons.search : Icons.clear,
                        color: widget.resultFontColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (check) {
                            check = false;
                            space = Container(
                                child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Search here',
                                hintText: 'Search here',
                              ),
                              autofocus: false,
                              onChanged: searchResult,
                            ));
                          } else {
                            check = true;
                            space = CustomeText();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.sort_by_alpha),
                      color: widget.resultFontColor,
                      onPressed: () {
                        setState(() {
                          filteredUsers = filteredUsers.reversed.toList();
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return ResultCard(
                  rBenchName: filteredUsers[index].rBenchName,
                  rServiceName: filteredUsers[index].rServiceName,
                  rCategoryName: filteredUsers[index].rCategoryName,
                  rDATE: filteredUsers[index].rDATE,
                  rURL: filteredUsers[index].rURL,
                );
              }),
        ),
      ],
    );
  }

  void searchResult(string) {
    _debouncer.run(() {
      setState(() {
        filteredUsers = documents
            .where(
                (d) => (d.rDATE.toLowerCase().contains(string.toLowerCase())))
            .toList();
      });
    });
  }
}

class ResultCard extends StatelessWidget {
  final String rBenchName;
  final String rServiceName;
  final String rCategoryName;
  final String rURL;
  final String rDATE;
  ResultCard(
      {this.rBenchName,
      this.rServiceName,
      this.rCategoryName,
      this.rURL,
      this.rDATE});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        width: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 2,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: "https://ipab.gov.in/img/logo.jpg",
                height: 60,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(
                '$rBenchName - $rServiceName',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$rCategoryName',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Date/time :',
                          style: resultCardTitleFontStyle,
                        ),
                        Text(
                          rDATE,
                          style: resultCardDescriptionFontStyle,
                        ),
                        Text(
                          'Camp/Place :',
                          style: resultCardTitleFontStyle,
                        ),
                        Text(
                          'Camp Sitting at $rBenchName',
                          style: resultCardDescriptionFontStyle,
                        ),
                        Text(
                          'Coram :',
                          style: resultCardTitleFontStyle,
                        ),
                        Text(
                          "Hon'ble Shri Justice Manmohan Singh, \nHon'ble Dr. Onkar nath Singh",
                          style: resultCardDescriptionFontStyle,
                        ),
                        Text(
                          'Applicant :',
                          style: resultCardTitleFontStyle,
                        ),
                        Text(
                          "Adhya Kumar,\nhans Apartments.",
                          style: resultCardDescriptionFontStyle,
                        ),
                        Text(
                          'Respondent :',
                          style: resultCardTitleFontStyle,
                        ),
                        Text(
                          "The Registrar Of Trade Marks,\ntrademarks Registry,\nchennai.",
                          style: resultCardDescriptionFontStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.file_download,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        // set up the buttons
                        Widget cancelButton = FlatButton(
                          textColor: Colors.orange,
                          splashColor: Colors.grey[200],
                          highlightColor: Colors.grey[200],
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        Widget continueButton = FlatButton(
                          textColor: Colors.orange,
                          splashColor: Colors.grey[200],
                          highlightColor: Colors.grey[200],
                          child: Text("Ok"),
                          onPressed: () {
                            downloadpdf(rURL);
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text('Alert!'),
                          content: Text("Want to download PDF?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewer(pdf: rURL),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      color: Colors.black,
                      onPressed: () {
                        // set up the buttons
                        Widget cancelButton = FlatButton(
                          textColor: Colors.orange,
                          splashColor: Colors.grey[200],
                          highlightColor: Colors.grey[200],
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        Widget continueButton = FlatButton(
                          textColor: Colors.orange,
                          splashColor: Colors.grey[200],
                          highlightColor: Colors.grey[200],
                          child: Text("Ok"),
                          onPressed: () {
                            sharepdf(rURL);
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text('Alert!'),
                          content: Text("Want to Share PDF Link?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void downloadpdf(String fileurl) async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    final externalDirectory = await getExternalStorageDirectory();
    // ignore: unused_local_variable
    final id = await FlutterDownloader.enqueue(
        url: fileurl,
        savedDir: externalDirectory.path,
        fileName: 'IPAB-Document',
        showNotification: true,
        openFileFromNotification: true);
  } else {
    print('Permission Deined');
  }
}

Future<void> sharepdf(String fileurl) async {
  String url = fileurl;
  await FlutterShare.share(
      title: 'IPAB-Document',
      text: 'Shared from IPAB',
      linkUrl: url,
      chooserTitle: 'Chennai-TM-Cause-List-On-10-07-2020.pdf');
}
