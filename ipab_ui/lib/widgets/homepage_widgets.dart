import 'package:flutter/material.dart';
import 'package:ipab_ui/screens/servicesPage.dart';
import 'package:ipab_ui/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant/instant.dart';
import 'package:carousel_pro/carousel_pro.dart';

TextStyle ktitlefontstyle = GoogleFonts.aBeeZee(
    color: kheadingColor, fontSize: 25, fontWeight: FontWeight.bold);

TextStyle kheadingfontstyle = GoogleFonts.aBeeZee(
    color: kheadingColor, fontSize: 20, fontWeight: FontWeight.bold);

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Text(
        'Intellectual Property Appellate Board',
        style: ktitlefontstyle,
      )),
    );
  }
}

class TitleStyle extends StatelessWidget {
  final String title;
  TitleStyle({this.title});
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

class CardTemplate extends StatelessWidget {
  final String description;
  final double cardheight;

  CardTemplate({this.description, this.cardheight});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: cardheight,
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
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            style: GoogleFonts.aBeeZee(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

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
      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
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

//ANNOUNCEMENT CARD
class AnnouncementCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 250,
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Notice :',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 15, fontWeight: FontWeight.bold),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chennai Patent Daily Order sheet on 24-06-2020.',
                style: GoogleFonts.aBeeZee(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnnouncementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              AnnouncementCard(),
              AnnouncementCard(),
              AnnouncementCard()
            ],
          )),
    );
  }
}

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
        height: 150,
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
                  mtitle: 'Website Policies',
                  mservicecolor: Colors.orange,
                  mserviceicon: Icons.open_in_browser,
                  mwidth: 200,
                ),
                BtnMenu(
                  mtitle: 'RTI',
                  mservicecolor: Colors.purple,
                  mserviceicon: Icons.info_outline,
                  mwidth: 100,
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
                ),
                BtnMenu(
                  mtitle: 'Help',
                  mservicecolor: Colors.blueAccent,
                  mserviceicon: Icons.help_outline,
                  mwidth: 100,
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

  BtnMenu({this.mtitle, this.mservicecolor, this.mserviceicon, this.mwidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: mwidth,
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                mserviceicon,
                color: mservicecolor,
              ),
              Text(
                mtitle,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: mservicecolor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
