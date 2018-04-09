import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  int movieId;
  Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(movie.title)
//      ),
      body: new MovieDetail(movie),
    );
  }
}

class MovieDetail extends StatefulWidget {
  Movie movie;

  MovieDetail(this.movie, {Key key}) : super(key: key);

  @override
  State createState() => new _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;

  _MovieDetailState(this.movie);

  @override
  Widget build(BuildContext context) {
    var hero =
        new Hero(tag: movie.id, child: new Image.network(movie.posterArtUrl));
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[new MovieHeader(movie)],
        ),
      ),
    );
  }
}

class MovieHeader extends StatelessWidget {
  Movie movie;

  MovieHeader(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
//            new Image.network(movie.posterArtUrl),
        new Hero(tag: movie.id, child: new Image.network(movie.posterArtUrl))
      ],
    );
  }
}
