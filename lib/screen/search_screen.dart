import 'package:flutter/material.dart';
import 'package:movie/styles/theme.dart' as Style;
import 'package:movie/widgets/search_result.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();
  bool isSearched = false;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          onEditingComplete: (){
            setState(() {
              isSearched = true;
            });
          },
          style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 18),
          cursorColor: Style.Colors.secondColor,
          decoration: InputDecoration(
            focusColor: Style.Colors.mainColor,
              border: InputBorder.none,
              hoverColor: Style.Colors.secondColor,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: (){
                  setState(() {
                    isSearched = true;
                  });
                },
              ),
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              )),
          controller: _textEditingController,
        ),
      ),
      body: isSearched?SearchResult(text: _textEditingController.text,):searchFlims(),
    );
  }
  Widget searchFlims(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            child: Text("Search",style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          )
        ],
      ),
    );
  }
}
