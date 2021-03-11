import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipab_ui/animation/fadeAnimation.dart';
import 'package:ipab_ui/widgets/homepage_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipab_ui/widgets/servicepage_widgets.dart';
import 'package:lottie/lottie.dart';

List<String> benchNames = [
  'Chennai',
  'Delhi',
  'Mumbai',
  'Kolkata',
  'Ahmedabad'
];
var _chosenbenchValue = benchNames[0];
List<String> causeListCat = [
  'Trade Mark',
  'Patent',
  'Geographical Indications',
  'Copyrights',
  'PVPAT'
];
var _chosenCauseListCatValue = causeListCat[0];

Widget searchResult;

class ServicesPage extends StatefulWidget {
  final BannerCard data;
  ServicesPage({this.data});
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  void initState() {
    super.initState();
    setState(() {
      searchResult = SearchTemp();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool btnClick = widget.data.btnClick;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        title: Text(
          widget.data.title,
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
        backgroundColor: widget.data.servicecolor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              child: Stack(
                children: <Widget>[
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(150.0)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              widget.data.servicecolor,
                              widget.data.cardbkcolor
                            ]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: FadeAnimation(
                              delay: 1.5,
                              child: Text(
                                'Search IPAB ${widget.data.title} files.',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            delay: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      widget.data.serviceicon,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Category',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: _chosenCauseListCatValue,
                                      underline:
                                          Container(), // this is the magic
                                      items: causeListCat
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenCauseListCatValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            delay: 2.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.business,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Bench',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: _chosenbenchValue,
                                      underline:
                                          Container(), // this is the magic
                                      items: benchNames
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenbenchValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: FadeAnimation(
                        delay: 3,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: widget.data.servicecolor,
                          ),
                          iconSize: 40,
                          tooltip: 'Search',
                          onPressed: () {
                            setState(() {
                              searchResult = Lottie.asset(
                                  'assets/jsonimages/search-icon.json');
                            });
                            Timer(Duration(seconds: 5), () {
                              // 5s over, navigate to a new page
                              listresult(btnClick);
                            });
                          },
                        ),
                      ))
                ],
              ),
            ),
            FadeAnimation(
              delay: 3.5,
              child: Container(
                child: searchResult,
              ),
            )
          ],
        ),
      )),
    );
  }

  void listresult(bool btnClick) {
    btnClick = !btnClick;
    return setState(() {
      if (btnClick == true) {
        searchResult = Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ResultCard(
                rBenchName: _chosenbenchValue,
                rServiceName: widget.data.title,
                rCategoryName: _chosenCauseListCatValue,
                rURL:
                    'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf',
              ),
              ResultCard(
                rBenchName: _chosenbenchValue,
                rServiceName: widget.data.title,
                rCategoryName: _chosenCauseListCatValue,
                rURL:
                    'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf',
              ),
              ResultCard(
                rBenchName: _chosenbenchValue,
                rServiceName: widget.data.title,
                rCategoryName: _chosenCauseListCatValue,
                rURL:
                    'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf',
              ),
              ResultCard(
                rBenchName: _chosenbenchValue,
                rServiceName: widget.data.title,
                rCategoryName: _chosenCauseListCatValue,
                rURL:
                    'https://ipab.gov.in/ipab_causelist/chennai/Chennai-TM-Cause-List-On-10-07-2020.pdf',
              )
            ],
          ),
        );
      }
    });
  }
}
