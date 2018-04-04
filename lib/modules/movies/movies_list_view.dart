import 'package:flutter/material.dart';
import 'package:flutter_app_first/models/movie.dart';
import 'package:flutter_app_first/modules/movies/movies_presenter.dart';
import 'package:meta/meta.dart';
import 'package:transparent_image/transparent_image.dart';


class MoviesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Movies"),
      ),
      body: new MovieList(),
    );
  }

}

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> implements MovieListViewContract {
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
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(movie.title + " | " + movie.id.toString())));
    })).toList();
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
                tag: "image",
                child: new FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: _movie.posterArtUrl, fit: BoxFit.contain,)),
            new Text(_movie.title, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),)
          ],
        ),
      ),
    );
  }
}
class _MovieListItem2 extends ListTile {
  _MovieListItem2({ @required Movie movie}) :
      super (
        title: new Text(movie.title),
        subtitle: new Text(movie.rating.toString()),
        leading: new CircleAvatar(
          child: new Text(movie.title[0]),
        )
      );
}