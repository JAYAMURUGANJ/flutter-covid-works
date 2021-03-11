import 'dart:convert';
import 'package:flutter/material.dart';
import 'pdfviewer.dart';

class JsonPage extends StatefulWidget {
  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Load JSON File From Local"),),
      body: Center(
        child: FutureBuilder(builder: (context, snapshot){
          var showData=json.decode(snapshot.data.toString());
          return ListView.builder(
            
            itemBuilder: (BuildContext context, int index){
              return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://www.nicepng.com/png/full/196-1963170_web-icon-pdf-pdf-icon-png-green.png'),
              ),
              title: Text(showData[index]['Value']),
              subtitle: Text(showData[index]['TypeName']),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(pdf: showData[index]['File'],),
                  ),
                );
              },
                );
            },
            itemCount: showData.length,
          );
        }, future: DefaultAssetBundle.of(context).loadString("assets/pdffile.json"),
        
        ),
      ),
      
    );
  }
}

