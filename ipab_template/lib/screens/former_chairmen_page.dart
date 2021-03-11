import 'package:flutter/material.dart';
import 'package:ipab_template/custom_widgets/chairmen_members_page_widget.dart';

class FormerChairmen extends StatefulWidget {
  @override
  _FormerChairmenState createState() {
    return new _FormerChairmenState();
  }
}

class _FormerChairmenState extends State<FormerChairmen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Former Chairmen"),
          elevation: 0.0,
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(16.0),
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
                ]),
            child: ListView(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/formerchairmens.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FormerChairmenDatatable(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
