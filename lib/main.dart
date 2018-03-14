import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'movies.dart' as movies;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MoviesPage(),
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
    final stream = await movies.getMovies();
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
        children: movieList.map((movie) => new MovieWidget(movie)).toList(),
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  MovieWidget(this.movie);
  final movies.Movie movie;


  @override
  Widget build(BuildContext context) {

    //get rating color
    var ratingColor = Color.lerp(Colors.brown, Colors.yellow, movie.rating/10);

    var listTile = new ListTile(
      leading: new Image.network("https://image.tmdb.org/t/p/w92/" + movie.posterArtUrl, fit: BoxFit.cover,),
      title: new Text(movie.title),
      subtitle: new Text(movie.rating.toString(), style: new TextStyle(color: ratingColor),),
    );
    return listTile;
  }
  
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup new gen"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider(color: Colors.blue);

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(
              () {
            if (alreadySaved) {
              _saved.remove(pair);
            }
            else {
              _saved.add(pair);
            }
          },
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        final tiles = _saved.map((pair) {
          return new ListTile(
            title: new Text(pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
        );
        final divided = ListTile.divideTiles(context: context, tiles: tiles)
            .toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved'),
          ),
          body: new ListView(children: divided),
        );
      },
      ),
    );
  }
}