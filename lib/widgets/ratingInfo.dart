import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
class RatingInfo extends StatelessWidget {
  RatingInfo(this.movie);

  final Movie movie;

  _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];

    for(var i = 0; i <= 5; i++) {
      var color = i <= movie.rating ? theme.accentColor : Colors.black;
    }
  }
  @override
  Widget build(BuildContext context) {

  }

}