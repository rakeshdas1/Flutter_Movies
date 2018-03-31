import 'package:flutter_app_first/injection/dependency_injection.dart';
import 'package:flutter_app_first/models/movie.dart';

abstract class MovieListViewContract {
  void onLoadMoviesComplete(List<Movie> items);

  void onLoadMoviesError();
}

class MovieListPresenter {
  MovieListViewContract _view;
  MovieRepo _repo;

  MovieListPresenter(this._view) {
    _repo = new Injector().movieRepo;
  }

  void loadMovies() {
    assert(_view != null);

    _repo.fetchTopRated()
        .then((movies) => _view.onLoadMoviesComplete(movies))
        .catchError((onError) {
      print(onError);
      _view.onLoadMoviesError();
    });
  }
}
