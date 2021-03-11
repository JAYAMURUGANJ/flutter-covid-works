import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeImageGallery extends StatefulWidget {
  @override
  _HomeImageGalleryState createState() => _HomeImageGalleryState();
}

class _HomeImageGalleryState extends State<HomeImageGallery> {
  List<String> imageList = [
    'https://www.ipab.gov.in/img/gallery/ipab_img2.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img1.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img4.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 250,
        child: new StaggeredGridView.countBuilder(
          physics: ScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 9,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: imageList[index],
                  height: 60,
                  placeholder: (context, url) => Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(2, index.isEven ? 2 : 1);
          },
        ),
      ),
    );
  }
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imageList = [
    'https://www.ipab.gov.in/img/gallery/Image-2.jpeg',
    'https://www.ipab.gov.in/img/gallery/Image-1.jpeg',
    'https://www.ipab.gov.in/img/gallery/Image-5.jpeg',
    'https://www.ipab.gov.in/img/gallery/office.jpeg',
    'https://www.ipab.gov.in/img/gallery/court_hall.jpeg',
    'https://www.ipab.gov.in/img/gallery/court_hall2.jpeg',
    'https://www.ipab.gov.in/img/gallery/ipab_img1.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img2.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img4.jpg',
    'https://www.ipab.gov.in/img/gallery/ipab_img3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: new StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: imageList.length,
          crossAxisSpacing: 8,
          mainAxisSpacing: 9,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return Container(
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (_) => ImageDialog(
                            image: imageList[index],
                          ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: imageList[index],
                    height: 60,
                    placeholder: (context, url) => Center(
                        child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(5, index.isEven ? 6 : 4);
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ImageDialog extends StatelessWidget {
  String image;
  ImageDialog({this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
          border: new Border.all(
            color: Theme.of(context).primaryColor,
            width: 5.0,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 60,
          placeholder: (context, url) => Center(
              child: Container(
                  width: 50, height: 50, child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
