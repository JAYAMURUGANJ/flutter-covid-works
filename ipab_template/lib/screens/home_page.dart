import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:ipab_template/animations/fadeAnimation.dart';
import 'package:ipab_template/classes/language_class.dart';
import 'package:ipab_template/custom_widgets/chairmen_members_page_widget.dart';
import 'package:ipab_template/custom_widgets/gallery_widget.dart';
import 'package:ipab_template/custom_widgets/homePage_widgets.dart';
import 'package:ipab_template/custom_widgets/relatedLinks_widget.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:ipab_template/main.dart';
import 'package:ipab_template/navigation_dropdown/multileveldrawer.dart';
import 'package:ipab_template/screens/ipabSearch_page.dart';
import 'package:ipab_template/screens/photoGallery_page.dart';
import 'package:ipab_template/util/theme_notifier.dart';
import 'package:ipab_template/values/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chairmen_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  var _lightTheme = true;
  //for language changing
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    //for app theme
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _lightTheme = (themeNotifier.getTheme() == lightTheme);
    return SafeArea(
      child: Scaffold(
          drawer: MultileveDrawer(),
          appBar: AppBar(
            title: Text(
              getTranslated(context, 'goverment_of_india'),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Row(
                children: <Widget>[
                  DropdownButton<Language>(
                    underline: SizedBox(),
                    icon: Image.asset(
                      'assets/images/Translate_eng_and_hindi.png',
                      width: 35,
                      height: 50,
                      scale: 0.1,
                    ),
                    onChanged: (Language language) {
                      _changeLanguage(language);
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  e.flag,
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  e.name,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    width: 80,
                    child: Transform.scale(
                      scale: 0.3,
                      child: DayNightSwitch(
                        moonImage: AssetImage('assets/images/sun.png'),
                        sunImage: AssetImage('assets/images/moon.png'),
                        sunColor: Colors.grey[100],
                        moonColor: Colors.grey[100],
                        dayColor: Colors.grey[100],
                        nightColor: Colors.grey[100],
                        value: _lightTheme,
                        onChanged: (val) {
                          setState(() {
                            _lightTheme = val;
                          });
                          onThemeChanged(val, themeNotifier);
                        },
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  )
                ],
              ),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: Image.asset('assets/images/ipab_search_icon.png'),
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IpabSearch(),
                  ),
                );
              }),
          body: ListView(
            children: <Widget>[
              FadeAnimation(delay: 1, child: AppTitle()),
              FadeAnimation(delay: 1.5, child: SliderCarousel()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.orange,
                    tabs: [
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.notifications),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(getTranslated(context, 'announcement'),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.message),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(getTranslated(context, 'public_notice'),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                    controller: _tabController,
                    indicatorColor: Colors.orangeAccent,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
              ),
              Container(
                height: 130,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.0),
                      child: IpabAnnouncementCard(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.0),
                      child: IpabAnnouncementCard(),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                delay: 2.5,
                child: SubTitleStyle(
                  title: getTranslated(context, 'our_services'),
                ),
              ),
              FadeAnimation(delay: 2.5, child: ServiceMenu()),
              FadeAnimation(
                delay: 2.7,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 5, left: 10, right: 10),
                    child: MemberDescriptionCard(
                        boxFit: BoxFit.fill,
                        profileImage: 'https://ipab.gov.in/img/chairman.png',
                        memberName: 'Justice Manmohan Singh, B.A. L.L.B.',
                        position: 'Chairmen.'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChairmenPage(),
                      ),
                    );
                  },
                ),
              ),
              FadeAnimation(
                  delay: 3,
                  child:
                      SubTitleStyle(title: getTranslated(context, 'about_us'))),
              FadeAnimation(
                delay: 3,
                child: DescriptionCard(
                  description: getTranslated(context, 'about_data'),
                  flatbtntext: ' more...',
                ),
              ),
              FadeAnimation(
                delay: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitleStyle(
                      title: getTranslated(context, 'photo_gallery'),
                    ),
                    ViewMore(
                      screenName: PhotoGallery(),
                      title: getTranslated(context, 'view_all'),
                    )
                  ],
                ),
              ),
              HomeImageGallery(),
              FadeAnimation(
                delay: 3,
                child: SubTitleStyle(
                  title: getTranslated(context, 'related_links'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RelatedLinks(), //relatedlinks
              ),
              // MonthCalendar(),
              BodySubMenus(),
              Footer(),
            ],
          )),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(lightTheme)
        : themeNotifier.setTheme(darkTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightMode', value);
  }
}

// getTranslated(context, 'ipab'),
