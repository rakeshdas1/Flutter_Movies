import 'package:flutter_app_first/injection/dependency_injection.dart';
import 'package:flutter_app_first/models/movieDetail.dart';
import 'package:flutter_app_first/models/movieRecommendations.dart';

abstract class MovieDetailContract {
  void onLoadDetailsComplete(MovieDetail movie);

  void onLoadDetailsError();

  void onLoadRecommedationsComplete(List<MovieRecommendations> recommendations);

  void onLoadRecommendationsError();
}

class MovieDetailPresenter {
  MovieDetailContract _view;
  MovieDetailsRepo _detailsRepo;
  MovieRecommendationsRepo _recommendationsRepo;

  MovieDetailPresenter(this._view) {
    _detailsRepo = new Injector().movieDetailRepo;
    _recommendationsRepo = new Injector().movieRecommendationsRepo;
  }

  void loadMovieDetails(int movieId) {
    assert(_view != null);
    _detailsRepo
        .fetchMovieDetails(movieId)
        .then((movieDetails) => _view.onLoadDetailsComplete(movieDetails))
        .catchError((onError) {
      print(onError);
      _view.onLoadDetailsError();
    });
  }

  void loadMovieRecommendations(int movieId) {
    assert(_view != null);
    _recommendationsRepo
        .fetchMovieRecommendations(movieId)
        .then((movieRecommendations) {
          print(movieRecommendations.toString());
        })
            // _view.onLoadRecommedationsComplete(movieRecommendations))
        .catchError((onError) {
      print("ERR:" + onError.toString());
      _view.onLoadRecommendationsError();
    });
  }
}
