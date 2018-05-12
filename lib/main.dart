import 'package:flutter/material.dart';
import 'package:flutter_app_first/injection/dependency_injection.dart';
import 'package:flutter_app_first/models/movie.dart' as movies;
import 'package:flutter_app_first/modules/movie_list/movies_list_view.dart';
import 'package:flutter_app_first/network/getData.dart';
import 'package:flutter_app_first/widgets/movieCell.dart';
import 'package:flutter_app_first/widgets/photoTile.dart';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Movies",
      theme: new ThemeData(
          primarySwatch: Colors.red, primaryColor: Colors.deepOrange),
      home: new MoviesListPage(),
      routes: <String, WidgetBuilder>{
        '/movieDetails': (BuildContext context) => new MoviesListPage(),
      },
    );
  }
}

class MoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  var movieList = <movies.Movie>[];
  _getMovies() async {
    final stream = await getMovies();
    stream.listen((movie) => setState(() => movieList.add(movie)));
  }

  @override
  initState() {
    super.initState();
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text("Movies"),
        ),
        body: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          children: movieList.map((movie) => new MovieWidget(movie)).toList(),
        ));
  }
}

class MovieWidget extends StatelessWidget {
  MovieWidget(this.movie);
  final movies.Movie movie;

  @override
  Widget build(BuildContext context) {
    var cardTile = new MovieCell(
      title: movie.title,
      photoUrl: movie.posterArtUrl,
    );
    return cardTile;
  }
}
