import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie/bloc/get_cast_bloc.dart';
import 'package:movie/model/cast.dart';
import 'package:movie/model/cast_response.dart';
import 'package:movie/styles/theme.dart' as Style;

class Casts extends StatefulWidget {
  final int id;
  Casts({Key key, @required this.id}) : super(key: key);
  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;
  _CastsState(this.id);
  @override
  void initState() {
    super.initState();
    castBloc..getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
    castBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "CASTS",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse>(
          stream: castBloc.subject.stream,
          builder: (context, AsyncSnapshot<CastResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildCastsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
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

  Widget _buildCastsWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    print(casts.length.toString());
    return Container(
      height: 160,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length,

          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    casts[index].img==null?
                  Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                  ),
                    child: Icon(EvaIcons.person,color: Style.Colors.secondColor,
                    size: 70,),
                ):
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(fit:BoxFit.cover,image: NetworkImage("https://image.tmdb.org/t/p/w300/"+casts[index].img))
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(casts[index].name,maxLines:2,style: TextStyle(
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 10
                    ),),
                    SizedBox(height: 10.0,),
                    Text(casts[index].character,textAlign: TextAlign.center,style: TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10
                    ),)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
