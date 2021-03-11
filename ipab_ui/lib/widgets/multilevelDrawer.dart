import 'package:flutter/material.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

class MultilevelDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      children: <Widget>[
        MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.red,
          subMenuBackgroundColor: Colors.grey.shade100,
          header: Container(
            // Header for Drawer
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/ipab_logo.jpg",
                  width: 100,
                  height: 100,
                ),
              ],
            )),
          ),
          children: [
            // Child Elements for Each Drawer Item
            MLMenuItem(
                leading: Icon(Icons.account_balance),
                content: Text(
                  "About Us",
                ),
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.group),
                trailing: Icon(Icons.arrow_right),
                content: Text("Chairman & Members"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Chairman")),
                  MLSubmenu(
                      onClick: () {}, submenuContent: Text("Technical Membar")),
                  MLSubmenu(
                      onClick: () {}, submenuContent: Text("Former Chairman"))
                ]),
            MLMenuItem(
                leading: Icon(Icons.import_contacts),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Forms  Fees",
                ),
                subMenuItems: [
                  MLSubmenu(
                      onClick: () {}, submenuContent: Text("Trade Marks")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Patents")),
                  MLSubmenu(
                      onClick: () {},
                      submenuContent: Text("Geographical Indication")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Copyrights")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("PVPAT"))
                ],
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.library_books),
                trailing: Icon(Icons.arrow_right),
                content: Text("Act & Rules"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(
                      onClick: () {}, submenuContent: Text("Trade Marks")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Patents")),
                  MLSubmenu(
                      onClick: () {},
                      submenuContent: Text("Geographical Indication")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Copyrights")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("PVPAT"))
                ]),
            MLMenuItem(
                leading: Icon(Icons.perm_data_setting),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Services",
                ),
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Cause List")),
                  MLSubmenu(
                      onClick: () {}, submenuContent: Text("Daily Orders")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Orders")),
                ],
                onClick: () {}),
          ],
        )
      ],
    );
  }
}
