import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie/bloc/get_search_bloc.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/model/movie_response.dart';
import 'package:movie/screen/detail_screens.dart';
import 'package:movie/styles/theme.dart' as Style;

class SearchResult extends StatefulWidget {
  final String text;
  SearchResult({Key key, @required this.text}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState(text);
}

class _SearchResultState extends State<SearchResult> {
  final String text;
  _SearchResultState(this.text);
  @override
  void initState() {
    super.initState();
    searchListBloc..getSearch(text);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: searchListBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildMoviesBySearchWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text("Error Occurred : $error")],
      ),
    );
  }

  Widget _buildMoviesBySearchWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No Movies")],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
            itemCount: movies.length,
            itemBuilder: (ctx, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(
                        builder: (context)=>MovieDetailScreen(movie: movies[index],)
                    ));
                  },
                  child: Container(
                    child: Column(
                        children: <Widget>[
//--------Movie Poster------------
                          movies[index].poster == null
                              ? Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            height: 180.0,
                            decoration: BoxDecoration(
                                color: Style.Colors.secondColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.filmOutline,
                                  color: Colors.white,
                                  size: 50.0,
                                )
                              ],
                            ),
                          )
                              : Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            height: 180.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/" +
                                            movies[index].poster),
                                    fit: BoxFit.cover),
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 100.0,
                            child: Text(movies[index].title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                  fontSize: 11.0
                              ),),
                          ),
                        ]),
                  ),
                ),
              );
            }),
      );
    }
  }
}

