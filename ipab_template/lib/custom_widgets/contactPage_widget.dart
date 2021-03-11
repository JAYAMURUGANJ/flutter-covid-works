import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDescriptionCard extends StatelessWidget {
  final String placeImage;
  final String contactPerson;
  final String address;
  ContactDescriptionCard({this.placeImage, this.contactPerson, this.address});
  @override
  Widget build(BuildContext context) {
    final double circleRadius = 120.0;
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: circleRadius / 2.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: circleRadius / 2,
                        ),
                        Text(
                          contactPerson,
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          address,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            new Container(
              width: 200.0,
              height: 120.0,
              decoration: new BoxDecoration(
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  image: new AssetImage(placeImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                border: new Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 5.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class FAADescriptionCard extends StatelessWidget {
  final String placeImage;
  final String contactPerson;
  final String address;
  FAADescriptionCard({this.placeImage, this.contactPerson, this.address});
  @override
  Widget build(BuildContext context) {
    final double circleRadius = 120.0;
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: circleRadius / 2.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: circleRadius / 2,
                        ),
                        Text(
                          contactPerson,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          address,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
                border: new Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 5.0,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  placeImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

// ignore: must_be_immutable
class ContactCard extends StatelessWidget {
  final Icon cardIcon;
  final String cardTitle;
  final String cardSubTitle;
  Function cardFunction;
  ContactCard(
      {this.cardIcon, this.cardTitle, this.cardSubTitle, this.cardFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: GestureDetector(
        onTap: cardFunction,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
          ),
          width: double.infinity,
          child: ListTile(
            leading: cardIcon,
            title: Text(
              cardTitle,
              style: GoogleFonts.aBeeZee(),
            ),
            subtitle: Text(
              cardSubTitle,
              style: GoogleFonts.aBeeZee(),
            ),
            trailing: Icon(Icons.arrow_right),
          ),
        ),
      ),
    );
  }
}
