import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/models/movieDetail.dart';
import 'package:flutter_app_first/models/movieRecommendations.dart';
import 'package:flutter_app_first/modules/movie_detail/movie_detail_presenter.dart';
import 'package:flutter_app_first/widgets/ratingInfo.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  final Movie movie;

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
  List<MovieRecommendations> _recommendations;
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
    _presenter.loadMovieRecommendations(movie.id);
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

  @override
  void onLoadRecommedationsComplete(
      List<MovieRecommendations> recommendations) {
        print(recommendations.length);
    setState(() {
      _recommendations = recommendations;
    });
  }

  @override
  void onLoadRecommendationsError() {
    print("recommendations error");
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

  Widget _buildMovieDetails(MovieDetail movieDetail) {
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
                Text(movieDetail.tagline,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 25.0
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movieDetail.overview),
                ),
                _buildMovieGenreChips(movieDetail),
                _buildMovieRecommendations(_recommendations),
              ]));
    }
  }

  Widget _buildMovieGenreChips(MovieDetail movieDetail) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      List<Widget> chips = List<Widget>();
      for (var i = 0; i < movieDetail.genres.length; i++) {
        chips.add(Chip(
          avatar: Icon(
            Icons.movie,
            color: Colors.red,
          ),
          label: Text(movieDetail.genres[i].genre),
          padding: EdgeInsets.all(12.0),
        ));
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: chips,
        ),
      );
    }
  }

  Widget _buildMovieRecommendations(
      List<MovieRecommendations> recommendations) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Row(
        // children: recommendations.map((f) => Text(f.recommendations[0].title)).toList(),
        children: <Widget>[Text("ME")],
      );
    }
  }
}
