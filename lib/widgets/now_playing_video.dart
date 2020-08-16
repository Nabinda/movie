import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/bloc/get_movie_videos_bloc.dart';
import 'package:movie/model/video.dart';
import 'package:movie/model/video_response.dart';
import 'package:movie/screen/video_player.dart';
import 'package:movie/styles/theme.dart' as Style;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NowPlayingVideo extends StatefulWidget {
  final int id;
  NowPlayingVideo({Key key, @required this.id}) : super(key: key);
  @override
  _NowPlayingVideoState createState() => _NowPlayingVideoState(id);
}

class _NowPlayingVideoState extends State<NowPlayingVideo> {
  final int id;
  _NowPlayingVideoState(this.id);
  @override
  void initState() {
    super.initState();
    moviesVideoBloc..getMovieVideos(id);
  }

  @override
  void dispose() {
    super.dispose();
    moviesVideoBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VideoResponse>(
      stream: moviesVideoBloc.subject.stream,
      builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildVideoWidget(snapshot.data);
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
        children: <Widget>[
          Text(
            "Error Occurred : $error",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    return IconButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayer(
                    controller: YoutubePlayerController(
                        initialVideoId: videos[0].key,
                        flags: YoutubePlayerFlags(
                            autoPlay: true, forceHD: true)))));
      },
      icon: Icon(
        FontAwesomeIcons.playCircle,
        color: Style.Colors.secondColor,
        size: 50.0,
      ),
    );
  }
}
