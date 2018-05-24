import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_first/data/constants.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app_first/models/movieRecommendations.dart';

class MovieRecommendationsFetcher implements MovieRecommendationsRepo {
  static const _apiBase = "https://api.themoviedb.org/3/movie/";
  static const _movieRecommendationEndpoint = "/recommendations";
  final JsonDecoder _decoder = new JsonDecoder();
  @override
  Future<List<Movie>> fetchMovieRecommendations(int movieId) {
    var _recommendationsUrl = _apiBase +
        movieId.toString() +
        _movieRecommendationEndpoint +
        "?api_key=" +
        Constants.TMDB_API_KEY;
    return http.get(_recommendationsUrl).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataExceptionRec(
            "Error while fetching movie recommendations [StatusCode: $statusCode, Error: $response]");
      }

      final recommendationsContainer = _decoder.convert(jsonBody);

      final List recommendationItems = recommendationsContainer['results'];

      return recommendationItems.map((f) => Movie.fromJson(f)).toList();
    });
  }
}
