import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

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
        // appBar: AppBar(
        //   title: Text('TabBar & TabView'),
        // ),
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
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.notifications),
                          Text('Announcement',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.message),
                          Text('Public Notice',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                  controller: _tabController,
                  indicatorColor: Colors.yellow,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Container(
                height: 160,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      height: 200.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          AnnouncementCard(
                            announcementStatus: true,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 22-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                          AnnouncementCard(
                            announcementStatus: false,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 17-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                          AnnouncementCard(
                            announcementStatus: false,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 16-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      height: 200.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          AnnouncementCard(
                            announcementStatus: true,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 22-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                          AnnouncementCard(
                            announcementStatus: true,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 21-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                          AnnouncementCard(
                            announcementStatus: false,
                            announcementDetails:
                                'Chennai Patent Daily Order sheet on 19-07-2020.',
                            announcementPdfLink: 'hi.pdf',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}

class MessageCard extends StatelessWidget {
  final Icon leadingIcon;
  final String description;

  MessageCard({this.leadingIcon, this.description});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: leadingIcon,
        title: Text(description),
      ),
    );
  }
}

//ANNOUNCEMENT CARD
class AnnouncementCard extends StatelessWidget {
  bool announcementStatus;
  final String announcementDetails;
  final String announcementPdfLink;
  AnnouncementCard(
      {this.announcementStatus,
      this.announcementDetails,
      this.announcementPdfLink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print(announcementPdfLink);
        },
        child: Container(
          height: 100,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5, 5),
                  blurRadius: 2,
                ),
              ]),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    if (announcementStatus = announcementStatus) {
                      return NewIndicator();
                    } else {
                      return OldIndicator();
                    }
                  })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  announcementDetails,
                  //'Chennai Patent Daily Order sheet on 24-06-2020.',
                  style: GoogleFonts.aBeeZee(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OldIndicator extends StatelessWidget {
  const OldIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Notice :',
          style: GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 25,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(
              'New',
              style: GoogleFonts.aBeeZee(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}

class NewIndicator extends StatelessWidget {
  const NewIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Notice :',
          style: GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 25,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.redAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(
              'New',
              style: GoogleFonts.aBeeZee(color: Colors.yellowAccent),
            )),
          ),
        ),
      ],
    );
  }
}
