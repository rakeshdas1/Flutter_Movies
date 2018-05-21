import 'dart:async';
import 'package:flutter_app_first/models/movie.dart';

class MovieRecommendations {
  final List<Movie> recommendations;

  const MovieRecommendations({this.recommendations});

  MovieRecommendations.fromJson(Map jsonMap)
      :recommendations = (jsonMap as List).map((i) => Movie.fromJson(i)).toList();

}
abstract class MovieRecommendationsRepo {
  Future<List<MovieRecommendations>> fetchMovieRecommendations(int movieId);
}
class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}