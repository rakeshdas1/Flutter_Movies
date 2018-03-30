import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCell extends StatelessWidget {
  const MovieCell({
    Key key,
    this.title,
    this.photoUrl,
    this.onTap,
    }) : super(key: key);

  final String title;
  final String photoUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onTap,
      child: new Card(
        elevation: 2.0,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Hero(
                tag: "image",
                child: new FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: photoUrl, fit: BoxFit.contain,)),
            new Text(title, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),)
          ],
        ),
      ),
    );
  }


}