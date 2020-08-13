import 'package:flutter/material.dart';
import 'package:movie/model/video_response.dart';
import 'package:movie/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesVideoBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();
  getMovieVideos(int id) async{
    VideoResponse response = await _repository.getMovieVideos(id);
    _subject.sink.add(response);
  }
  void drainStream(){
    _subject.value = null;
  }
  @mustCallSuper
  void dispose() async{
    await subject.drain();
    _subject.close();
  }
  BehaviorSubject<VideoResponse> get subject => _subject;
}
final moviesVideoBloc = MoviesVideoBloc();
