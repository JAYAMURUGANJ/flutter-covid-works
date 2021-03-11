import 'package:flutter/material.dart';
import 'package:ipab_template/classes/technicalMembers_class.dart';
import 'package:ipab_template/custom_widgets/chairmen_members_page_widget.dart';
import 'package:ipab_template/screens/technicalMember_page.dart';
import 'package:ipab_template/services/listoftechnicalmembers_service.dart';

class ListOfTechnicalMemberPage extends StatefulWidget {
  ListOfTechnicalMemberPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListOfTechnicalMemberPageState createState() =>
      _ListOfTechnicalMemberPageState();
}

class _ListOfTechnicalMemberPageState extends State<ListOfTechnicalMemberPage> {
  List<TechnicalMembers> tmlist = List();
  List<TechnicalMembers> technicalMembers = List();
  Icon customIcon = Icon(Icons.search);
  @override
  void initState() {
    super.initState();
    fetchListOfTechnicalMembers().then(
      (value) {
        setState(() {
          tmlist = value;
          technicalMembers = tmlist;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Of Technical Members'),
          elevation: 0.0,
        ),
        body: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: technicalMembers.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 5, left: 15, right: 15),
                child: GestureDetector(
                  child: MemberDescriptionCard(
                      boxFit: BoxFit.contain,
                      profileImage: technicalMembers[index].profileImage,
                      memberName: technicalMembers[index].memberName,
                      position: technicalMembers[index].position +
                          " (" +
                          technicalMembers[index].rCategoryName +
                          ") ."),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TechnicalMemberPage(
                          profileImage: technicalMembers[index].profileImage,
                          memberName: technicalMembers[index].memberName,
                          position: technicalMembers[index].position +
                              " (" +
                              technicalMembers[index].rCategoryName +
                              ") .",
                          html: technicalMembers[index].html,
                        ),
                      ),
                    );
                  },
                ),
              );
            }));
  }
}
