import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant/instant.dart';
import 'package:ipab_template/classes/notification_class.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/pdfviewer/pdfViewer.dart';
import 'package:ipab_template/screens/about_page.dart';
import 'package:ipab_template/screens/announcement_page.dart';
import 'package:ipab_template/screens/contact_page.dart';
import 'package:ipab_template/screens/help_page.dart';
import 'package:ipab_template/screens/rti_page.dart';
import 'package:ipab_template/screens/service_page.dart';
import 'package:ipab_template/screens/website_polices_page.dart';
import 'package:ipab_template/services/announcement_service.dart';
import 'package:ipab_template/values/constant.dart';

//app Title
class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Text(
        getTranslated(context, 'ipab'),
        style: ktitlefontstyle,
      )),
    );
  }
}

// Carousel slide
class SliderCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150.0,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Carousel(
          boxFit: BoxFit.fill,
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.brown,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.grey.withOpacity(0.1),
          borderRadius: true,
          images: [
            AssetImage('assets/images/ipab_banner1.jpg'),
            AssetImage('assets/images/ipab_banner2.jpg'),
            AssetImage('assets/images/ipab_banner3.jpg'),
            AssetImage('assets/images/ipab_banner4.jpg'),
            AssetImage('assets/images/ipab_banner5.jpg')
          ],
        ),
      ),
    );
  }
}

// Start -Announcement and Public Notice TabBarView
// ignore: must_be_immutable
class AnnouncementCard extends StatelessWidget {
  bool announcementStatus;
  final String announcementDetails;
  final String announcementPdfLink;
  AnnouncementCard(
      {this.announcementStatus,
      this.announcementDetails,
      this.announcementPdfLink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.blueGrey[200],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewer(pdf: announcementPdfLink),
            ),
          );
          //print(announcementPdfLink);
        },
        child: Container(
          height: 100,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).accentColor,
              )),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    if (announcementStatus = announcementStatus) {
                      return NewIndicator();
                    } else {
                      return OldIndicator();
                    }
                  })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  announcementDetails,
                  //'Chennai Patent Daily Order sheet on 24-06-2020.',
                  style: GoogleFonts.aBeeZee(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AnnouncementCard2 extends StatelessWidget {
  bool announcementStatus;
  final String announcementDetails;
  final String announcementPdfLink;
  AnnouncementCard2(
      {this.announcementStatus,
      this.announcementDetails,
      this.announcementPdfLink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.blueGrey[200],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewer(pdf: announcementPdfLink),
            ),
          );
          //print(announcementPdfLink);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1.0,
              color: Theme.of(context).accentColor,
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    if (announcementStatus = announcementStatus) {
                      return NewIndicator();
                    } else {
                      return OldIndicator();
                    }
                  })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  announcementDetails,
                  //'Chennai Patent Daily Order sheet on 24-06-2020.',
                  style: GoogleFonts.aBeeZee(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OldIndicator extends StatelessWidget {
  const OldIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Notice :',
          style: kCardTitlefontstyle,
        ),
        Container(
          height: 25,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(
              'New',
              style: GoogleFonts.aBeeZee(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}

class NewIndicator extends StatelessWidget {
  const NewIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Notice :',
          style: kCardTitlefontstyle,
        ),
        Container(
          height: 25,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.redAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(
              'New',
              style: GoogleFonts.aBeeZee(color: Colors.yellowAccent),
            )),
          ),
        ),
      ],
    );
  }
}

// End -Announcement and Public Notice TabBarView

// sub title custom widget
class SubTitleStyle extends StatelessWidget {
  final String title;
  SubTitleStyle({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Text(
        title,
        style: kheadingfontstyle,
      ),
    );
  }
}

//Start service menu
class ServiceMenu extends StatefulWidget {
  @override
  _ServiceMenuState createState() => _ServiceMenuState();
}

class _ServiceMenuState extends State<ServiceMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              BannerCard(
                title: 'Cause List',
                serviceicon: Icons.description,
                servicecolor: Colors.orange,
                cardbkcolor: Colors.orange[100],
              ),
              BannerCard(
                title: 'Daily Order',
                serviceicon: Icons.assignment,
                servicecolor: Colors.green,
                cardbkcolor: Colors.green[100],
              ),
              BannerCard(
                title: 'Order',
                serviceicon: Icons.gavel,
                servicecolor: Colors.blue,
                cardbkcolor: Colors.blue[100],
              )
            ],
          )),
    );
  }
}

class BannerCard extends StatefulWidget {
  final String title;
  final IconData serviceicon;
  final Color servicecolor;
  final Color cardbkcolor;
  final bool btnClick;

  BannerCard({
    this.title,
    this.serviceicon,
    this.servicecolor,
    this.cardbkcolor,
    this.btnClick,
  });

  @override
  _BannerCardState createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.cardbkcolor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5, 5),
                  blurRadius: 2,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  widget.serviceicon,
                  color: widget.servicecolor,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 18, color: widget.servicecolor),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            final data = BannerCard(
              title: widget.title,
              serviceicon: widget.serviceicon,
              servicecolor: widget.servicecolor,
              cardbkcolor: widget.cardbkcolor,
              btnClick: false,
            );
            print(data.btnClick);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicesPage(data: data)),
            );
          });
        },
      ),
    );
  }
}
//End service menu

//description card
class DescriptionCard extends StatelessWidget {
  final String description;
  final String flatbtntext;

  DescriptionCard({this.description, this.flatbtntext});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1.0,
              color: Theme.of(context).accentColor,
            )),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: description,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 14, color: Theme.of(context).accentColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: flatbtntext,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.orangeAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // single tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  getDateTime() {
    DateTime cetTime = dateTimeToOffset(
        offset: 1.0,
        datetime: DateTime.now()); //current DateTime in CET timezone
    return Text(
      'Last Updated: ' +
          formatDate(date: cetTime, format: 'DDMMYYYY', divider: '/'),
      style: GoogleFonts.aBeeZee(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '© Content Owned And Maintained By Intellectual Property Appellate Board (IPAB).',
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Developed And Hosted By ',
                style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'National Informatics Centre Ministry of Electronics & Information Technology,',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: ' Government of India',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[getDateTime()]),
          ),
        ],
      ),
    );
  }
}

class BodySubMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        decoration: BoxDecoration(color: KBodySubMenuBkColor, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(5, 5),
            blurRadius: 2,
          ),
        ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BtnMenu(
                  mtitle: 'Website Polices',
                  mservicecolor: Colors.orange,
                  mserviceicon: Icons.open_in_browser,
                  mwidth: 200,
                  btnClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WebsitePolices()),
                    );
                  },
                ),
                BtnMenu(
                  mtitle: 'RTI',
                  mservicecolor: Colors.purple,
                  mserviceicon: Icons.info_outline,
                  mwidth: 100,
                  btnClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RTI()),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BtnMenu(
                  mtitle: 'Contact Us',
                  mservicecolor: Colors.green,
                  mserviceicon: Icons.phone_android,
                  mwidth: 200,
                  btnClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                ),
                BtnMenu(
                  mtitle: 'Help',
                  mservicecolor: Colors.blueAccent,
                  mserviceicon: Icons.help_outline,
                  mwidth: 100,
                  btnClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

class BtnMenu extends StatelessWidget {
  final String mtitle;
  final IconData mserviceicon;
  final Color mservicecolor;
  final double mwidth;
  final Function btnClick;

  BtnMenu(
      {this.mtitle,
      this.mservicecolor,
      this.mserviceicon,
      this.mwidth,
      this.btnClick});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            children: <Widget>[
              Icon(
                mserviceicon,
                color: mservicecolor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                mtitle,
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: mservicecolor,
                ),
              )
            ],
          ),
        ),
        onPressed: btnClick);
  }
}

// ignore: must_be_immutable
class ViewMore extends StatelessWidget {
  Widget screenName;
  String title;
  ViewMore({this.screenName, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screenName),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, top: 12.0),
        child: Text(
          title,
          style: GoogleFonts.aBeeZee(fontSize: 14, color: Colors.orangeAccent),
        ),
      ),
    );
  }
}

//Home page Announcement
class IpabAnnouncementCard extends StatefulWidget {
  @override
  IpabAnnouncementCardState createState() => IpabAnnouncementCardState();
}

class IpabAnnouncementCardState extends State<IpabAnnouncementCard> {
  List<IPABNotifications> data = [];
  bool moreData;
  int current;
  static const int max = 6;
  List<IPABNotifications> response;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    current = 0;
    response = [];
    fetchProfileInfo().then((value) {
      response = value;
      data.addAll(response.sublist(current, max));
      setState(() {
        isLoading = false;
      });
    });
    moreData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Stack(
              children: [
                Container(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: moreData ? data.length + 1 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (data.length == index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Theme.of(context)
                                        .primaryColor, // button color
                                    child: InkWell(
                                      splashColor:
                                          Colors.yellow, // inkwell color
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Icon(Icons.arrow_forward,
                                            color: Colors.grey),
                                      ),
                                      onTap: () {
                                        setState(
                                          () {
                                            current = current + max;
                                            if (current + max >=
                                                response.length) {
                                              moreData =
                                                  false; //make this when you reach at end

                                              data.addAll(
                                                response.sublist(
                                                    current, response.length),
                                              );
                                            } else {
                                              data.addAll(
                                                response.sublist(
                                                    current, max + current),
                                              );
                                              moreData = true;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                          );
                        } else {
                          return AnnouncementCard(
                            announcementStatus: data[index].rNewStatus,
                            announcementDetails: data[index].rBenchName +
                                " " +
                                data[index].rServiceName +
                                " " +
                                data[index].rCategoryName +
                                " Details on " +
                                data[index].rDATE,
                            announcementPdfLink: data[index].rURL,
                          );
                        }
                      }),
                  height: 300,
                ),
                Positioned(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Opacity(
                        opacity: 1.0,
                        child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnnouncementPage(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Theme.of(context).accentColor,
                                ))),
                      )),
                ),
              ],
            ),
    );
  }
}
