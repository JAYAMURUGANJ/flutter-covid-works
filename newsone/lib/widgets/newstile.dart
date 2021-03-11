import 'package:flutter/material.dart';
import 'package:newsone/screens/article_screen.dart';

class NewsTile extends StatelessWidget {
  String title;
  String subtitle;
  String imgUrl;
  String articleUrl;

  NewsTile({this.title,this.subtitle,this.imgUrl,this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ArticleDetailScreen(postUrl: articleUrl,),
        ));
      },
          child: Container(
        child: ListTile(
          title:Text(title,style: TextStyle(fontWeight:FontWeight.bold),),
          subtitle:Text(subtitle,maxLines: 2,),
          leading:ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imgUrl,width: 60,height: 90,fit: BoxFit.cover,)),
        ),
      ),
    );
  }
}