import 'package:flutter/material.dart';

class Weatherpage extends StatefulWidget {
  @override
  _WeatherpageState createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Weather'),
      ),
    );
  }
}