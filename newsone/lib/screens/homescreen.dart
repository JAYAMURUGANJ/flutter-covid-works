import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsone/models/category.dart';
import 'package:newsone/models/news.dart';
import 'package:newsone/widgets/categorycard.dart';
import 'package:newsone/widgets/newstile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsList;
  var _loading;

  void getNews() async{
    News news = News();
    await news.getNews();
    newsList = news.newsList;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/news-icon.png'),
        actions: <Widget>[
          Container(padding: EdgeInsets.all(10.0), child: Icon(Icons.search))
        ],
        elevation: 0.0,
        title: Text('NewsOne',style: TextStyle(fontSize:25.0),)
        ),
        body: ListView(
          children:[
          SizedBox(
            height:10.0,
          ),
          Center(child: Text('Category',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
          //categories view
          Container(
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorieslist.categories.length,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryCard(
                    categoryName: categorieslist.categories[index].categoryname,
                    imageUrl: categorieslist.categories[index].imageAssetUrl,
                    ),
                );
              })
          ),
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



