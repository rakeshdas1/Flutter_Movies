import 'dart:async';

import 'package:flutter_app_first/models/movie.dart';
class MockMovieRepo implements MovieRepo {
  @override
  Future<List<Movie>> fetchTopRated() {
    return new Future.value(mockMovies);
  }

  @override
  Future<List<Movie>> fetchMovieDetails() {
    // TODO: implement fetchMovieDetails
  }
}

const mockMovies = const <Movie>[
  const Movie(
    title: "Black Panther",
    id: "284054",
    rating: 8.0,
    posterArtUrl: "http://image.tmdb.org/t/p/w500/b6ZJZHUdMEFECvGiDpJjlfUWela.jpg"
  ),
  const Movie(
      title: "Ready Player One",
      id: "333339",
      rating: 7.6,
      posterArtUrl: "http://image.tmdb.org/t/p/w500/5a7lMDn3nAj2ByO0X1fg6BhUphR.jpg"
  ),
  const Movie(
      title: "Avengers: Infinity War",
      id: "299536",
      rating: 5.8,
      posterArtUrl: "http://image.tmdb.org/t/p/w500/xmgAsda5sPNpx5ghJibJ80S7Pfx.jpg"
  )
];