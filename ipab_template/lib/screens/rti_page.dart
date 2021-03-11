import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipab_template/custom_widgets/contactPage_widget.dart';
import 'package:ipab_template/services/calls_and_messages_service.dart';
import 'package:ipab_template/services/service_locator.dart';

class RTI extends StatefulWidget {
  @override
  _RTIState createState() => _RTIState();
}

class _RTIState extends State<RTI> with SingleTickerProviderStateMixin {
  final CallsAndMessagesService service = locator<CallsAndMessagesService>();
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rights To Information'),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: Theme.of(context).accentColor,
                tabs: [
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Text('CPIO-Chennai',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Text('CPIO-Delhi',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Text('First Appellate Authority',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
                controller: _tabController,
                indicatorColor: Theme.of(context).accentColor,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(
                      color: Theme.of(context).dividerColor,
                      child: ListView(children: <Widget>[
                        FAADescriptionCard(
                            placeImage: 'assets/images/rti.png',
                            contactPerson:
                                'Central Public Information Officer (CPIO-Chennai)',
                            address:
                                'The Deputy Registrar,\nIntellectual Property Appellate Board,\nGuna Complex Annexe-I, 2nd Floor,\n443 Anna Salai, Teynampet,\nChennai- 600 018.'),
                        ContactCard(
                            cardIcon: Icon(Icons.local_phone),
                            cardTitle: ' 24328902/03',
                            cardFunction: () {
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
                                  service.call('24328902');
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text('Alert!'),
                                content: Text("Want to Call?"),
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
                            cardSubTitle: 'Tele'),
                        ContactCard(
                            cardIcon: Icon(Icons.local_printshop),
                            cardTitle: '24328905',
                            cardSubTitle: 'TeleFax'),
                        ContactCard(
                            cardIcon: Icon(Icons.mail),
                            cardTitle: 'ipab.tn@nic.in',
                            cardFunction: () {
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
                                  service.sendEmail('ipab.tn@nic.in');
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text('Alert!'),
                                content: Text("Sure to send Email?"),
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
                            cardSubTitle: 'Email')
                      ])),
                  Container(
                    color: Theme.of(context).dividerColor,
                    child: ListView(
                      children: <Widget>[
                        FAADescriptionCard(
                            placeImage: 'assets/images/rti.png',
                            contactPerson:
                                'Central Public Information Officer (CPIO-Delhi)',
                            address:
                                'The Court Officer,\nIntellectual Property Appellate Board,\nG 62 - 67 & 196-204 of Plot No.25,\nAugust Kranti Bhawan,\nBikaji Cama Place, Rama Krishna Puram,\nNew Delhi - 110 066.'),
                        ContactCard(
                            cardIcon: Icon(Icons.local_phone),
                            cardTitle: '011-26180613/14',
                            cardFunction: () {
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
                                  service.call('011-26180613');
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text('Alert!'),
                                content: Text("Want to Call?"),
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
                            cardSubTitle: 'Tele'),
                      ],
                    ),
                  ),
                  Container(
                      color: Theme.of(context).dividerColor,
                      child: ListView(children: <Widget>[
                        FAADescriptionCard(
                            placeImage: 'assets/images/faa.png',
                            contactPerson: 'First Appellate Authority (FAA)',
                            address:
                                'The Chairman,\nIntellectual Property Appellate Board,\nGuna Complex Annexe-I, 2nd Floor,\n443 Anna Salai, Teynampet,\nChennai - 600 018.'),
                        ContactCard(
                            cardIcon: Icon(Icons.local_phone),
                            cardTitle: ' 24328902/03',
                            cardFunction: () {
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
                                  service.call('24328902');
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text('Alert!'),
                                content: Text("Want to Call?"),
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
                            cardSubTitle: 'Tele'),
                        ContactCard(
                            cardIcon: Icon(Icons.local_printshop),
                            cardTitle: '24328905',
                            cardSubTitle: 'TeleFax'),
                        ContactCard(
                            cardIcon: Icon(Icons.mail),
                            cardTitle: 'ipab.tn@nic.in',
                            cardFunction: () {
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
                                  service.sendEmail('ipab.tn@nic.in');
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text('Alert!'),
                                content: Text("Sure to send Email?"),
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
                            cardSubTitle: 'Email')
                      ])),
                ],
              ),
            ),
          ]),
        ));
  }
}
