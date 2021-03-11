import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ipab_template/classes/notification_class.dart';
import 'package:ipab_template/classes/technicalMembers_class.dart';
import 'package:ipab_template/custom_widgets/homePage_widgets.dart';
import 'package:ipab_template/custom_widgets/ipabSearch_widget.dart';
import 'package:ipab_template/custom_widgets/servicepage_widgets.dart';
import 'package:ipab_template/services/announcement_service.dart';
import 'package:ipab_template/services/listoftechnicalmembers_service.dart';
import 'package:lottie/lottie.dart';

class IpabSearch extends StatefulWidget {
  @override
  _IpabSearchState createState() => _IpabSearchState();
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

class _IpabSearchState extends State<IpabSearch> {
  // ignore: unused_field
  final _debouncer = Debouncer(milliseconds: 150);
  List<IPABNotifications> documents = List();
  List<IPABNotifications> announcementList = List();

//Search Parameters
  List<String> caseTypes = ["OA", "ORA", "TA", "TRA", "MP", "SR"];
  List<String> caseNumbers = ["322", "333", "334", "335", "336", "337"];
  List<String> servicecategorys = [
    "Trademarks",
    "Patents",
    "Geographical Indication",
    "Copyrights",
    "PVPAT"
  ];
  List<String> jurisdictions = [
    "Chennai",
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Ahmedabad"
  ];

  String _selectedTechnicalMember;
  String selectedCaseType;
  String selectedCaseNumber;
  String selectedservicecategory;
  String selectedJurisdiction;

  final fromDate = TextEditingController();
  final toDate = TextEditingController();

  Widget loading;
  bool isLoading = true;
  List<TechnicalMembers> tmlist = List();
  List<TechnicalMembers> technicalMembers = List();

  @override
  void initState() {
    super.initState();
    fetchProfileInfo().then(
      (value) {
        setState(() {
          documents = value;
          announcementList = documents;
        });
      },
    );
    fetchListOfTechnicalMembers().then(
      (value) {
        setState(() {
          tmlist = value;
          technicalMembers = tmlist;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Public Search'),
          elevation: 0.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'CaseType',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 60,
                    child: SelectionChip(
                      caseTypes,
                      onSelectionChanged: (selectedList1) {
                        setState(() {
                          selectedCaseType = selectedList1;
                        });
                      },
                    ), // constrain height
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Case Number',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 60,
                    child: SelectionChip(
                      caseNumbers,
                      onSelectionChanged: (selectedList2) {
                        setState(() {
                          selectedCaseNumber = selectedList2;
                        });
                      },
                    ), // constrain height
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Services Category',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 170,
                    child: SelectionChip(
                      servicecategorys,
                      onSelectionChanged: (selectedList3) {
                        setState(() {
                          technicalMembers = tmlist
                              .where((tm) =>
                                  (tm.rCategoryName.contains(selectedList3)))
                              .toList();
                          selectedservicecategory = selectedList3;
                        });
                      },
                    ), // constrain height
                  ),
                  //Jurisdiction

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Jurisdiction',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 120,
                    child: SelectionChip(
                      jurisdictions,
                      onSelectionChanged: (selectedList4) {
                        setState(() {
                          selectedJurisdiction = selectedList4;
                        });
                      },
                    ), // constrain height
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Technical Member',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        iconSize: 25,
                        isDense: true,
                        iconDisabledColor: Theme.of(context).accentColor,
                        hint: Text("Select Technical Member"),
                        dropdownColor: Theme.of(context).primaryColor,
                        iconEnabledColor: Theme.of(context).accentColor,
                        value: _selectedTechnicalMember,
                        underline: Container(
                          color: Colors.orange[50],
                        ), // this is the magic
                        items: technicalMembers.map<DropdownMenuItem<String>>(
                            (TechnicalMembers value) {
                          return DropdownMenuItem<String>(
                            value: value.memberName,
                            child: Text(
                              value.memberName,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _selectedTechnicalMember = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'From Date',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select From Date",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.orange),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            suffixIcon: IconButton(
                              color: Theme.of(context).accentColor,
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019, 1),
                                    lastDate: DateTime(2021, 12),
                                    builder:
                                        (BuildContext context, Widget picker2) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.deepPurple,
                                            onPrimary: Colors.white,
                                            surface: Colors.orange,
                                            onSurface: Colors.black,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: picker2,
                                      );
                                    }).then((selectedDate2) {
                                  if (selectedDate2 != null) {
                                    fromDate.text = DateFormat("dd/MM/yyyy")
                                        .format(selectedDate2)
                                        .toString();
                                  }
                                });
                              },
                            ),
                          ),
                          controller: fromDate,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'To Date',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hoverColor: Colors.orange,
                            hintText: "Select To Date",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.orange),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            suffixIcon: IconButton(
                              color: Theme.of(context).accentColor,
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019, 1),
                                    lastDate: DateTime(2021, 12),
                                    builder:
                                        (BuildContext context, Widget picker1) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.deepPurple,
                                            onPrimary: Colors.white,
                                            surface: Colors.orange,
                                            onSurface: Colors.black,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: picker1,
                                      );
                                    }).then((selectedDate1) {
                                  if (selectedDate1 != null) {
                                    toDate.text = DateFormat("dd/MM/yyyy")
                                        .format(selectedDate1)
                                        .toString();
                                  }
                                });
                              },
                            ),
                          ),
                          controller: toDate,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton.icon(
                          onPressed: () {
                            setState(() {
                              print(selectedCaseType);
                              print(selectedCaseNumber);
                              print(selectedservicecategory);
                              print(selectedJurisdiction);
                              print(_selectedTechnicalMember);
                              announcementList = documents
                                  .where((d) => (d.rCaseType
                                              .contains(selectedCaseType) &&
                                          d.rCaseNumber.toString().contains(
                                              selectedCaseNumber.toString()) &&
                                          d.rCategoryName.contains(
                                              selectedservicecategory) &&
                                          d.rBenchName
                                              .contains(selectedJurisdiction) ||
                                      d.rTechnicalMember.toLowerCase().contains(
                                          _selectedTechnicalMember
                                              .toLowerCase())))
                                  .toList();
                              isLoading = false;
                            });
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: isLoading
                                    ? loading = Lottie.asset(
                                        'assets/jsonimages/search-icon.json')
                                    : announcementList.length == 0
                                        ? Center(child: Text("No Match Found"))
                                        : ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: announcementList?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.25,
                                                child: Container(
                                                  child: AnnouncementCard2(
                                                    announcementStatus:
                                                        announcementList[index]
                                                            .rNewStatus,
                                                    announcementDetails:
                                                        announcementList[index]
                                                                .rBenchName +
                                                            " " +
                                                            announcementList[
                                                                    index]
                                                                .rServiceName +
                                                            " " +
                                                            announcementList[
                                                                    index]
                                                                .rCategoryName +
                                                            " Details on " +
                                                            announcementList[
                                                                    index]
                                                                .rDATE,
                                                    announcementPdfLink:
                                                        announcementList[index]
                                                            .rURL,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  new IconSlideAction(
                                                    caption: 'Download',
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    icon: Icons.file_download,
                                                    onTap: () {
                                                      // set up the buttons
                                                      Widget cancelButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      );
                                                      Widget continueButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          downloadpdf(
                                                              announcementList[
                                                                      index]
                                                                  .rURL);
                                                        },
                                                      );

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            "Want to download PDF?"),
                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );

                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  new IconSlideAction(
                                                    caption: 'Share',
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    icon: Icons.share,
                                                    onTap: () {
                                                      // set up the buttons
                                                      Widget cancelButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      );
                                                      Widget continueButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          sharepdf(
                                                              announcementList[
                                                                      index]
                                                                  .rURL);
                                                        },
                                                      );

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            "Want to Share PDF Link?"),
                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );

                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                                secondaryActions: <Widget>[
                                                  new IconSlideAction(
                                                    caption: 'Download',
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    icon: Icons.file_download,
                                                    onTap: () {
                                                      // set up the buttons
                                                      Widget cancelButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      );
                                                      Widget continueButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          downloadpdf(
                                                              announcementList[
                                                                      index]
                                                                  .rURL);
                                                        },
                                                      );

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            "Want to download PDF?"),
                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );

                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  new IconSlideAction(
                                                    caption: 'Share',
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    icon: Icons.share,
                                                    onTap: () {
                                                      // set up the buttons
                                                      Widget cancelButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      );
                                                      Widget continueButton =
                                                          FlatButton(
                                                        textColor:
                                                            Colors.orange,
                                                        splashColor:
                                                            Colors.grey[200],
                                                        highlightColor:
                                                            Colors.grey[200],
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          sharepdf(
                                                              announcementList[
                                                                      index]
                                                                  .rURL);
                                                        },
                                                      );

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text('Alert!'),
                                                        content: Text(
                                                            "Want to Share PDF Link?"),
                                                        actions: [
                                                          cancelButton,
                                                          continueButton,
                                                        ],
                                                      );

                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            }),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: Text(
                            'Find Match',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
