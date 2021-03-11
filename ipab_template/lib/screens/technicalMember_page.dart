import 'package:flutter/material.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
import 'package:ipab_template/custom_widgets/chairmen_members_page_widget.dart';

class TechnicalMemberPage extends StatefulWidget {
  final String profileImage;
  final String memberName;
  final String position;
  final String html;

  TechnicalMemberPage(
      {this.profileImage, this.memberName, this.position, this.html});

  @override
  _TechnicalMemberPageState createState() => _TechnicalMemberPageState();
}

class _TechnicalMemberPageState extends State<TechnicalMemberPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Technical Member'),
          elevation: 0.0,
        ),
        body: Container(
            color: Theme.of(context).dividerColor,
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 5, left: 15, right: 15),
                child: MemberDescriptionCard(
                    profileImage: widget.profileImage,
                    memberName: widget.memberName,
                    position: widget.position),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 5, left: 15, right: 15),
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: HtmlTextView(
                      data: widget.html,
                      // anchorColor: Color(0xFFFF0000),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
