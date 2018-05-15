import 'package:flutter/material.dart';
import 'package:flutter_app_first/injection/dependency_injection.dart';
import 'package:flutter_app_first/modules/movie_list/movies_list_view.dart';

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
