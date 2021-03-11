import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipab_ui/widgets/pdfViewer.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'colors.dart';

TextStyle resultCardTitleFontStyle = GoogleFonts.nunito(
    color: kheadingColor, fontSize: 15, fontWeight: FontWeight.bold);
TextStyle resultCardDescriptionFontStyle = GoogleFonts.nunito(
    color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

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

class ResultCard extends StatelessWidget {
  final String rBenchName;
  final String rServiceName;
  final String rCategoryName;
  final String rURL;
  ResultCard(
      {this.rBenchName, this.rServiceName, this.rCategoryName, this.rURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
              Image.asset(
                'assets/images/ipab_logo.jpg',
                height: 60,
              ),
              Text(
                '$rBenchName - $rServiceName',
                style: GoogleFonts.nunito(
                    color: kheadingColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$rCategoryName',
                style: GoogleFonts.nunito(
                    color: kheadingColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
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
                          '10/07/2020',
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
                      onPressed: () {
                        downloadpdf(rURL);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_red_eye),
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
                        onPressed: () {
                          sharepdf(rURL);
                        })
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
