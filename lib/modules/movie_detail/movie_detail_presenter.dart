import 'package:flutter_app_first/injection/dependency_injection.dart';
import 'package:flutter_app_first/models/movieDetail.dart';

abstract class MovieDetailContract {
  void onLoadDetailsComplete(MovieDetail movie);

  void onLoadDetailsError();
}

class MovieDetailPresenter {
  MovieDetailContract _view;
  MovieDetailsRepo _repo;

  MovieDetailPresenter(this._view) {
    _repo = new Injector().movieDetailRepo;
  }

  void loadMovieDetails(int movieId) {
    assert(_view != null);

    _repo.fetchMovieDetails(movieId)
      .then((movieDetails) => _view.onLoadDetailsComplete(movieDetails))
      .catchError((onError) {
        print(onError);
        _view.onLoadDetailsError();
    });
  }
}