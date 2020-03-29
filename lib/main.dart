import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_fit/HomePage.dart';
import 'package:get_fit/PedometerPage.dart';

void main() => runApp(new Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  static final routes = <String, WidgetBuilder>{
    PedometerPage.routeName: (context) => Scaffold(body:SafeArea(child: PedometerPage(),)),
    HomePage.routeName: (context)=>Scaffold(body:SafeArea(child: HomePage(),))
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: _getAppTheme(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      
    );
  }

  ThemeData _getAppTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: const Color(0xFFFFFFFF),
      accentColor: const Color(0xFF93F4FE),
      textTheme: TextTheme(
        body1: TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontSize: 14
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF343434),
    );
  }
}