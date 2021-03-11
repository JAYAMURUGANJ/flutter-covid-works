import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: HomePage(),debugShowCheckedModeBanner: false,));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;
  Map mapResource;
  List listOfFacts;

  Future fetchData() async{
    http.Response response;
    // response = await http.get("https://thegrowingdeveloper.org/apiview?id=1");
    //response = await http.get("https://thegrowingdeveloper.org/apiview?id=4");
    response = await http.get("https://thegrowingdeveloper.org/apiview?id=2");
    if (response.statusCode == 200) {
      setState(() {
        mapResource = json.decode(response.body);
        listOfFacts = mapResource['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network Data"),backgroundColor:Colors.blue[900],),
      body: 
      mapResource == null?
      Container() : 
      SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Text(mapResource['category'].toString(), style: TextStyle(fontSize:26, color: Colors.blue[900],fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Image.network(listOfFacts[index]['image_url']),
                    Text(listOfFacts[index]['title'].toString(), style: TextStyle(fontSize:24,fontWeight: FontWeight.bold),),
                    Text(listOfFacts[index]['description'].toString(), style: TextStyle(fontSize:18),),
                  ]
                ) ,
              );
            },
            itemCount: listOfFacts == null ? 0 : listOfFacts.length,
            )
          ],
        ),
      )
    );
  }
}