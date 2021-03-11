import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:ipab_template/classes/notification_class.dart';
import 'package:ipab_template/custom_widgets/homePage_widgets.dart';
import 'package:ipab_template/custom_widgets/servicepage_widgets.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/services/announcement_service.dart';
import 'package:ipab_template/values/constant.dart';

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

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
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

class _AnnouncementPageState extends State<AnnouncementPage> {
  final _debouncer = Debouncer(milliseconds: 150);
  List<IPABNotifications> documents = List();
  List<IPABNotifications> announcementList = List();
  Icon customIcon = Icon(Icons.search);
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
  }

  Widget space = CustomeText();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0),
          child: Column(
            children: [
              AppBar(
                title: Text(getTranslated(context, 'announcement')),
                elevation: 0.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: space),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            check ? Icons.search : Icons.clear,
                            color: Theme.of(context).accentColor,
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
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            setState(() {
                              announcementList =
                                  announcementList.reversed.toList();
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: announcementList.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    child: AnnouncementCard2(
                      announcementStatus: announcementList[index].rNewStatus,
                      announcementDetails: announcementList[index].rBenchName +
                          " " +
                          announcementList[index].rServiceName +
                          " " +
                          announcementList[index].rCategoryName +
                          " Details on " +
                          announcementList[index].rDATE,
                      announcementPdfLink: announcementList[index].rURL,
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
                            downloadpdf(announcementList[index].rURL);
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
                            sharepdf(announcementList[index].rURL);
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
                            downloadpdf(announcementList[index].rURL);
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
                            sharepdf(announcementList[index].rURL);
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
              }),
        ));
  }

  void searchResult(string) {
    _debouncer.run(() {
      setState(() {
        announcementList = documents
            .where(
                (d) => (d.rDATE.toLowerCase().contains(string.toLowerCase())))
            .toList();
      });
    });
  }
}
