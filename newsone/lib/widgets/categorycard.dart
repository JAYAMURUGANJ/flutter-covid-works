import 'package:flutter/material.dart';
import 'package:newsone/screens/category_news_screen.dart';


class CategoryCard extends StatelessWidget {
  String categoryName;
  String imageUrl;

  CategoryCard({this.categoryName,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            CategoryNewsScreen(
              category: categoryName,
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
          child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
              child: Image.network(
              imageUrl,
              width: 160,
              height: 250,
              fit:BoxFit.cover
            ),
          ),
          Container(
            height: 250,
            width: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:Colors.black38,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Colors.white,
                fontSize: 22,
                fontWeight:FontWeight.bold
              ),
            )
          ),
        ],
      ),
    );
  }
}