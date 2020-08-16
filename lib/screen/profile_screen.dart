import 'package:flutter/material.dart';
import 'package:movie/styles/theme.dart' as Style;


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.9,
      color: Style.Colors.mainColor,
        child: Text("Hidden Drawer"),
    );
  }
}
