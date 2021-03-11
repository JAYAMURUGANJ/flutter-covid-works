import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import 'autoscrolllistview.dart';

TextStyle ktitlefontstyle = GoogleFonts.aBeeZee(
    fontSize: 17, fontWeight: FontWeight.w100, color: Colors.blue);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
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
          title: Text('Test'),
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelatedLinks(),
                    ),
                  );
                }),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Theme.of(context).accentColor),
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xffFDCF09),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/zxguBLjVFS2020-03-04.jpg'),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RichText(
                            text: TextSpan(
                                text: 'Jamu03031996 \n',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Flutter Developer',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18))
                                ]),
                          ),
                        )),
                  ])),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.amber,
                  tabs: [
                    Tab(
                        child: ListTile(
                            leading: Icon(Icons.code),
                            title: Text('Language',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold)))),
                    Tab(
                        child: ListTile(
                            leading: Icon(Icons.extension),
                            title: Text('Software',
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold))))
                  ],
                  controller: _tabController,
                  indicatorColor: Colors.yellow,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Container(
                height: 500.0,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Language(),
                    Language(),
                  ],
                ),
              ),
            ])));
  }
}

class Language extends StatefulWidget {
  @override
  LanguageState createState() => LanguageState();
}

class LanguageState extends State<Language> {
  List<ProfileInfo> data = [];
  bool moreData;
  int current;
  static const int max = 5;
  List<ProfileInfo> response;
  Widget space = CustomeText();
  bool check = true;
  @override
  void initState() {
    super.initState();
    current = 0;
    response = [];
    TestServices.getUsers().then((value) {
      setState(() {
        response = value;
        data.addAll(response.sublist(current, max));
      });
    });
    moreData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: space),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        check ? Icons.search : Icons.clear,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          if (check) {
                            check = false;
                            space = Container(
                                child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Date',
                                hintText: 'Enter Date',
                              ),
                              autofocus: false,
                              onChanged: (string) {
                                setState(() {
                                  data = data
                                      .where((d) => (d.rDATE
                                          .toLowerCase()
                                          .contains(string.toLowerCase())))
                                      .toList();
                                });
                              },
                            ));
                          } else {
                            check = true;
                            space = CustomeText();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.sort_by_alpha),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          data = data.reversed.toList();
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
            child: Container(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moreData ? data.length + 1 : data.length,
              itemBuilder: (BuildContext context, int index) {
                if (data.length == index) {
                  return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.yellow, // inkwell color
                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.grey)),
                            onTap: () {
                              setState(() {
                                current = current + max;
                                if (current + max >= response.length) {
                                  moreData =
                                      false; //make this when you reach at end

                                  data.addAll(response.sublist(
                                      current, response.length));
                                } else {
                                  data.addAll(
                                      response.sublist(current, max + current));
                                  moreData = true;
                                }
                              });
                            },
                          ),
                        ),
                      ));
                } else {
                  return Card(
                    child: InkWell(
                      splashColor: Colors.red,
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(data[index].rDATE,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  );
                }
              }),
          height: 100,
        )),
      ],
    );
  }

  // Future<List<ProfileInfo>> fetchProfileInfo() async {
  //   final response = await http.get(
  //       'https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/KjiEDtCJHQdocument.json');

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON. ProfileInfo.fromJson(json.decode(response.body))

  //     Iterable I = json.decode(response.body);
  //     List<ProfileInfo> list = List<ProfileInfo>.from(
  //         (I as List).map((i) => ProfileInfo.fromJson(i)));
  //     return list;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }
}

class TestServices {
  static const String url =
      "https://storage.googleapis.com/s3.codeapprun.io/userassets/jayamurugan/KjiEDtCJHQdocument.json";

  // ignore: missing_return
  static Future<List<ProfileInfo>> getUsers() async {
    String fileName = "test.json";

    var dir = await getTemporaryDirectory();

    File file = new File(dir.path + "/" + fileName);
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      print('connected');
      try {
        print("Loading from API");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          var listofdata = response.body;
          List<ProfileInfo> list = parseUsers(listofdata);
          file.writeAsStringSync(listofdata, flush: true, mode: FileMode.write);
          return list;
        } else {
          throw Exception("Error");
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    } else if (file.existsSync()) {
      print("Loading from cache");
      var jsonData = file.readAsStringSync();
      List<ProfileInfo> list = parseUsers(jsonData);
      return list;
    } else {
      print("App first time loaded. So please on mobile data.");
    }
  }

  static List<ProfileInfo> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProfileInfo>((json) => ProfileInfo.fromJson(json))
        .toList();
  }
}

class ProfileInfo {
  String rBenchName;
  String rServiceName;
  String rCategoryName;
  String rDATE;
  String rURL;

  ProfileInfo(
      {this.rBenchName,
      this.rServiceName,
      this.rCategoryName,
      this.rDATE,
      this.rURL});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    rBenchName = json['rBenchName'];
    rServiceName = json['rServiceName'];
    rCategoryName = json['rCategoryName'];
    rDATE = json['rDATE'];
    rURL = json['rURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rBenchName'] = this.rBenchName;
    data['rServiceName'] = this.rServiceName;
    data['rCategoryName'] = this.rCategoryName;
    data['rDATE'] = this.rDATE;
    data['rURL'] = this.rURL;
    return data;
  }
}

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Search Result',
      style: ktitlefontstyle,
    );
  }
}
