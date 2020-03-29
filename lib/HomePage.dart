import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_fit/PedometerCard.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String goal="10000";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      // backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Padding(
            // child: GestureDetector(
            child: PedometerCard(),
            // onTap: (){
            //   Navigator.of(context).pushNamed("/ped");
            //   // Navigator.push(context, 
            //   //   MaterialPageRoute(builder: (context) => PedometerPage()));
            // },
          // ),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          ),
        ],
        ),
      
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF262626),
      centerTitle: true,
      title: Text('GET FIT',
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        ),
    );
  }
}