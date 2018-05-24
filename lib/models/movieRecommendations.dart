import 'dart:async';
import 'package:flutter_app_first/models/movie.dart';

class MovieRecommendations {
  final List<Movie> recommendations;

  const MovieRecommendations({this.recommendations});

  MovieRecommendations.fromJson(Map jsonMap)
      : recommendations = (jsonMap as List).map((i) {
          Movie.fromJson(i);
        }).toList();
}


abstract class MovieRecommendationsRepo {
  Future<List<Movie>> fetchMovieRecommendations(int movieId);
}

class FetchDataExceptionRec implements Exception {
  String _message;

  FetchDataExceptionRec(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
