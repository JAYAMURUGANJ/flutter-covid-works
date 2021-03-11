import 'package:flutter/material.dart';
import 'package:ipab_template/custom_widgets/homePage_widgets.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/screens/about_page.dart';
import 'package:ipab_template/screens/actandrules_page.dart';
import 'package:ipab_template/screens/calendar_page.dart';
import 'package:ipab_template/screens/chairmen_page.dart';
import 'package:ipab_template/screens/former_chairmen_page.dart';
import 'package:ipab_template/screens/listofTechnicalMembers_page.dart';
import 'package:ipab_template/screens/service_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MultileveDrawer extends StatefulWidget {
  @override
  _MultileveDrawerState createState() => _MultileveDrawerState();
}

class _MultileveDrawerState extends State<MultileveDrawer> {
  @override
  Widget build(BuildContext context) {
    TextStyle menuFontStyle = GoogleFonts.aBeeZee(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor);

    Color menuIconStyle = Theme.of(context).accentColor;

    return Container(
      width: 210,
      child: Drawer(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/images/ipab_logo.jpg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.account_balance,
                color: menuIconStyle,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: menuIconStyle,
              ),
              title: Text(
                getTranslated(context, 'about_us'),
                style: menuFontStyle,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              }),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(
              Icons.people,
              color: menuIconStyle,
            ),
            title: Text(
              getTranslated(context, 'chairman_and_members'),
              style: menuFontStyle,
            ),
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'chairman'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChairmenPage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'tecnical_members'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListOfTechnicalMemberPage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'former_chairman'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormerChairmen(),
                    ),
                  );
                },
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              leading: Icon(
                Icons.local_offer,
                color: menuIconStyle,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: menuIconStyle,
              ),
              title: Text(
                getTranslated(context, 'act_and_rules'),
                style: menuFontStyle,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActAndRules()),
                );
              }),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(
              Icons.table_chart,
              color: menuIconStyle,
            ),
            title: Text(
              getTranslated(context, 'our_services'),
              style: menuFontStyle,
            ),
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'cause_list'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    final data = BannerCard(
                      title: 'Cause List',
                      serviceicon: Icons.description,
                      servicecolor: Colors.orange,
                      cardbkcolor: Colors.orange[100],
                      btnClick: false,
                    );
                    print(data.btnClick);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesPage(data: data)),
                    );
                  });
                },
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'daily_order'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    final data = BannerCard(
                      title: 'Daily Order',
                      serviceicon: Icons.assignment,
                      servicecolor: Colors.green,
                      cardbkcolor: Colors.green[100],
                      btnClick: false,
                    );
                    print(data.btnClick);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesPage(data: data)),
                    );
                  });
                },
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'order'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    final data = BannerCard(
                      title: 'Order',
                      serviceicon: Icons.gavel,
                      servicecolor: Colors.blue,
                      cardbkcolor: Colors.blue[100],
                      btnClick: false,
                    );
                    print(data.btnClick);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesPage(data: data)),
                    );
                  });
                },
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(
              Icons.filter_frames,
              color: menuIconStyle,
            ),
            title: Text(
              getTranslated(context, 'forms_and_fees'),
              style: menuFontStyle,
            ),
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'trademark'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'patents'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'geographical_indication'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'copyrights'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  getTranslated(context, 'pvpat'),
                  style: menuFontStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: menuIconStyle,
                ),
                onTap: () {},
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: menuIconStyle,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: menuIconStyle,
            ),
            title: Text(
              getTranslated(context, 'calendar'),
              style: menuFontStyle,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YearCalendar(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}
