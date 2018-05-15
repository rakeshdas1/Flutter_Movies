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
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                      tag: movie.id,
                      child: Image.network(
                        movie.posterArtUrl,
                        fit: BoxFit.cover,
                        height: _appBarHeight,
                      ))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              RatingInfo(movie),
              _buildMovieDetails(_movieDetail),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildMovieDetails(MovieDetail movie) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.tagline,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movie.overview),
                )
              ]));
    }
  }
}
