import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberDescriptionCard extends StatelessWidget {
  final String profileImage;
  final String memberName;
  final String position;
  final BoxFit boxFit;
  MemberDescriptionCard(
      {this.profileImage, this.memberName, this.position, this.boxFit});
  @override
  Widget build(BuildContext context) {
    final double circleRadius = 120.0;
    return Stack(children: <Widget>[
      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: circleRadius / 2.0,
            ),
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
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: circleRadius / 2,
                      ),
                      Text(
                        memberName,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        position,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          new Container(
            width: 120.0,
            height: 120.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
              border: new Border.all(
                color: Theme.of(context).primaryColor,
                width: 5.0,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: profileImage,
                fit: boxFit,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key key,
    this.title1,
    this.title2,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TabBar(
          //isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Theme.of(context).accentColor,
          tabs: [
            Tab(
              child: Row(
                children: <Widget>[
                  Text(title1,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 13, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text(title2,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 13, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
//former chairmen details

class FchairmenDetail {
  int sno;
  String name;
  String period;

  FchairmenDetail(this.sno, this.name, this.period);
}

var fChairmenDetails = <FchairmenDetail>[
  FchairmenDetail(1, "SHRI JUSTICE S. JAGADEESAN", "15-09-2003 to 18-03-2006"),
  FchairmenDetail(2, "SHRI JUSTICE M.H.S. ANSARI", "29-11-2006 to 19-03-2008"),
  FchairmenDetail(3, "SHRI Z.S.NEGI", "20-03-2008 to 10-08-2010"),
  FchairmenDetail(
      4, "SMT. JUSTICE PRABHA SRIDEVAN", "09-05-2011 to 08-08-2013"),
  FchairmenDetail(5, "SHRI JUSTICE K.N. BASHA", "23-08-2013 to 13-05-2016"),
];

var _sortAscending = true;
var _sortColumnIndex = 0;

class FormerChairmenDatatable extends StatefulWidget {
  @override
  _FormerChairmenDatatableState createState() =>
      _FormerChairmenDatatableState();
}

class _FormerChairmenDatatableState extends State<FormerChairmenDatatable> {
  @override
  Widget build(BuildContext context) {
    return bodyData();
  }

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columns: <DataColumn>[
        DataColumn(
          label: Text("S.No", style: GoogleFonts.aBeeZee()),
          numeric: false,
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              if (ascending) {
                fChairmenDetails.sort((a, b) => a.sno.compareTo(b.sno));
              } else {
                fChairmenDetails.sort((a, b) => b.sno.compareTo(a.sno));
              }
            });
          },
          //tooltip: "To display first name of the Person",
        ),
        DataColumn(
          label: Text("Name", style: GoogleFonts.aBeeZee()),
          numeric: false,
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              if (ascending) {
                fChairmenDetails.sort((a, b) => a.name.compareTo(b.name));
              } else {
                fChairmenDetails.sort((a, b) => b.name.compareTo(a.name));
              }
            });
          },
        ),
        DataColumn(
          label: Text("Period", style: GoogleFonts.aBeeZee()),
          numeric: false,
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              if (ascending) {
                fChairmenDetails.sort((a, b) => a.period.compareTo(b.period));
              } else {
                fChairmenDetails.sort((a, b) => b.period.compareTo(a.period));
              }
            });
          },
        ),
      ],
      rows: fChairmenDetails
          .map(
            (fChairmenDetail) => DataRow(
              cells: [
                DataCell(
                  Text(fChairmenDetail.sno.toString(),
                      style: GoogleFonts.aBeeZee()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(fChairmenDetail.name, style: GoogleFonts.aBeeZee()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(fChairmenDetail.period, style: GoogleFonts.aBeeZee()),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());
}
