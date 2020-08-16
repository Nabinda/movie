import 'package:dio/dio.dart';
import 'package:movie/model/cast_response.dart';
import 'package:movie/model/genre_response.dart';
import 'package:movie/model/movie_detail_response.dart';
import 'package:movie/model/movie_response.dart';
import 'package:movie/model/person_response.dart';
import 'package:movie/model/video_response.dart';

class MovieRepository {
  final String apiKey = "9af920822b83947ff68699a0953d8ebf";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = "$mainUrl/movie/top_rated";
  var getMoviesUrl = "$mainUrl/discover/movie";
  var getPlayingUrl = "$mainUrl/movie/now_playing";
  var getGenreUrl = "$mainUrl/genre/movie/list";
  var getPersonUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieResponse.withError("$error");
    }
  }
  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
      await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieResponse.withError("$error");
    }
  }
  Future<GenreResponse> getGenre() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
      await _dio.get(getGenreUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return GenreResponse.withError("$error");
    }
  }
  Future<PersonResponse> getPerson() async {
    var params = {"api_key": apiKey};
    try {
      Response response =
      await _dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return PersonResponse.withError("$error");
    }
  }
  Future<MovieResponse> getMoviesByGenre(int id) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1,"with_genres":id};
    try {
      Response response =
      await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieResponse.withError("$error");
    }
  }
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
      await _dio.get(movieUrl+"/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }
  Future<CastResponse> getCasts(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
      await _dio.get(movieUrl+"/$id"+"/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return CastResponse.withError("$error");
    }
  }
  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
      await _dio.get(movieUrl+"/$id"+"/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieResponse.withError("$error");
    }
  }
  Future<MovieResponse> getSearch(String text) async {
    var params = {"api_key": apiKey, "language": "en-US","query":text,"page": 1,};
    try {
      Response response =
      await _dio.get(mainUrl+"/search/movie", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return MovieResponse.withError("$error");
    }
  }
  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
      await _dio.get(movieUrl+"/$id"+"/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception Occurred:$error StackTrace:$stacktrace");
      return VideoResponse.withError("$error");
    }
  }
}
