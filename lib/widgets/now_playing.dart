import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/bloc/now_playing_bloc.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/model/movie_response.dart';
import 'package:movie/screen/video_player.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movie/styles/theme.dart' as Style;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
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

  Widget _buildErrorWidget(String error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Error Occurred : $error")
        ],
      ),
    );
  }

  Widget _buildNowPlayingWidget(MovieResponse data) {
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
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          indicatorColor: Style.Colors.titleColor,
          padding: EdgeInsets.all(5.0),
          indicatorSelectorColor: Style.Colors.secondColor,
          length: movies.take(5).length,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original" +
                                      movies[index].backPoster),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Style.Colors.mainColor.withOpacity(1.0),
                                Style.Colors.mainColor.withOpacity(0.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 0.9])),
                    ),
                    //----------Play Button----------
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: IconButton(
//                        onPressed: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(controller: YoutubePlayerController(initialVideoId: movies[index].videos[0].key,flags: YoutubePlayerFlags(
//                              autoPlay: true,
//                              forceHD: true
//                          )))));
//                        },
                      onPressed: null,
                       icon: Icon(FontAwesomeIcons.playCircle,color: Style.Colors.secondColor,size: 50.0,),),
                    ),
                    //-------------Movie Title---------
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movies[index].title,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      );
    }
  }
}
