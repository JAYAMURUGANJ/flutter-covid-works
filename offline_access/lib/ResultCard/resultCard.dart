import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offline_access/ResultCard/IpabServices.dart';
import 'package:offline_access/ResultCard/Document.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:offline_access/ResultCard/test.dart';

//app Title font style
TextStyle ktitlefontstyle = GoogleFonts.aBeeZee(
    fontSize: 17, fontWeight: FontWeight.w100, color: Colors.blue);
//app Sub Title font style
TextStyle kheadingfontstyle =
    GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold);
// Announcement notice font
TextStyle kCardTitlefontstyle =
    GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold);
//service document card font style
TextStyle resultCardTitleFontStyle = GoogleFonts.nunito(
    color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
TextStyle resultCardDescriptionFontStyle = GoogleFonts.nunito(
    color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

class IpabResultCard extends StatefulWidget {
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
    IpabServices.getUsers().then((usersFromServer) {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('IPAB Result'),
        actions: [
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              if (check) {
                                check = false;
                                space = Container(
                                    child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Date',
                                    hintText: 'Enter Date',
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
                          color: Colors.blue,
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
        ),
      ),
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
                rCategoryName,
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
                          'Date:',
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
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.black,
                        onPressed: () {})
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

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Search Result',
      style: ktitlefontstyle,
    );
  }
}
