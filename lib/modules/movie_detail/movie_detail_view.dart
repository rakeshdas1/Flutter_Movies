import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/models/movieDetail.dart';
import 'package:flutter_app_first/modules/movie_detail/movie_detail_presenter.dart';
import 'package:flutter_app_first/widgets/ratingInfo.dart';

class MovieDetailPage extends StatelessWidget {
  int movieId;
  Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new MovieDetailView(movie),
    );
  }
}

class MovieDetailView extends StatefulWidget {
  Movie movie;

  MovieDetailView(this.movie, {Key key}) : super(key: key);

  @override
  State createState() => new _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetailView>
    implements MovieDetailContract {
  Movie movie;
  MovieDetail _movieDetail;
  MovieDetailPresenter _presenter;

  bool _isLoading;

  _MovieDetailState(this.movie) {
    _presenter = new MovieDetailPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadMovieDetails(movie.id);
  }

  @override
  void onLoadDetailsComplete(MovieDetail movie) {
    setState(() {
      _movieDetail = movie;
      _isLoading = false;
    });
  }

  @override
  void onLoadDetailsError() {
    // TODO: implement onLoadDetailsError
  }

  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              title: Text(movie.title),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Hero(
                      tag: movie.id,
                      child: new Image.network(
                        movie.posterArtUrl,
                        fit: BoxFit.cover,
                        height: _appBarHeight,
                      ))
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(<Widget>[
              RatingInfo(movie),
              _buildMovieDetails(_movieDetail)
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildMovieDetails (MovieDetail movie) {
    if (_isLoading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    else {
      return new Text(movie.overview);
    }
  }
}
