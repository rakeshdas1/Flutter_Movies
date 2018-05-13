import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/widgets/movieHeader.dart';
import 'package:flutter_app_first/widgets/ratingInfo.dart';

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
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MovieHeader(movie),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(movie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  )),
            ),
            RatingInfo(movie),
          ],
        ),
      ),
    );
  }
}
