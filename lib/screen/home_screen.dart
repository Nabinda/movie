
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/screen/profile_screen.dart';
import 'package:movie/screen/search_screen.dart';
import 'package:movie/styles/theme.dart' as Style;
import 'package:movie/widgets/genres.dart';
import 'package:movie/widgets/now_playing.dart';
import 'package:movie/widgets/person.dart';
import 'package:movie/widgets/top_movies.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text("Movie"),
        actions: <Widget>[
          IconButton(icon: Icon(EvaIcons.searchOutline,color: Colors.white,),onPressed: (){
            Navigator.push(context,MaterialPageRoute(
                builder: (context)=>SearchScreen()));
          },),
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          TopMovies()
        ],
      ),
    );
  }
}
