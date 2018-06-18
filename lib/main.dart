import 'dart:convert';

import 'package:flutter/material.dart';
import 'user_profile.dart';
import 'maps_page.dart';
import 'weather_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PazarCim',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final mAppBar = new AppBar(
    title: new Text("Pazarcim"),
    leading: new IconButton(
      icon: new Icon(Icons.menu),
      onPressed: (){
        
      },
    ),

    actions: <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: (){},
      ),

      new IconButton(
        icon: new Icon(Icons.favorite),
        onPressed: (){
          
        },
      ),

      new PopupMenuButton(
        itemBuilder: (BuildContext context){

        },
      )

    ],
  );


  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: mAppBar,
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[

              new ListTile(
                leading: new Icon(Icons.person),
                title: new Text("Profile"),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile()));
                },
              ),

              new ListTile(
                leading: new Icon(Icons.map),
                title: new Text('Get Directions'),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=> new MapsPage()));
                },
              ),

              new ListTile(
                leading: new Icon(Icons.cloud),
                title: new Text('Weather'),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Weatherpage()));
                },
              )


            ],
          ),
        ),
        body: new Center(
          child:new FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return new Center(
                  child: new Text(snapshot.data.description,style: new TextStyle(fontSize: 25.0),),
                );
              }else{
                return new Center(
                  child: new Text(snapshot.error.toString()),
                );
              }
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<Post> getData() async{
    var res = await http.get("https://jsonplaceholder.typicode.com/posts/1");

    final responseJSON = json.decode(res.body);
    return new Post.fromJson(responseJSON);
  }
}

class Post {
  String title,description;
  int id,userId;

  Post({Key key,this.id,this.description,this.title,this.userId});

  factory Post.fromJson(Map<String,dynamic> json){
    return new Post(
      description: json['body'],
      id: json['id'],
      title: json['title'],
      userId: json['userId']
      );
  }
}