import 'dart:async';
import 'package:flutter_app_first/data/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_app_first/models/movie.dart';

class MovieDataFetcher implements MovieRepo {
  static const _movieDataUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=";
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Movie>> fetchTopRated() {
    return http.get(_movieDataUrl + Constants.TMDB_API_KEY)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while fetching movies [StatusCode: $statusCode, Error: $response]");
      }

      final movieContainer = _decoder.convert(jsonBody);

      final List movieItems = movieContainer['results'];
      return movieItems.map((movie) => new Movie.fromJson(movie)).toList();
    });
  }

  @override
  Future<Movie> fetchMovieDetails(int movieId) {
    //make call to api to get move details
  }



}