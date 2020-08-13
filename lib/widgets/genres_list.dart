import 'package:flutter/material.dart';
import 'package:movie/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie/model/genre.dart';
import 'package:movie/styles/theme.dart' as Style;
import 'package:movie/widgets/genres_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  GenresList({Key key,@required this.genres});
  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin{
  final List<Genre> genres;
  TabController _tabController;
  _GenresListState(this.genres);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this,length: genres.length);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        moviesByGenreBloc..drainStream();
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Style.Colors.mainColor,
              bottom: TabBar(
                controller: _tabController,
                labelColor: Style.Colors.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                isScrollable: true,
                tabs: genres.map((Genre genre){
                  return Container(
                    padding: EdgeInsets.only(top: 10.0,bottom: 15.0),
                    child: Text(genre.name,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                  );
                }).toList(),
              ),
            ),
            preferredSize: Size.fromHeight(50.0),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(genreId: genre.id,);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
