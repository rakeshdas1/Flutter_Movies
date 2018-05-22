import '../data/movie_data_fetcher.dart';
import '../data/movie_data_mock.dart';
import '../models/movie.dart';
import '../data/movie_detail/movie_details_fetcher.dart';
import '../models/movieDetail.dart';
import '../data/movie_recommendations/movie_recommendations_fetcher.dart';
import '../models/movieRecommendations.dart';


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
  MovieDetailsRepo get movieDetailRepo {
    switch(_flavor) {
      default: return new MovieDetailsFetcher();
    }
  }
  MovieRecommendationsRepo get movieRecommendationsRepo {
    switch(_flavor) {
      default: return MovieRecommendationsFetcher();
    }
  }

}