import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
class RatingInfo extends StatelessWidget {
  RatingInfo(this.movie);

  final Movie movie;

  _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];
    var ratingInt = movie.rating.toInt()/2;

    for(var i = 1; i <= ratingInt; i++) {
      var color = i <= movie.rating ? theme.accentColor : Colors.black;
      var star = Icon(
        Icons.star,
        color: color,
      );
      stars.add(star);
    }
    return new Row(children: stars);
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(movie.rating.toString(),
          style: textTheme.title.copyWith(
            fontWeight:FontWeight.w400,
            color:theme.accentColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('Rating', style: ratingCaptionStyle,),
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRatingBar(theme),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text('', style: ratingCaptionStyle,),)
      ],
    );

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding (
          padding: const EdgeInsets.only(left: 25.0),
          child: numericRating,),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: starRating,
        )
      ],
    );
  }
}