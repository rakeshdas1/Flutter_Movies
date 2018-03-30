import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_app_first/models/movie.dart';

class MovieDataFetcher implements MovieRepo {
  static const _movieDataUrl = "https://api.themoviedb.org/3/discover/movie?api_key=3768a3c9bffb43ada9868af40cd075ea&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2018";
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Movie>> fetch() {
    return http.get(_movieDataUrl)
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

}