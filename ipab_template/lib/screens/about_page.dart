import 'package:flutter/material.dart';
import 'package:ipab_template/animations/fadeAnimation.dart';
import 'package:ipab_template/custom_widgets/homePage_widgets.dart';
import 'package:ipab_template/localization/language_constants.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: Text(
                getTranslated(context, 'ipab'),
                style: TextStyle(
                  color: Colors.orange[80],
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Image.asset(
                "assets/images/ipab_logo.jpg",
                width: 120,
                height: 80,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: <Widget>[
                FadeAnimation(
                    delay: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SubTitleStyle(
                            title: getTranslated(context, 'about_us')),
                      ),
                    )),
                FadeAnimation(
                  delay: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DescriptionCard(
                      description: getTranslated(context, 'full_about_data'),
                    ),
                  ),
                ),
              ],
            )
          ]))
        ],
      ),
    );
  }
}
