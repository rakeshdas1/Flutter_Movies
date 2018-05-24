import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/models/movieDetail.dart';
import 'package:flutter_app_first/models/movieRecommendations.dart';
import 'package:flutter_app_first/modules/movie_detail/movie_detail_presenter.dart';
import 'package:flutter_app_first/widgets/ratingInfo.dart';
import 'package:transparent_image/transparent_image.dart';

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
  List<Movie> _recommendedMovies;
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
      // _isLoading = false;
    });
  }

  @override
  void onLoadDetailsError() {
    print("Error loading movie details!");
  }

  @override
  void onLoadMovieRecommendationsComplete(
      List<Movie> recommendedMovies) {
    setState(() {
      _recommendedMovies = recommendedMovies;
      _isLoading = false;
    });
  }

  @override
  void onLoadMovieRecommendationsError() {
    print("Error loading recommended movies!");
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
    if (_isLoading || movieDetail == null) {
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
                        color: Theme.of(context).accentColor, fontSize: 25.0)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movieDetail.overview),
                ),
                _buildMovieGenreChips(movieDetail),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Other movies you might like:",
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
                _buildRecommendedMoviesList(_recommendedMovies, context)
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

  Widget _buildRecommendedMoviesList(
      List<Movie> recommendedMovies, BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      List<Widget> recommendedMoviesCards = List<Widget>();

      for (var i = 0; i < recommendedMovies.length; i++) {
        recommendedMoviesCards.add(GestureDetector(
          onTap:  () => _showMovieDetailsView(context, recommendedMovies[i]),
            child: Card(
          child: Column(
            children: <Widget>[
              Hero(
                tag: recommendedMovies[i].id,
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: recommendedMovies[i].posterArtUrl,
                  fit: BoxFit.contain,
                  imageScale: 3.0,
                ),
              ),
              Text(recommendedMovies[i].title)
            ],
          ),
          elevation: 0.0,
        )));
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: recommendedMoviesCards,
        ),
      );
    }
  }

  void _showMovieDetailsView(BuildContext context, Movie movie) {
    Navigator.push(
        context,
        new MaterialPageRoute<Null>(
            settings: const RouteSettings(name: '/movieDetails'),
            builder: (BuildContext context) => new MovieDetailPage(movie)));
  }
}
