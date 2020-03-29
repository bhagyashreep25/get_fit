import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_fit/Graph.dart';

class PedometerPage extends StatefulWidget {
  final Map<DateTime,int> stepCountMap;
  PedometerPage({Key key, this.stepCountMap}): super(key: key);

  static final routeName = '/ped';
  @override
  _PedometerPageState createState() => _PedometerPageState();
}

class _PedometerPageState extends State<PedometerPage> {
  TextEditingController t;
  @override
  void initState() {
    super.initState();
    t = TextEditingController();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      resizeToAvoidBottomPadding: false,
      // backgroundColor: Colors.white,
      // backgroundColor: const Color(0xFF4C4C4C),
      backgroundColor: const Color(0xFF343434),
      body: Column(
        children: <Widget>[
          Graph(stepCountMap: widget.stepCountMap),
        ],),

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