import 'package:flutter/material.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({
    Key key,
    this.photoUrl,
    this.onTap,
    this.width
  }) : super(key: key);

  final String photoUrl;
  final VoidCallback onTap;
  final double width;


  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Hero(
          tag: photoUrl,
          child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: onTap,
              child: new Image.network(photoUrl, fit: BoxFit.cover,),
            ),
          )
      ),
    );
  }


}