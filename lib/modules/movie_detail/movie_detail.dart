import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Movie Details")
      ),
    );
  }
}

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key}) : super(key: key);

  @override
  State createState() => new _MovieDetailState();


}

class _MovieDetailState extends State<MovieDetail> {
}