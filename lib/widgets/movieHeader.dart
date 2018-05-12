import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';

class MovieHeader extends StatelessWidget {
  Movie movie;

  MovieHeader(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Hero(tag: movie.id, child: new Image.network(movie.posterArtUrl))
      ],
    );
  }
}