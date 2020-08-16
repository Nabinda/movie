import 'package:flutter/material.dart';
import 'package:movie/screen/animated_drawer.dart';
import 'package:movie/screen/home_screen.dart';
import 'package:movie/screen/profile_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie',
      home: AnimatedDrawer3D(
        mainPage: HomeScreen(),
        secondPage: ProfileScreen(),
      ),
    );
  }
}
