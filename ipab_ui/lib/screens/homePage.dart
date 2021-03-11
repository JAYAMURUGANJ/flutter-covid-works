import 'package:flutter/material.dart';
import 'package:ipab_ui/animation/fadeAnimation.dart';
import 'package:ipab_ui/widgets/colors.dart';
import 'package:ipab_ui/widgets/homepage_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipab_ui/widgets/multilevelDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  HomePage_State createState() => HomePage_State();
}

// ignore: camel_case_types
class HomePage_State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: MultilevelDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: kheadingColor),
                onPressed: () {}),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.more_vert, color: kheadingColor),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            )
          ],
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          title: Text(
            'IPAB | GOVERMENT OF INDIA',
            style: GoogleFonts.aBeeZee(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kheadingColor),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              FadeAnimation(delay: 1, child: AppTitle()),
              FadeAnimation(delay: 1.5, child: SliderCarousel()),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                delay: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleStyle(
                      title: 'Announcement',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'View all',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 15, color: kAccentColor),
                      ),
                    )
                  ],
                ),
              ),
              FadeAnimation(delay: 2, child: AnnouncementList()),
              FadeAnimation(
                delay: 2.5,
                child: TitleStyle(
                  title: 'Our Services',
                ),
              ),
              FadeAnimation(delay: 2.5, child: ServiceMenu()),
              FadeAnimation(delay: 3, child: TitleStyle(title: 'About IPAB')),
              FadeAnimation(
                delay: 3,
                child: CardTemplate(
                  description:
                      'Intellectual Property Appellate Board has been constituted by a Gazette notification of the Central Government in the Ministry of Commerce and Industry on 15th September 2003 to hear appeals against the decisions of the Registrar under the Trade Marks Act, 1999 and the Geographical Indications of Goods (Registration and Protection) Act, 1999.',
                  cardheight: 150,
                ),
              ),
              FadeAnimation(
                delay: 3.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleStyle(
                      title: 'Public Notice',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'View all',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 15, color: kAccentColor),
                      ),
                    )
                  ],
                ),
              ),
              FadeAnimation(delay: 3.5, child: AnnouncementList()),
              BodySubMenus(),
              Footer(),
            ],
          ),
        ));
  }
}
