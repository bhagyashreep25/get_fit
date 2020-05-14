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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          // GestureDetector(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          //     child: Card(
          //       elevation: 10.0,
          //       child: Container(
          //         padding: EdgeInsets.symmetric(vertical: 15),
          //         height: height*0.11,
          //         width: width,
          //         color: const Color(0xFF4C4C4C),
          //         child: Column(
          //           children: <Widget>[
          //             Text('Phone Usage',
          //               style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor)
          //             ),
          //             Padding(padding: EdgeInsets.only(bottom: 7),),
          //             Text('Tap to see screen time usage',
          //               style: TextStyle(fontSize: 12, color: Colors.white)
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenUsage()));
          //   },
          // )
        ],
        ),
      
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF262626),
      centerTitle: true,
      title: Text('G E T   F I T',
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        ),
    );
  }
}