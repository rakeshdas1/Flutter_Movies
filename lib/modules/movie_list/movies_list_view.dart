import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/modules/movie_detail/movie_detail_view.dart';
import 'package:flutter_app_first/modules/movie_list/movies_presenter.dart';
import 'package:transparent_image/transparent_image.dart';


class MoviesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Movies"),
      ),
      body: new MovieListView(),
    );
  }

}

class MovieListView extends StatefulWidget {
  MovieListView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MovieListState();
}

class _MovieListState extends State<MovieListView> implements MovieListViewContract {
  MovieListPresenter _presenter;

  List<Movie> _movies;

  bool _isLoading;


  _MovieListState() {
    _presenter = new MovieListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadMovies();
  }
  @override
  void onLoadMoviesComplete(List<Movie> items) {
    setState(() {
      _movies = items;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if(_isLoading) {
      widget = new Center(
        child: new Padding(
            padding:const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new CircularProgressIndicator(),
        ),
      );
    }
    else {
      widget = new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          children: _buildMovieList()
      );
    }
    return widget;
  }


  @override
  void onLoadMoviesError() {
    // TODO: implement onLoadMoviesError
  }

  List<_MovieListItem> _buildMovieList() {
    return _movies.map((movie) => new _MovieListItem(movie, (){
//      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(movie.title + " | " + movie.id.toString())));
        _showMovieDetailsView(context, movie);
    })).toList();

  }

  void _showMovieDetailsView(BuildContext context, Movie movie) {
    Navigator.push(context, new MaterialPageRoute<Null>(
        settings: const RouteSettings(name: '/movieDetails'),
        builder: (BuildContext context) => new MovieDetailPage(movie)
    ));
  }
}

class _MovieListItem extends StatelessWidget {
  final Movie _movie;
  final _onTap;
  _MovieListItem(this._movie, this._onTap);


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _onTap,
      child: new Card(
        elevation: 2.0,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Hero(
                tag: _movie.id,
                child: new FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: _movie.backgroundArtUrl, fit: BoxFit.contain,)),
            new Text(_movie.title, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),)
          ],
        ),
      ),
    );
  }
}

