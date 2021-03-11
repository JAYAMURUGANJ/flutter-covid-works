import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsone/models/category.dart';
import 'package:newsone/models/news.dart';
import 'package:newsone/widgets/categorycard.dart';
import 'package:newsone/widgets/newstile.dart';

class CategoryNewsScreen extends StatefulWidget {
  String newsCategory;
  String category;

  CategoryNewsScreen({this.newsCategory,this.category});
  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  var newsList;
  var _loading;

  void getCategoryNews() async{
    CategoryNews news = CategoryNews();
    await news.getCategoryNews(widget.newsCategory);
    newsList = news.newsList;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(padding: EdgeInsets.all(10.0), child: Icon(Icons.search))
        ],
        elevation: 0.0,
        centerTitle: true, title: Text(widget.category,style: TextStyle(fontSize:25.0),)
        ),
        body: ListView(
          children:[
          SizedBox(
            height:10.0,
          ),
          Center(child: Text('Latest News',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
          //news view
           Container(
            padding: EdgeInsets.only(top:1),
            child: _loading ? Center(child: CircularProgressIndicator())  :   ListView.builder(
              itemCount: newsList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsTile(
                    title: newsList[index].title,
                    subtitle: newsList[index].description,
                    imgUrl: newsList[index].imageUrl,
                    articleUrl: newsList[index].articleUrl,
                  ),
                );
              })
          ),
          ]          
        ),
    );
  }
}



