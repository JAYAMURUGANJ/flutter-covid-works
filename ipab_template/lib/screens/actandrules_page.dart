import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ipab_template/classes/actandrules_class.dart';
import 'package:ipab_template/custom_widgets/servicepage_widgets.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/pdfviewer/pdfViewer.dart';
import 'package:ipab_template/services/actandrules_service.dart';

class ActAndRules extends StatefulWidget {
  @override
  _ActAndRulesState createState() => _ActAndRulesState();
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

class _ActAndRulesState extends State<ActAndRules> {
  final _debouncer = Debouncer(milliseconds: 150);
  List<ARdata> documents = List();
  List<ARdata> getActAndRules = List();

  String searchCategoryName = 'Trademarks';

  @override
  void initState() {
    super.initState();
    getActAndRulesList().then(
      (value) {
        setState(() {
          documents = value;
          getActAndRules = documents
              .where((ar) => (ar.arCategory
                  .toString()
                  .contains(searchCategoryName.toString())))
              .toList();
        });
      },
    );
  }

  searchCategory(scname) {
    _debouncer.run(() {
      setState(() {
        searchCategoryName = scname;
        getActAndRules = documents
            .where((ar) => (ar.arCategory
                .toString()
                .contains(searchCategoryName.toString())))
            .toList();
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'act_and_rules')),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Image.asset('assets/images/ipab_act_and_rules_topimg.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45, // constrain height
                child: CustomRadioButton(
                  elevation: 0,
                  autoWidth: false,
                  absoluteZeroSpacing: false,
                  horizontal: false,
                  enableButtonWrap: false,
                  selectedBorderColor: Theme.of(context).accentColor,
                  unSelectedBorderColor: Theme.of(context).accentColor,
                  unSelectedColor: Theme.of(context).primaryColorLight,
                  buttonLables: [
                    'TM',
                    'PT',
                    'GI',
                    'CR',
                    'PVPAT',
                  ],
                  buttonValues: [
                    'Trademarks',
                    'Patents',
                    'Geographical Indications',
                    'Copyrights',
                    'PVPAT',
                  ],
                  defaultSelected: 'Trademarks',
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Theme.of(context).accentColor,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    searchCategory(value);
                  },
                  selectedColor: Colors.pink[200],
                  enableShape: true,
                ),
              ),
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: getActAndRules.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(
                                  pdf: getActAndRules[index].arURLlink),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1.0,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/ipab_act_and_rules_icon.png',
                                  height: 50,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                      getActAndRules[index].arDescription,
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      new IconSlideAction(
                        caption: 'Download',
                        color: Theme.of(context).dividerColor,
                        icon: Icons.file_download,
                        onTap: () {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget continueButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("Yes"),
                            onPressed: () {
                              downloadpdf(getActAndRules[index].arURLlink);
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
                      new IconSlideAction(
                        caption: 'Share',
                        color: Theme.of(context).dividerColor,
                        icon: Icons.share,
                        onTap: () {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget continueButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("Yes"),
                            onPressed: () {
                              sharepdf(getActAndRules[index].arURLlink);
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
                      ),
                    ],
                    secondaryActions: <Widget>[
                      new IconSlideAction(
                        caption: 'Download',
                        color: Theme.of(context).dividerColor,
                        icon: Icons.file_download,
                        onTap: () {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget continueButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("Yes"),
                            onPressed: () {
                              downloadpdf(getActAndRules[index].arURLlink);
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
                      new IconSlideAction(
                        caption: 'Share',
                        color: Theme.of(context).dividerColor,
                        icon: Icons.share,
                        onTap: () {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget continueButton = FlatButton(
                            textColor: Colors.orange,
                            splashColor: Colors.grey[200],
                            highlightColor: Colors.grey[200],
                            child: Text("Yes"),
                            onPressed: () {
                              sharepdf(getActAndRules[index].arURLlink);
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
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
