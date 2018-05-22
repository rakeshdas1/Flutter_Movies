import 'dart:async';
import 'package:flutter_app_first/models/movie.dart';

class MovieRecommendations {
  final List<Movie> recommendations;

  const MovieRecommendations({this.recommendations});

  MovieRecommendations.fromJson(Map jsonMap)
      : recommendations = (jsonMap as List).map((i) {
          RecommendedMovie.fromJson(i);
        }).toList();
}

class RecommendedMovie {
  final String title;
  final int id;
  final String posterArtUrl;

  const RecommendedMovie ({this.title, this.id, this.posterArtUrl});
  
  RecommendedMovie.fromJson(Map jsonMap) 
      : title = jsonMap['title'],
        id = jsonMap['id'],
        posterArtUrl = "http://image.tmdb.org/t/p/w342" + jsonMap['poster_path'];
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
