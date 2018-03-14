import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Movie {
  final String title;
  final double rating;
  final String posterArtUrl;
  
  Movie.fromJson (Map jsonMap)
    : title = jsonMap['title'],
      rating = jsonMap['vote_average'].toDouble(),
      posterArtUrl = jsonMap['backdrop_path'];
}

//get the data from TMDB as a Future stream
Future<Stream<Movie>> getMovies() async {
  var url = "https://api.themoviedb.org/3/discover/movie?api_key=3768a3c9bffb43ada9868af40cd075ea&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2018";

  var client = new http.Client();

  var streamedRes = await client.send(new http.Request('get', Uri.parse(url)));

  return streamedRes.stream
          .transform(UTF8.decoder)
          .transform(JSON.decoder)
          .expand((jsonBody) => (jsonBody as Map)['results'])
          .map((jsonMovie) => new Movie.fromJson(jsonMovie));
}