import 'dart:async';

import 'package:flutter_app_first/models/movie.dart';
class MockMovieRepo implements MovieRepo {
  @override
  Future<List<Movie>> fetch() {
    return new Future.value(mockMovies);
  }
}

const mockMovies = const <Movie>[
  const Movie(
    title: "Black Panther",
    rating: 8.0,
    posterArtUrl: "http://image.tmdb.org/t/p/w500/b6ZJZHUdMEFECvGiDpJjlfUWela.jpg"
  ),
  const Movie(
      title: "Ready Player One",
      rating: 7.6,
      posterArtUrl: "http://image.tmdb.org/t/p/w500/5a7lMDn3nAj2ByO0X1fg6BhUphR.jpg"
  ),
  const Movie(
      title: "Avengers: Infinity War",
      rating: 5.8,
      posterArtUrl: "http://image.tmdb.org/t/p/w500/xmgAsda5sPNpx5ghJibJ80S7Pfx.jpg"
  )
];