import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_first/data/constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app_first/models/movieDetail.dart';

class MovieDetailsFetcher implements MovieDetailsRepo {
  static const _movieDetailsUrl = "https://api.themoviedb.org/3/movie/";
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<MovieDetail> fetchMovieDetails(int movieId) {
    return http.get(_movieDetailsUrl + movieId.toString() + "?api_key=" + Constants.TMDB_API_KEY)
        .then((http.Response response) {
          final String jsonBody = response.body;
          final statusCode = response.statusCode;

          if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException(
                "Error while fetching movies [StatusCode: $statusCode, Error: $response]");
          }

          final movieDetailsContainer = _decoder.convert(jsonBody);

          return new MovieDetail.fromJson(movieDetailsContainer);
    });
  }

}