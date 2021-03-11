import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipab_template/animations/fadeAnimation.dart';
import 'package:ipab_template/custom_widgets/chairmen_members_page_widget.dart';

class ChairmenPage extends StatefulWidget {
  ChairmenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChairmenPageState createState() => _ChairmenPageState();
}

class _ChairmenPageState extends State<ChairmenPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chairmen'),
          elevation: 0.0,
        ),
        body: Container(
            color: Theme.of(context).dividerColor,
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 5, left: 15, right: 15),
                child: MemberDescriptionCard(
                    profileImage: 'https://ipab.gov.in/img/chairman.png',
                    memberName: 'Justice Manmohan Singh, B.A. L.L.B.',
                    position: 'Chairmen.'),
              ),
              CustomTabBar(
                tabController: _tabController,
                title1: 'Chairmen\'s Message',
                title2: 'Chairmen\'s Profile',
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Container(
                          color: Theme.of(context).dividerColor,
                          child: ListView(physics: ScrollPhysics(), children: <
                              Widget>[
                            FadeAnimation(
                              delay: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                          child: Text(
                                            'It is a privilege for me to launch the Website of Intellectual Property Appellate Board, Department for Promotion of Industry and Internal Trade, Ministry of Commerce and Industry to bring in the working of this Appellate Board and to make the Board accessible to the common public and end users. This website will benefit all concerned persons by providing day to day information/orders passed/judgements pronounced by the Appellate Board. In addition to this, the Website would also provide useful information relating to the working of this Board. Some useful links are also provided in the website to help the stakeholders for easy accessibility and expeditious disposal of cases. Any suggestion from the public, stakeholders and members of the bar of this Appellate Board to bring improvements in the working of the website is most welcome.\nAll previous data would be uploaded shortly. IPAB is under process of the same.',
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.aBeeZee(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])),
                      Container(
                          color: Theme.of(context).dividerColor,
                          child: ListView(physics: ScrollPhysics(), children: <
                              Widget>[
                            FadeAnimation(
                              delay: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                            text:
                                                'Justice Manmohan Singh, B.A. L.L.B. -',
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .accentColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'Enrolled as an Advocate on 12th August, 1980 with Bar Council of Delhi and started practice as an Advocate in Delhi High Court. Initially joined Shri Anoop Singh, Advocate practicing mostly on the original side in Trade Mark, Copy Right and Patent matters for about 9 years. After the death of Senior in 1989 he started independent practice on the original side dealing with Civil, Trade Mark and Copy Right cases independently in the Delhi High Court and Supreme Court of India. He has attended national and international seminars and presented a number of papers therein on intellectual property side. Appointed as an Additional Judge of High Court of Delhi on 11th April, 2008. Retired on 21.09.2016. In the course of his judicial career has delivered numerous landmark judgments under the Arbitration and Conciliation Act, Patents Act and the Copyright Act. He has also been the Chairman of the Public Interest Litigation Committee, Member of the Committee for Appointment of Official of High Court and Member of the Building Maintenance & Construction Committee of Rohini Court Complex, and has immensely contributed for the well being of the institution. He joined this Tribunal on 1st January, 2018 as a Chairman.',
                                                style: GoogleFonts.aBeeZee(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
