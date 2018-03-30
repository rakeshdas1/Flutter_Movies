import 'package:flutter_app_first/data/movie_data_fetcher.dart';
import 'package:flutter_app_first/data/movie_data_mock.dart';
import 'package:flutter_app_first/models/movie.dart';


enum Flavor {
  MOCK,
  PROD
}

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  MovieRepo get movieRepo {
    switch(_flavor) {
      case Flavor.MOCK: return new MockMovieRepo();
      default: return new MovieDataFetcher();
    }
  }
}