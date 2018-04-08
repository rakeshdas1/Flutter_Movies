import 'package:flutter_app_first/models/movieDetail.dart';

abstract class MovieDetailContract {
  void onLoadDetailsComplete(MovieDetail movie);

  void onLoadDetailsError();
}

class MovieDetailPresenter {
  MovieDetailContract _view;

}