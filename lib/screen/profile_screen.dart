import 'package:flutter/material.dart';
import 'package:movie/styles/theme.dart' as Style;


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Style.Colors.mainColor,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Profile.PNG"),
                  radius: 80.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nidhisha",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Iesha",
                  style: TextStyle(
                    fontSize: 20,
                    color: Style.Colors.titleColor,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white,
                    height: 15.0,
                  ),
                ),
                Card(
                  elevation: 5,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.call,
                      size: 20,
                      color: Style.Colors.secondColor,
                    ),
                    title: Text(
                      "+91-7387101216",
                      style: TextStyle(
                        fontSize: 15,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      size: 20,
                      color: Style.Colors.secondColor,
                    ),
                    title: Text(
                      "cloudystars25@gmail.com",
                      style: TextStyle(
                        fontSize: 15,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
