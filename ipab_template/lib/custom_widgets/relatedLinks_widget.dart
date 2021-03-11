import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class RelatedLinks extends StatefulWidget {
  @override
  _RelatedLinksState createState() => _RelatedLinksState();
}

class _RelatedLinksState extends State<RelatedLinks> {
  // ignore: unused_field
  int _currentIndex = 0;

  List cardList = [
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/gandhi.png',
      rLinkTitle: 'Department for Promotion of Industry and Internal Trade',
      rLinkWebLink: 'https://dipp.gov.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/ip_india.jpg',
      rLinkTitle: 'Controller General of Patents, Designs & Trade Marks',
      rLinkWebLink: 'http://www.ipindia.nic.in/index.htm',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/copyright_office.gif',
      rLinkTitle: 'Copyright Office',
      rLinkWebLink: 'https://copyright.gov.in/Default.aspx',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/india_code.jpg',
      rLinkTitle: 'India Code Portal',
      rLinkWebLink: 'https://www.indiacode.nic.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/wipo.jpg',
      rLinkTitle: 'World Intellectual Property Organization (WIPO)',
      rLinkWebLink: 'https://www.wipo.int/portal/en/index.html',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/supremecourt.jpg',
      rLinkTitle: 'Supreme Court of India',
      rLinkWebLink: 'https://main.sci.gov.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/delhi_highcourt.jpg',
      rLinkTitle: 'Delhi High Court',
      rLinkWebLink: 'http://delhihighcourt.nic.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/kolkatta_highcourt.jpg',
      rLinkTitle: 'Calcutta High Court',
      rLinkWebLink: 'https://www.calcuttahighcourt.gov.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/bombay_highcourt.jpg',
      rLinkTitle: 'Bombay High Court',
      rLinkWebLink: 'https://bombayhighcourt.nic.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/madras_highcourt.jpg',
      rLinkTitle: 'High Court Madras',
      rLinkWebLink: 'http://www.hcmadras.tn.nic.in/',
    ),
    RelatedLinkCard(
      rLinkImage: 'https://www.ipab.gov.in/img/logos/gujarat_highcourt.png',
      rLinkTitle: 'Gujarath High Court',
      rLinkWebLink: 'https://gujarathighcourt.nic.in/',
    )
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    return Column(
      children: <Widget>[
        CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 80,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: cardList.map((cards) {
            return Builder(builder: (BuildContext context) {
              return Container(
                child: cards,
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(cardList, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class RelatedLinkCard extends StatelessWidget {
  final String rLinkImage;
  final String rLinkTitle;
  final String rLinkWebLink;

  RelatedLinkCard({this.rLinkImage, this.rLinkTitle, this.rLinkWebLink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // set up the buttons
          Widget cancelButton = FlatButton(
            textColor: Colors.orange,
            splashColor: Colors.grey[200],
            highlightColor: Colors.grey[200],
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
          Widget continueButton = FlatButton(
            textColor: Colors.orange,
            highlightColor: Colors.grey[200],
            splashColor: Colors.grey[200],
            child: Text("Continue"),
            onPressed: () async {
              if (await canLaunch(rLinkWebLink)) {
                Navigator.of(context).pop();
                await launch(rLinkWebLink);
              } else {
                throw 'Could not launch $rLinkWebLink';
              }
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text(rLinkWebLink),
            content: Text(
                "You are being redirected to an external website. Please note that IPAB cannot be held responsible for external websites content &amp; privacy policies."),
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: rLinkImage,
                  height: 60.0,
                  width: 70,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(rLinkTitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
