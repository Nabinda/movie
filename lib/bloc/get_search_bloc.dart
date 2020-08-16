import 'package:movie/model/movie_response.dart';
import 'package:movie/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchListBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();
  getSearch(String text) async{
    MovieResponse response = await _repository.getSearch(text);
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
  BehaviorSubject<MovieResponse> get subject => _subject;
}
final searchListBloc = SearchListBloc();
